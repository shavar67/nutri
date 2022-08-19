import 'package:flutter/material.dart';
import 'package:nuclear/provider/recipe_provider.dart';
import 'package:provider/provider.dart';

class MobileFeed extends StatefulWidget {
  const MobileFeed({Key? key}) : super(key: key);

  @override
  State<MobileFeed> createState() => _MobileFeedState();
}

class _MobileFeedState extends State<MobileFeed> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);
    return recipeProvider.loading
        ? const Center(child: CircularProgressIndicator())
        : ListView.builder(
            itemCount: recipeProvider.meals.length,
            itemBuilder: ((context, index) {
              return ListTile(title: Text('${recipeProvider.meals.length}'));
            }));
  }
}
