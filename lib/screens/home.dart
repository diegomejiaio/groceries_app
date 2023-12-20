import 'package:flutter/material.dart';
import '../data/dummy_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groceries App'),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: groceryItems.length,
          itemBuilder: (ctx, index) {
            final groceryItem = groceryItems[index];
            return Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
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
                ListTile(
                  title: Text(groceryItem.name),
                  subtitle: Text(groceryItem.category.name),
                  leading: CircleAvatar(
                    child: Text(groceryItem.quantity.toString()),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
