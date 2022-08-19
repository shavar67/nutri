import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:nuclear/model/recipe_model.dart';

//baseUrl+query+&+akiPkey+&_cont+&type=public&+apiId
var logger = Logger(printer: PrettyPrinter());
Future<List<RecipeModel>> searchRecipe(recipe) async {
  String url = 'https://www.themealdb.com/api/json/v1/1/search.php?s=$recipe';
  Uri uri = Uri.parse(url);
  logger.i(url);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    Map data = json.decode(response.body);
    if (data['meals'] != null) {
      ///logger.i(data['meals'][0]);
      var list =
          (data['meals'] as List).map((e) => RecipeModel.fromJson(e)).toList();
      //logger.i(list[0]);
      return list;
    }
    throw Exception(response.reasonPhrase);
  } else {
    throw Exception(response.reasonPhrase);
  }
}
