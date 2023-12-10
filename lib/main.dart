import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fun_house_store/firebase_options.dart';
import 'package:fun_house_store/provider/auth_provider.dart';
import 'package:fun_house_store/provider/settings_provider.dart';
import 'package:fun_house_store/shared_prefrences/shared_prrefrences.dart';
import 'package:fun_house_store/ui/component/themedata.dart';
import 'package:fun_house_store/ui/home_screen/home_screen.dart';
import 'package:fun_house_store/ui/home_screen/list_screen/edit_category.dart';
import 'package:fun_house_store/ui/item_screen/list_item/edit_item.dart';
import 'package:fun_house_store/ui/item_screen/list_item/listitem_screen.dart';
import 'package:fun_house_store/ui/login_screen/loginscreen.dart';
import 'package:fun_house_store/ui/register_screen/registerscreen.dart';
import 'package:fun_house_store/ui/spalsh_screen/spalsh_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding();
  SharedPrefs.prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<SettingsProvider>(create: (context) => SettingsProvider()..init(),),
    ChangeNotifierProvider<AuthProviderr>(create: (context) => AuthProviderr(),)
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fun House Store',
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      themeMode: provider.themeMode,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        ItemListScreen.routeName: (context) => const ItemListScreen(),
        EditCategory.routeName: (context) => EditCategory(),
        EditItem.routeName: (context) => EditItem(),
      },
    );
  }
}
