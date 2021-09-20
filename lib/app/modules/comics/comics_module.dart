import 'package:desafio_marvel/app/repositories/character_repo.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'comics_controller.dart';
import 'comics_page.dart';

class ComicsModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => CharacterRepository()),
        Bind((i) => ComicsController(i.get<CharacterRepository>())),
      ];

  @override
  List<Router> get routers => [
        Router('/:id',
            child: (_, args) => ComicsPage(
                  id: args.params['id'],
                )),
      ];

  static Inject get to => Inject<ComicsModule>.of();
}
