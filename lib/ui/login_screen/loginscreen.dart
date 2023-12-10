import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/database.dart';
import '../../provider/auth_provider.dart';
import '../component/custom_form_field.dart';
import '../component/dialog_utils.dart';
import '../component/validations_regex.dart';
import '../home_screen/home_screen.dart';
import '../register_screen/registerscreen.dart';


class LoginScreen extends StatefulWidget {
  static const String routeName = 'loginscreen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration:  BoxDecoration(
          color: Theme.of(context).hintColor,
          image: const DecorationImage(
            image: AssetImage(
              'assets/images/background.png',
            ),
            fit: BoxFit.fill,
          )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.3,
                ),
                CustomFormField(
                    label: 'Email Adrress',
                    controller: emailController,
                    validator: (value){
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your Email';
                      }
                      if (!ValidationRegex.emailRegex(value)) {
                        return 'Please enter Valid Email';
                      }
                      return null;
                    }),
                CustomFormField(
                  label: 'password',
                  controller: passwordController,
                  validator: (value){
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your Password';
                    }
                    if (!ValidationRegex.passwordRegex(value)){
                      return 'Please enter valid Password';
                    }
                    return null;
                  },
                  isPassword: hidePassword,
                  suffix:IconButton(
                    onPressed: (){
                      if(hidePassword == false){
                        hidePassword = true;
                      }
                      else {
                        hidePassword = false;
                      }
                      setState(() {

                      });
                    },
                    icon: hidePassword ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                    onPressed: (){
                      login();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Icon(Icons.arrow_forward)
                      ],
                    )
                ),
                const SizedBox(
                  height: 15,
                ),
                TextButton(
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, RegisterScreen.routeName);
                    },
                    child: Text(
                      "Don't Have Account?",
                      style: Theme.of(context).textTheme.labelSmall,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
  FirebaseAuth authServices = FirebaseAuth.instance;
  login() async{
    if(!formKey.currentState!.validate()){
      return;
    }
    DialogUtils.showLoadingDialog(context, 'Loading...');
    String errorMessage;
    try {
      var result = await authServices.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
      var myUser = await MyDataBase.readUser(result.user?.uid);
      DialogUtils.hideDialog(context);
      if(myUser==null){
        // user is authenticated but not exists in the database
        DialogUtils.showMessage(context, "error. can't find user in db",
            postActionName: 'ok');
        return;
      }
      var provider = Provider.of<AuthProviderr>(context,listen: false);
      provider.updateUser(myUser);
      DialogUtils.showMessage(context, 'user logged in successfully',
          postActionName: 'ok',
          posAction: (){
            Navigator.pushReplacementNamed(context,HomeScreen.routeName);
          },dismissible: false
      );
    }on FirebaseAuthException {
      DialogUtils.hideDialog(context);
      errorMessage = 'wrong email or password';
      DialogUtils.showMessage(context, errorMessage,
          postActionName: 'ok');

    } catch (e){
      DialogUtils.hideDialog(context);
      errorMessage = 'Something went wrong';
      DialogUtils.showMessage(context, errorMessage,
          postActionName: 'cancel',
          negActionName: 'Try Again',
          negAction: (){
            login();
          }
      );

    }
  }
}