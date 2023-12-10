class Item {
  static const String collectionName = 'itemCollection';
  String? id;
  String? name;
  double? wholesalePrice;
  double? consumerPrice;
  DateTime? productionDate;
  DateTime? expiryDate;
  double? quantity;
  Item({this.id, this.name, this.wholesalePrice,this.consumerPrice, this.productionDate,this.expiryDate, this.quantity});

  Item.fromFireStore(Map<String,dynamic>?data):this(
    id: data?['id'],
    name: data?['name'],
    wholesalePrice: data?['wholesalePrice'],
    consumerPrice: data?['consumerPrice'],
    productionDate: DateTime.fromMillisecondsSinceEpoch(data?['productionDate']),
    expiryDate: DateTime.fromMillisecondsSinceEpoch(data?['expiryDate']),
    quantity: data?['quantity'],
  );
  Map<String,dynamic> toFireStore(){
    return {
      'id':id,
      'name':name,
      'wholesalePrice':wholesalePrice,
      'consumerPrice':consumerPrice,
      'productionDate':productionDate!.millisecondsSinceEpoch,
      'expiryDate':expiryDate!.millisecondsSinceEpoch,
      'quantity':quantity,
    };
  }
}
