import 'package:desafio_marvel/app/modules/home/home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:desafio_marvel/app/modules/home/home_page.dart';
import 'package:desafio_marvel/app/repositories/character_repo.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => CharacterRepository()),
        Bind((i) => HomeController(i.get<CharacterRepository>())),
      ];

  @override
  List<Router> get routers => [
        Router(Modular.initialRoute, child: (_, args) => HomePage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
