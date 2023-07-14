import 'package:calculator/di/di.dart';
import 'package:calculator/home_screen.dart';
import 'package:calculator/theme/app_themes.dart';
import 'package:calculator/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocator();
  runApp(
    MyApp(
      themeProvider: locator.get<ThemeProvider>(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final ThemeProvider themeProvider;

  const MyApp({
    super.key,
    required this.themeProvider,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => themeProvider,
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Calculator',
            theme: AppThemes.light,
            darkTheme: AppThemes.dark,
            themeMode: value.isDark ? ThemeMode.dark : ThemeMode.light,
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
