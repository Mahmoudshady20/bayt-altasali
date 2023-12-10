import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fun_house_store/ui/item_screen/list_item/additem_bottomsheet.dart';
import 'package:fun_house_store/ui/item_screen/list_item/item_widget.dart';
import 'package:provider/provider.dart';
import '../../../database/model/category.dart';
import '../../../database/database.dart';
import '../../../database/model/item.dart';
import '../../../provider/auth_provider.dart';

class ItemListScreen extends StatefulWidget {
  const ItemListScreen({super.key});
  static const String routeName = 'itemList';

  @override
  State<ItemListScreen> createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  late Categories categories;
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProviderr>(context);
    categories = ModalRoute.of(context)!.settings.arguments as Categories;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,  //5D9CEC
        title: Text(categories.name ?? ''),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          addItemBottomSheet();
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Item>>(
              stream: MyDataBase.getItem(authProvider.myUser?.id, categories.id),
              builder: (context, snapshot) {
                if(snapshot.hasError){
                  return Text(snapshot.error.toString());
                }
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: CircularProgressIndicator(),);
                }
                var itemList = snapshot.data?.docs.map((doc) => doc.data()).toList();
                return ListView.builder(itemBuilder:(context, index) => ItemWidget(categories: categories,item: itemList![index],),
                  itemCount: itemList?.length ?? 0,
                );
                /*
              ListView.builder(itemBuilder:(context, index) => CategoryItem(category: categoriesList![index],),
                itemCount: categoriesList?.length ?? 0,
              );
               */
              },
            ),
          ),
        ],
      ),
    );
  }
  void addItemBottomSheet(){
    showModalBottomSheet(context: context,
        builder: (context) => AddItemBottomSheet(categories: categories),
        showDragHandle: true,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        useSafeArea: true
    );
  }
}
