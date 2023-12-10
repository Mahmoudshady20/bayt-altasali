import 'package:flutter/material.dart';
import 'package:fun_house_store/database/model/edit_item.dart';
import 'package:provider/provider.dart';


import '../../../database/database.dart';
import '../../../provider/auth_provider.dart';
import '../../component/custom_form_field.dart';


class EditItem extends StatelessWidget {
  static const String routeName = 'editItem';

  EditItem({super.key});

  var formKey = GlobalKey<FormState>();

  TextEditingController? nameController;
  TextEditingController? wholesaleController;
  TextEditingController? quantityController;
  TextEditingController? consumerController;

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as ItemEdit;
    nameController = TextEditingController(text: args.item.name);
    wholesaleController = TextEditingController(text: args.item.wholesalePrice.toString());
    consumerController = TextEditingController(text: args.item.consumerPrice.toString());
    quantityController = TextEditingController(text: args.item.quantity.toString());
    var provider = Provider.of<AuthProviderr>(context);
    return Scaffold(
      appBar:   AppBar(
        title: Text('Edit Item',
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
                Text('Item Name',style: Theme.of(context).textTheme.titleLarge,),
                CustomFormField(
                  controller: nameController!,
                  label: 'Item Name',
                  validator: (text){
                    if(text==null || text.trim().isEmpty){
                      return 'please enter Item Name';
                    }
                    return null;
                  },
                ),const SizedBox(
                  height: 6,
                ),
                Text('Consumer Price',style: Theme.of(context).textTheme.titleLarge,),
                CustomFormField(label: 'Enter Consumer Price',
                    controller: consumerController!,
                    textInputType: TextInputType.number,
                    validator: (value){
                      if(value==null || value.trim().isEmpty){
                        return 'Please enter Consumer Price';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 6,
                ),
                Text('Wholesale Price',style: Theme.of(context).textTheme.titleLarge,),
                CustomFormField(label: 'Enter Wholesale Price',
                    controller: wholesaleController!,
                    textInputType: TextInputType.number,
                    validator: (value){
                      if(value==null || value.trim().isEmpty){
                        return 'Please enter Wholesale Price';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 6,
                ),
                Text('Quantity',style: Theme.of(context).textTheme.titleLarge,),
                CustomFormField(label: 'Enter Quantity',
                    controller: quantityController!,
                    textInputType: TextInputType.number,
                    validator: (value){
                      if(value==null || value.trim().isEmpty){
                        return 'Please enter Quantity';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 6,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16)
                    ),
                    onPressed: (){
                      if(formKey.currentState!.validate()){
                        args.item.name = nameController?.text;
                        args.item.wholesalePrice = double.parse(wholesaleController!.text);
                        args.item.consumerPrice = double.parse(consumerController!.text);
                        args.item.quantity = double.parse(quantityController!.text);
                        MyDataBase.updateItem(provider.myUser?.id ?? '', args.cid, args.item);
                        Navigator.pop(context);
                      }
                    }, child: const Text('Update Item',
                  style: TextStyle(fontSize: 18),))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
