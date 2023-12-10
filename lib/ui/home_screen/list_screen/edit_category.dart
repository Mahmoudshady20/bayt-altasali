import 'package:flutter/material.dart';
import 'package:fun_house_store/database/model/category.dart';
import 'package:provider/provider.dart';


import '../../../database/database.dart';
import '../../../provider/auth_provider.dart';
import '../../component/custom_form_field.dart';



class EditCategory extends StatelessWidget {
  static const String routeName = 'editTask';

  EditCategory({super.key});

  var formKey = GlobalKey<FormState>();

  TextEditingController? nameController;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Categories;
    nameController = TextEditingController(text: args.name);
    var provider = Provider.of<AuthProviderr>(context);
    return Scaffold(
      appBar:   AppBar(
        title: Text('Edit Category',
        style: Theme.of(context).textTheme.headline4,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height*0.75,
          width: MediaQuery.of(context).size.width*0.85,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
          ),
          padding: const EdgeInsets.all(12),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomFormField(
                  controller: nameController!,
                  label: 'Category Name',
                  validator: (text){
                    if(text==null || text.trim().isEmpty){
                      return 'please enter category name';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16)
                    ),
                    onPressed: (){
                      if(formKey.currentState!.validate()){
                        args.name = nameController?.text;
                        MyDataBase.updateCategory(provider.myUser?.id ?? '', args);
                        Navigator.pop(context);
                      }
                    }, child: const Text('Update Category',
                  style: TextStyle(fontSize: 18),))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
