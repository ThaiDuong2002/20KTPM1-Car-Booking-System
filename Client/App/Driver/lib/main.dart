import 'package:driver/global/languages/base_language.dart';
import 'package:driver/global/models/language/language_model.dart';
import 'package:driver/global/themes/app_theme.dart';
import 'package:driver/modules/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<LanguageModel> localeLanguageList = [];
late SharedPreferences sharedPref;
late BaseLanguage language;

void main() async {
  // sharedPref = await SharedPreferences.getInstance();
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Navigation Basics',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}
