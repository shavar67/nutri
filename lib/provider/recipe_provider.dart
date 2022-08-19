import 'package:flutter/material.dart';
import 'package:nuclear/network/network_request.dart';

import '../model/recipe_model.dart';

class RecipeProvider with ChangeNotifier {
  RecipeModel recipe = RecipeModel();
  bool loading = false;
  List<RecipeModel> meals = [];

  getRecipe(meal) async {
    loading = true;
    meals = await searchRecipe(meal);
    loading = false;
    notifyListeners();
  }
}
