import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../database/model/myuser.dart';
import '../database/database.dart';


class AuthProviderr extends ChangeNotifier{
  MyUser? myUser;
   updateUser(MyUser user){
    myUser = user ;
    notifyListeners();
  }
  Future<MyUser?> getUserFromDataBase()async{
    var user = await MyDataBase.readUser(FirebaseAuth.instance.currentUser?.uid ??"");
    myUser = user;
    return user;
  }
   signout() {
    FirebaseAuth.instance.signOut();
    myUser = null;
   }
}