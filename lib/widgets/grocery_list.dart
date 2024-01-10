import 'package:flutter/material.dart';
import 'package:groceries_app/widgets/grocery_item.dart';
import '../models/grocery_item.dart';

class GroceryList extends StatelessWidget {
  const GroceryList({super.key, required this.groceryItems});
  final List<GroceryItem> groceryItems;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: groceryItems.length,
      itemBuilder: (ctx, index) {
        final groceryItem = groceryItems[index];
        return GroceryItemWidget(
            groceryItem: groceryItem); // Using the new widget
      },
    );
  }
}
