import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeModel {
  final String? uid;
  final String? recipeName;
  final String? userName;
  final String? description;
  final List<String>? ingredients;

  RecipeModel({
    this.uid,
    this.recipeName,
    this.userName,
    this.description,
    this.ingredients,
  });

  factory RecipeModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return RecipeModel(
        uid: data?['uid'],
        recipeName: data?['recipeName'],
        userName: data?['userName'],
        description: data?['description'],
        ingredients: data?['ingredients'] is Iterable
            ? List.from(data?['ingredients'])
            : []);
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (uid != null) "uid": uid,
      if (userName != null) "userName": userName,
      if (recipeName != null) "recipeName": recipeName,
      if (description != null) "description": description,
      if (ingredients != null) "ingredients": ingredients
    };
  }
}
