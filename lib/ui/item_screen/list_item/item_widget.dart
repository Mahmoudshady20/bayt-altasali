import 'package:flutter/material.dart';
import 'package:fun_house_store/ui/component/date_utils.dart';
import 'package:fun_house_store/ui/item_screen/list_item/edit_item.dart';
import 'package:provider/provider.dart';
import '../../../database/model/category.dart';
import '../../../database/database.dart';
import '../../../database/model/edit_item.dart';
import '../../../database/model/item.dart';
import '../../../provider/auth_provider.dart';
import '../../component/dialog_utils.dart';

class ItemWidget extends StatefulWidget {
  final Item item;
  final Categories categories;
  const ItemWidget({super.key, required this.item,required this.categories});

  @override
  State<ItemWidget> createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin : const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Product name :- ${widget.item.name}',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
          Text(
            'Product Type :- ${widget.categories.name}',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
          Text(
            'Consumer Price :- ${widget.item.consumerPrice}',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
          Text(
            'Wholesale Price :- ${widget.item.wholesalePrice}',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
          Text(
            'Production Date :- ${MyDateUtils.formatTaskDate(widget.item.productionDate ?? DateTime.now())}',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
          Text(
            'Expiry Date :- ${MyDateUtils.formatTaskDate(widget.item.expiryDate ?? DateTime.now())}',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
          Text(
            'Quantity :- ${widget.item.quantity}',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
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
                  deleteItem();
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
                  DialogUtils.showMessage(context, 'Do you want to edit this Item?',
                      postActionName: 'Yes',
                      posAction: (){
                        Navigator.pushNamed(context,EditItem.routeName,
                            arguments: ItemEdit(item: widget.item,cid: widget.categories.id));
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

  void deleteItem() {
    DialogUtils.showMessage(context, 'Do you want to delete this Item?',
        postActionName: 'Yes', posAction: () async {
      deleteItemFromDataBase();
    }, negActionName: 'Cancel');
  }

  void deleteItemFromDataBase() async {
    var authProvider = Provider.of<AuthProviderr>(context, listen: false);
    try {
      await MyDataBase.deleteItem(authProvider.myUser?.id ?? "",widget.categories.id,widget.item);
    } catch (e) {
      DialogUtils.showMessage(
        context,
        'something went wrong,'
        '${e.toString()}',
      );
    }
  }
}

