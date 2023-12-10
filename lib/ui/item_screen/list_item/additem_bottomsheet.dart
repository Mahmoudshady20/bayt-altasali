import 'package:flutter/material.dart';
import 'package:fun_house_store/database/model/category.dart';
import 'package:provider/provider.dart';

import '../../../database/database.dart';
import '../../../database/model/item.dart';
import '../../../provider/auth_provider.dart';
import '../../component/custom_form_field.dart';
import '../../component/date_utils.dart';
import '../../component/dialog_utils.dart';


class AddItemBottomSheet extends StatefulWidget {
  const AddItemBottomSheet({super.key,required this.categories});
  final Categories categories;
  @override
  State<AddItemBottomSheet> createState() => _AddItemBottomSheetState();
}

class _AddItemBottomSheetState extends State<AddItemBottomSheet> {
  TextEditingController nameController = TextEditingController();
  TextEditingController consumerController = TextEditingController();
  TextEditingController wholesaleController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  DateTime productionDate = DateTime.now();
  DateTime expiredDate = DateTime.now();


  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.9 ,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        color: Colors.white
      ),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(child: Text('Add new Item',style: Theme.of(context).textTheme.titleMedium,)),
              Text('Item Name',style: Theme.of(context).textTheme.titleLarge,),
              CustomFormField(label: 'Enter Item Name', controller: nameController,
                  validator: (value){
                    if(value==null || value.trim().isEmpty){
                      return 'Please enter Item name';
                    }
                    return null;
              }),
              const SizedBox(
                height: 6,
              ),
              Text('Consumer Price',style: Theme.of(context).textTheme.titleLarge,),
              CustomFormField(label: 'Enter Consumer Price', controller: consumerController,
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
              CustomFormField(label: 'Enter Wholesale Price', controller: wholesaleController,
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
              CustomFormField(label: 'Enter Quantity', controller: quantityController,
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
              Text('Select Production Date',style: Theme.of(context).textTheme.titleLarge,),
              InkWell(
                  onTap: (){
                    showProductionDate();
                  },
                  child: Center(child: Text(MyDateUtils.formatTaskDate(productionDate),style: Theme.of(context).textTheme.titleLarge,))),
              const SizedBox(
                height: 6,
              ),
              Text('Select Expiry Date',style: Theme.of(context).textTheme.titleLarge,),
              InkWell(
                  onTap: (){
                    showExpiryDate();
                  },
                  child: Center(child: Text(MyDateUtils.formatTaskDate(expiredDate),style: Theme.of(context).textTheme.titleLarge,))),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(onPressed: (){
                addItemButton();
              }, child: const Text('add'))
            ],
          ),
        ),
      ),
    );
  }
  void showProductionDate() async {
    var date = await showDatePicker(
        context: context,
        initialDate: productionDate,
        firstDate: productionDate.subtract(const Duration(days: 700)),
        lastDate: DateTime.now().add(const Duration(days: 30)));
    if(date==null){
      return;
    }
    productionDate = date;
    setState(() {

    });
  }
  void showExpiryDate() async {
    var date = await showDatePicker(
        context: context,
        initialDate: expiredDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 1095)));
    if(date==null){
      return;
    }
    expiredDate = date;
    setState(() {

    });
  }
  void addItemButton() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    var authProvider = Provider.of<AuthProviderr>(context, listen: false);
    DialogUtils.showLoadingDialog(context, 'Loading...');
      Item item = Item(
        name: nameController.text,
        consumerPrice: double.parse(consumerController.text),
        wholesalePrice: double.parse(wholesaleController.text),
        quantity: double.parse(quantityController.text),
        productionDate: MyDateUtils.dateOnly(productionDate),
        expiryDate: MyDateUtils.dateOnly(expiredDate)
      );
      await MyDataBase.addItem(authProvider.myUser?.id ?? '', widget.categories.id,item);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(context, 'Item Added Successfully',
      postActionName: 'ok',posAction: (){
        Navigator.pop(context);
          }
      );
    }
  }

