import 'package:flutter/material.dart';
import 'package:fun_house_store/database/model/category.dart';
import 'package:provider/provider.dart';

import '../../database/database.dart';
import '../../provider/auth_provider.dart';
import '../component/custom_form_field.dart';
import '../component/dialog_utils.dart';


class AddCategoryBottomSheet extends StatefulWidget {
  const AddCategoryBottomSheet({super.key});


  @override
  State<AddCategoryBottomSheet> createState() => _AddCategoryBottomSheetState();
}

class _AddCategoryBottomSheetState extends State<AddCategoryBottomSheet> {
  TextEditingController titleController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        color: Colors.white
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(child: Text('Add new Category',style: Theme.of(context).textTheme.titleMedium,)),
            Text('Category Name',style: Theme.of(context).textTheme.titleLarge,),
            CustomFormField(label: 'Enter Category Name', controller: titleController,
                validator: (value){
                  if(value==null || value.trim().isEmpty){
                    return 'Please enter Category title';
                  }
                  return null;
            }),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(onPressed: (){
              addCategoryButton();
            }, child: const Text('add'))
          ],
        ),
      ),
    );
  }

  void addCategoryButton() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    var authProvider = Provider.of<AuthProviderr>(context, listen: false);
    DialogUtils.showLoadingDialog(context, 'Loading...');
      Categories categories = Categories(
        name: titleController.text
      );
      await MyDataBase.addCategories(authProvider.myUser?.id ?? '', categories);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(context, 'Category Added Successfully',
      postActionName: 'ok',posAction: (){
        Navigator.pop(context);
          }
      );
    }
  }

