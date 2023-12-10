import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';
import '../../provider/settings_provider.dart';
import '../home_screen/home_screen.dart';
import '../login_screen/loginscreen.dart';


class SplashScreen extends StatefulWidget {
  static const String routeName = 'splashScreen';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    var setting =Provider.of<SettingsProvider>(context);
    Future.delayed(const Duration(seconds: 2),(){
      login();
    });
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(setting.themeMode == ThemeMode.light ? 'assets/images/splash.png' : 'assets/images/splashdark.png'), fit: BoxFit.fill)),
    );
  }

  void login() async {
    var authProvider = Provider.of<AuthProviderr>(context, listen: false);

    if (FirebaseAuth.instance.currentUser != null) {
      var user = await authProvider.getUserFromDataBase();
      if (user != null) {
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        return;
      }
    }
    Navigator.pushReplacementNamed(context, LoginScreen.routeName);
  }
}
