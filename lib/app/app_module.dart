import 'package:desafio_marvel/app/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart' as ModularRouter;
import 'package:desafio_marvel/app/app_widget.dart';
import 'package:desafio_marvel/app/modules/comics/comics_module.dart';

import 'package:desafio_marvel/app/modules/home/home_module.dart';

class AppModule extends ModularRouter.MainModule {
  @override
  List<ModularRouter.Bind> get binds => [
        ModularRouter.Bind((i) => AppController()),
      ];

  @override
  List<ModularRouter.Router> get routers => [
        ModularRouter.Router(ModularRouter.Modular.initialRoute,
            module: HomeModule()),
        ModularRouter.Router('/comics', module: ComicsModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static ModularRouter.Inject get to => ModularRouter.Inject<AppModule>.of();
}
