import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fun_house_store/database/model/category.dart';
import 'package:fun_house_store/database/model/item.dart';
import 'package:fun_house_store/database/model/myuser.dart';


class MyDataBase {
  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromFireStore(snapshot.data()!),
          toFirestore: (myUser, options) => myUser.toFireStore(),
        );
  }

  static Future<void> addUser(MyUser myUser) {
    CollectionReference<MyUser> collection = getUserCollection();
    return collection.doc(myUser.id).set(myUser);
  }

  static Future<MyUser?> readUser(String? uid) async {
    CollectionReference<MyUser> collection = getUserCollection();
    var docSnapShot = await collection.doc(uid).get();
    return docSnapShot.data();
  }

static CollectionReference<Categories> getCategoryCollection(String? uid) {
  return getUserCollection()
      .doc(uid)
      .collection(Categories.collectionName)
      .withConverter<Categories>(
        fromFirestore: (snapshot, options) =>
            Categories.fromFireStore(snapshot.data()!),
        toFirestore: (categories, options) => categories.toFireStore(),
      );
}
static Future<void> addCategories(String? uid,Categories categories){
  var collection = getCategoryCollection(uid).doc();
  categories.id = collection.id;
  return collection.set(categories);
}
static Stream<QuerySnapshot<Categories>> getCategories(String? uid){
  CollectionReference<Categories> collection = getCategoryCollection(uid);
  return collection.snapshots();
}
    static Future<void> deleteTask(String? uid,Categories category){
      CollectionReference<Categories> collection = getCategoryCollection(uid);
      return collection.doc(category.id).delete();
    }
  static updateCategory(String? uid,Categories category){
      CollectionReference<Categories> collection = getCategoryCollection(uid);
      return collection.doc(category.id).update(category.toFireStore());
    }


    ///
  static CollectionReference<Item> getItemCollection(String? uid,String? cid) {
    return getCategoryCollection(uid)
        .doc(cid)
        .collection(Item.collectionName)
        .withConverter<Item>(
      fromFirestore: (snapshot, options) =>
          Item.fromFireStore(snapshot.data()!),
      toFirestore: (item, options) => item.toFireStore(),
    );
  }
  static Future<void> addItem(String? uid,String? cid,Item item){
    var collection = getItemCollection(uid,cid).doc();
    item.id = collection.id;
    return collection.set(item);
  }
  static Stream<QuerySnapshot<Item>> getItem(String? uid,String? cid){
    CollectionReference<Item> collection = getItemCollection(uid,cid);
    return collection.snapshots();
  }
  static Future<void> deleteItem(String? uid,String? cid,Item item){
    CollectionReference<Item> collection = getItemCollection(uid,cid);
    return collection.doc(item.id).delete();
  }
  static Future<void> updateItem(String? uid,String? cid,Item item){
    CollectionReference<Item> collection = getItemCollection(uid,cid);
    return collection.doc(item.id).update(item.toFireStore());
  }
}
