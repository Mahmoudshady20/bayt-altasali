import 'package:flutter/material.dart';
import 'package:fun_house_store/provider/settings_provider.dart';
import 'package:fun_house_store/ui/home_screen/addcategory_bottomsheet.dart';
import 'package:fun_house_store/ui/home_screen/list_screen/list_screen.dart';
import 'package:fun_house_store/ui/home_screen/setting_screen/setting_screen.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';
import '../login_screen/loginscreen.dart';


class HomeScreen extends StatefulWidget {
  static const String routeName = 'homescreen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs = [const ListScreen(), const SettingScreen()];

  int currentIndexx = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProviderr>(context);
    var settingsProvider = Provider.of<SettingsProvider>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,  //5D9CEC
          title:  const Text('Fun House Store'),
          actions: [
            IconButton(
                onPressed: () {
                  provider.signout();
                  Navigator.pushReplacementNamed(
                      context, LoginScreen.routeName);
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          shape: StadiumBorder(
              side: BorderSide(color:Theme.of(context).dividerColor,width: 4)
          ),
          onPressed: (){
            addTaskBottomSheet();
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          notchMargin: 8,
          shape: const CircularNotchedRectangle(),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            currentIndex: currentIndexx,
            onTap: (index) {
              setState(() {
                currentIndexx = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list_outlined,
                    size: 26,
                    color: settingsProvider.isDark() ? Colors.white : Colors.black,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings_outlined,
                    size: 26,
                    color: settingsProvider.isDark() ? Colors.white : Colors.black,
                  ),
                  label: '')
            ],
          ),
        ),
      body: tabs[currentIndexx],
    );
  }
  void addTaskBottomSheet(){
    showModalBottomSheet(context: context,
        builder: (context) => const AddCategoryBottomSheet(),
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useSafeArea: true
    );
  }
}
