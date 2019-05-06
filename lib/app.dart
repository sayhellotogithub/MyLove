import 'package:flutter/material.dart';
import 'package:mylove/constant/theme.dart';
import 'package:mylove/model/state_model/main_state_model.dart';
import 'package:mylove/page/home/home_page.dart';
import 'package:scoped_model/scoped_model.dart';


class App extends StatefulWidget {
  final int themeIndex;

  App(this.themeIndex);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  dynamic subscription;
  MainStateModel mainStateModel;

  @override
  void initState() {
    super.initState();
    mainStateModel = MainStateModel();
//    Application.eventBus = EventBus();
//    final Router router = Router();
//    Routes.configureRoutes(router);
//    Application.router = router;
//    TimeUtil.initLocaleLanguage();
//    initListener();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainStateModel>(
        model: mainStateModel,
        child: ScopedModelDescendant<MainStateModel>(
          builder: (context, child, model) {
            return MaterialApp(
              debugShowCheckedModeBanner: false, // 去除 DEBUG 标签
              theme: ThemeData(
                  platform: TargetPlatform.iOS,
                  primaryColor: themeList[model.themeIndex != null
                      ? model.themeIndex
                      : widget.themeIndex]),
              home: HomePage(),
             // onGenerateRoute: Application.router.generator,
            );
          },
        ));
  }
}