import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/settings_provider.dart';
import '../../../shared_prefrences/shared_prrefrences.dart';


class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String? modeDropDownValue = SharedPrefs.getTheme();
  // String? languageDropDownValue;

  @override
  Widget build(BuildContext context) {
    var settingProvider = Provider.of<SettingsProvider>(context);
    // if(SharedPrefs.getlan() == 'ar'){
    //   languageDropDownValue = 'Arabic';
    // }else {
    //   languageDropDownValue = 'English';
    // }
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text("Language",style: Theme.of(context).textTheme.titleMedium),
          // const SizedBox(
          //   height: 20,
          // ),
          // Container(
          //   width: double.infinity,
          //   decoration: BoxDecoration(
          //     color: Theme.of(context).dividerColor,
          //     border: Border.all(color: Theme.of(context).primaryColor),
          //   ),
          //   child: DropdownButton(
          //       isExpanded: true,
          //       underline: Container(
          //         color: Colors.transparent,
          //       ),
          //       padding: const EdgeInsets.only(right: 8, left: 8),
          //       items:  const [
          //           DropdownMenuItem(
          //           value: 'Arabic',
          //           child: Text(
          //             'Arabic',
          //             style: TextStyle(
          //               fontSize: 16,
          //               color: Color(0xFF5D9CEC),
          //             ),
          //           ),
          //         ),
          //           DropdownMenuItem(
          //           value: 'English',
          //           child: Text('English',
          //               style: TextStyle(
          //                 fontSize: 16,
          //                 color: Color(0xFF5D9CEC),
          //               )),
          //         ),
          //       ],
          //       value: languageDropDownValue,
          //       onChanged: (value) {
          //         setState(() {
          //           languageDropDownValue = value;
          //         });
          //       }),
          // ),
          // const SizedBox(
          //   height: 30,
          // ),
          Text("Mode",style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).dividerColor,
              border: Border.all(color: Theme.of(context).primaryColor),
            ),
            child: DropdownButton(
              isExpanded: true,
              underline: Container(
                color: Colors.transparent,
              ),
              padding: const EdgeInsets.only(right: 8, left: 8),
              items: [
                DropdownMenuItem(
                  onTap: (){
                    settingProvider.enableLightMode();
                  },
                  value: 'light',
                  child: const Text('light',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF5D9CEC),
                      )),
                ),
                DropdownMenuItem(
                  onTap: (){
                    settingProvider.enableDarkMode();
                  },
                  value: 'dark',
                  child: const Text('dark',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF5D9CEC),
                      )),
                ),
              ],
              value: modeDropDownValue,
              onChanged: (value) {
                setState(() {
                  modeDropDownValue = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
