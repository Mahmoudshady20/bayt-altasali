import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fun_house_store/ui/home_screen/list_screen/category_item.dart';
import 'package:provider/provider.dart';
import '../../../database/model/category.dart';
import '../../../database/database.dart';
import '../../../provider/auth_provider.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  DateTime selectedDate = DateTime.now();
  DateTime focusedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProviderr>(context);
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot<Categories>>(
            stream: MyDataBase.getCategories(authProvider.myUser?.id),
            builder: (context, snapshot) {
              if(snapshot.hasError){
                return Text(snapshot.error.toString());
              }
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(child: CircularProgressIndicator(),);
              }
              var categoriesList = snapshot.data?.docs.map((doc) => doc.data()).toList();
              return GridView.builder(gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2) , itemBuilder:(context, index) => CategoryItem(category: categoriesList![index],),
                itemCount: categoriesList?.length ?? 0,
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
    );
  }
}
