import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

import '../model/recipe_model.dart';

Logger logger = Logger(printer: PrettyPrinter());
Future addRecipe(String recipeName, String recipeDescription, String userName,
    String ingredient, String uid) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<String> ingredients = [];
  final recipe = RecipeModel(
      userName: userName,
      recipeName: recipeName,
      description: recipeDescription,
      uid: uid.substring(0, 6) + recipeName,
      ingredients: ingredient.split(","));
  final CollectionReference collectionReference =
      firestore.collection('cookbook');
  DocumentReference documentReferencer = collectionReference
      .withConverter(
          fromFirestore: RecipeModel.fromFirestore,
          toFirestore: (RecipeModel recipeModel, options) =>
              recipe.toFirestore())
      .doc(uid.substring(0, 6) + recipeName);

  await documentReferencer.set(recipe).whenComplete(() {
    Future.delayed(const Duration(milliseconds: 250)).whenComplete(() {
      logger.i('recipe created with: $uid');
    });
  }).catchError((e) => logger.e(e));
}
