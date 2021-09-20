import 'package:desafio_marvel/app/repositories/character_repo.dart';
import 'package:mobx/mobx.dart';

part 'comics_controller.g.dart';

class ComicsController = _ComicsControllerBase with _$ComicsController;

abstract class _ComicsControllerBase with Store {
  final CharacterRepository repository;

  _ComicsControllerBase(this.repository);

  Future comicsByChar(String id) async {
    return await repository.comicsByCharacter(id);
  }
}
