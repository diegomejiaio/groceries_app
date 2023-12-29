// grocery_item.dart
import 'package:flutter/material.dart';

class GroceryItemWidget extends StatelessWidget {
  final dynamic
      groceryItem; // Replace 'dynamic' with the actual type of your grocery item

  const GroceryItemWidget({super.key, required this.groceryItem});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: groceryItem.category.color,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  groceryItem.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${groceryItem.quantity} ${groceryItem.category.name}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
