import 'package:fun_house_store/database/model/item.dart';

class ItemEdit {
  static const String collectionName = 'itemCollection';

  String? cid;
  Item item;

  ItemEdit(
      {required this.item,this.cid});
}