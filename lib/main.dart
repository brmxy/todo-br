import 'package:flutter/services.dart';
import 'package:todo/constants/index.dart';
import 'package:todo/index.dart';
import 'package:todo/pages/index.dart';
import 'package:todo/providers/index.dart';
import 'package:todo/widgets/index.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => ProjectProvider()),
      ],
      child: Builder(
        builder: (context) {
          Provider.of<ThemeProvider>(
            context,
            listen: false,
          ).setInitialTheme();

          return FutureBuilder(
            future: _loading(),
            builder: (context, snapshot) {
              final themeProvider = Provider.of<ThemeProvider>(
                context,
                listen: true,
              );

              if (snapshot.hasData) {
                return MaterialApp(
                  title: 'Todo Br',
                  debugShowCheckedModeBanner: false,
                  themeMode:
                      themeProvider.currentTheme == ActiveTheme.DARK_THEME
                          ? ThemeMode.dark
                          : ThemeMode.light,
                  theme: kThemeLight,
                  darkTheme: kThemeDark,
                  color: Color(0xFF171717),
                  scrollBehavior: ScrollBehavior().copyWith(
                    physics: BouncingScrollPhysics(),
                  ),
                  routes: {
                    '/': (context) => HomePage(),
                    '/setting': (context) => SettingPage(),
                  },
                  builder: (context, route) {
                    return route!;
                  },
                );
              } else {
                return CustomCircularProgressIndicator();
              }
            },
          );
        },
      ),
    );
  }

  Future<bool> _loading() {
    return Future.delayed(Duration(milliseconds: 5000)).then((value) => true);
  }
}
