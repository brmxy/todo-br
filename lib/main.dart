import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants/theme.dart';
import 'package:todo/pages/home.dart';
import 'package:todo/pages/setting.dart';
import 'package:todo/providers/project_provider.dart';
import 'package:todo/providers/theme_provider.dart';

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
          final themeProvider = Provider.of<ThemeProvider>(
            context,
            listen: true,
          );

          return MaterialApp(
            title: 'Todo Br',
            debugShowCheckedModeBanner: false,
            themeMode: themeProvider.currentTheme == ActiveTheme.DARK_THEME
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
        },
      ),
    );
  }
}
