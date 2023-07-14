import 'package:calculator/theme/theme_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

initLocator() async {
  // shared preferences
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton(sharedPreferences);

  // theme provider
  locator.registerSingleton<ThemeProvider>(ThemeProvider(sharedPreferences));
}
