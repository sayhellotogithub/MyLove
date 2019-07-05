import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mylove/config/application.dart';
import 'package:mylove/constant/theme.dart';
import 'package:mylove/eventbus/event_bus.dart';
import 'package:mylove/generated/i18n.dart';
import 'package:mylove/model/state_model/main_state_model.dart';
import 'package:mylove/page/loading_page.dart';
import 'package:mylove/route/router.dart';
import 'package:mylove/route/routes.dart';
import 'package:mylove/util/sp_util.dart';
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
  Locale _locale = const Locale('en', '');

  Function(Locale) localeChange;

  @override
  void initState() {
    super.initState();
    mainStateModel = MainStateModel();
    localeChange = (locale) {
      setState(() {
        _locale = locale;
      });
    };
    //在其它地方调用切换语言
    localeChange(Locale('zh', ''));
    SpUtil.getInstance();
    Application.eventBus = EventBus();
    final Router router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
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
              debugShowCheckedModeBanner: false,
              // 去除 DEBUG 标签
              theme: ThemeData(
                  platform: TargetPlatform.iOS,
                  primaryColor: themeList[model.themeIndex != null
                      ? model.themeIndex
                      : widget.themeIndex]),
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              supportedLocales: S.delegate.supportedLocales,
//              localeResolutionCallback: S.delegate.resolution(
//                  fallback: const Locale('en', '')),

              home: Builder(builder: (BuildContext context) {
                return Localizations.override(
                    context: context, locale: _locale, child: LoadingPage());
              },),
              // onGenerateRoute: Application.router.generator,
            );
          },

        ));
  }
}