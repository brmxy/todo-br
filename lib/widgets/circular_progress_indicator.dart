import 'package:todo/index.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(
      context,
      listen: true,
    );
    return Center(
      child: Container(
        width: 40.0,
        height: 40.0,
        child: CircularProgressIndicator(
          color: themeProvider.currentTheme == ActiveTheme.DARK_THEME
              ? Color(0xFFEDEDED)
              : Color(0xFF444444),
        ),
      ),
    );
  }
}
