import 'package:flutter/material.dart';
import 'package:fun_house_store/ui/home_screen/list_screen/edit_category.dart';
import 'package:fun_house_store/ui/item_screen/list_item/listitem_screen.dart';
import 'package:provider/provider.dart';

import '../../../database/model/category.dart';
import '../../../database/database.dart';
import '../../../provider/auth_provider.dart';
import '../../component/dialog_utils.dart';

class CategoryItem extends StatefulWidget {
  final Categories category;
  const CategoryItem({super.key, required this.category});

  @override
  State<CategoryItem> createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, ItemListScreen.routeName,
                arguments: widget.category
              );
            },
            child: Text(
              widget.category.name ?? '',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)
                  )
                ),
                onPressed:(){
                  deleteCategory();
                },
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)
                    )
                ),
                onPressed:(){
                  DialogUtils.showMessage(context, 'Do you want to edit this Category?',
                      postActionName: 'Yes',
                      posAction: (){
                        Navigator.pushNamed(context,EditCategory.routeName,
                            arguments: widget.category);
                      },
                      negActionName: 'Cancel'
                  );
                },
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),

            ],
          )
        ],
      ),
    );
  }

  void deleteCategory() {
    DialogUtils.showMessage(context, 'Do you want to delete this Category?',
        postActionName: 'Yes', posAction: () async {
      deleteCategoryFromDataBase();
    }, negActionName: 'Cancel');
  }

  void deleteCategoryFromDataBase() async {
    var authProvider = Provider.of<AuthProviderr>(context, listen: false);
    try {
      await MyDataBase.deleteTask(authProvider.myUser?.id ?? "", widget.category);
    } catch (e) {
      DialogUtils.showMessage(
        context,
        'something went wrong,'
        '${e.toString()}',
      );
    }
  }
}

