import 'dart:convert';

import 'package:desafio_marvel/app/models/character_model.dart';
import 'package:http/http.dart' as http;
import 'package:desafio_marvel/app/models/comics_model.dart';
import 'package:desafio_marvel/constants/url.dart';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:mobx/mobx.dart';

final publicKey = Keys.publicKey;

generateMd5(String data) {
  var content = new Utf8Encoder().convert(data);
  var md5 = crypto.md5;
  var digest = md5.convert(content);
  return hex.encode(digest.bytes);
}

final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
final hash =
    generateMd5(timestamp + Keys.privateKey + Keys.publicKey).toString();

class CharacterRepository {
  Future<List<Character>> fetchCharactersByStartsWith(String startsWith) async {
    print(startsWith);
    String url = 'https://gateway.marvel.com:443/v1/public/characters?' +
        'nameStartsWith=$startsWith&' +
        'ts=$timestamp&' +
        'apikey=$publicKey&' +
        'hash=$hash';
    print(url);
    var response;
    List<Character> characters = [];

    if (startsWith != null) {
      response = await http.get(url);

      if (response.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(response.body)['data'];

        for (var item in body['results']) {
          Character char = Character.fromJson(item);
          characters.add(char);
        }
      }
    }

    return characters;
  }

  Future<List<Character>> getAllCharacters(int page) async {
    String url =
        'https://gateway.marvel.com:443/v1/public/characters?ts=${timestamp}&apikey=${publicKey}&hash=${hash}&offset=$page&limit=20';
    List<Character> characters = [];
    var response;
    response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body)['data'];

      for (var item in body['results']) {
        Character char = Character.fromJson(item);
        characters.add(char);
      }
    }

    return characters;
  }

  Future<List<Comics>> comicsByCharacter(String charId) async {
    String url =
        'https://gateway.marvel.com:443/v1/public/characters/$charId/comics?' +
            'ts=$timestamp&' +
            'apikey=$publicKey&' +
            'hash=$hash';

    var response = await http.get(url);

    List<Comics> comics = [];

    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body)['data'];

      for (var item in body['results']) {
        Comics comic = Comics.fromJson(item);
        comics.add(comic);
      }
    }

    return comics;
  }
}
