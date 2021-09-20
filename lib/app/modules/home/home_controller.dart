import 'package:desafio_marvel/app/models/character_model.dart';
import 'package:desafio_marvel/app/repositories/character_repo.dart';
import 'package:mobx/mobx.dart';

part 'home_controller.g.dart';

class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final CharacterRepository repository;

  _HomeControllerBase(this.repository);

  Future fetchChar(String startsWith) async {
    return await repository.fetchCharactersByStartsWith(startsWith);
  }

  Future getCharacter(int page) async {
    return await repository.getAllCharacters(page);
  }

  @observable
  List<Character> favorites = [];

  @observable
  String search = '';
  @action
  setSearch(String value) => search = value;
}
