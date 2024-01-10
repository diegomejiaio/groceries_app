import 'package:flutter/material.dart';
import 'package:groceries_app/screens/new_item.dart';
import 'package:groceries_app/models/grocery_item.dart';
import '../data/dummy_data.dart';
import 'package:groceries_app/widgets/grocery_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<GroceryItem> _groceryItems = groceryItems;

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );
    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItems.add(newItem);
    });
  }

  void _deleteItem(String id) {
    setState(() {
      _groceryItems.removeWhere((item) => item.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text('No items yet!'),
    );
    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItems.length,
        itemBuilder: (ctx, index) {
          return Dismissible(
            onDismissed: (direction) => _deleteItem(_groceryItems[index].id),
            direction: DismissDirection.endToStart,
            key: ValueKey(_groceryItems[index].id),
            child: GroceryItemWidget(
              groceryItem: _groceryItems[index],
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Groceries App'),
        actions: [
          IconButton(
            onPressed: () => _addItem(),
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
              child: content,
            ),
          ),
        ),
      ),
    );
  }
}
