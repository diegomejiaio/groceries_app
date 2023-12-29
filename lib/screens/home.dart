import 'package:flutter/material.dart';
import 'package:groceries_app/widgets/grocery_list.dart';
import 'package:groceries_app/screens/new_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.groceryItems});
  final List groceryItems;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _addItem(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const NewItem(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Groceries App'),
        actions: [
          IconButton(
            onPressed: () => _addItem(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 880,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GroceryList(groceryItems: widget.groceryItems),
            ),
          ),
        ),
      ),
    );
  }
}
