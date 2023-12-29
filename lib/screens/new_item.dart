import 'package:flutter/material.dart';
import 'package:groceries_app/models/category.dart';
import 'package:groceries_app/data/categories.dart';

class NewItem extends StatefulWidget {
  const NewItem({Key? key}) : super(key: key);
  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  String itemName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Grocery Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    itemName = value;
                  });
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Item Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an item name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Quantity',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a quantity';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: DropdownButtonFormField(
                      decoration: const InputDecoration(
                        labelText: 'Category',
                      ),
                      items: categories.entries
                          .map((category) => DropdownMenuItem(
                                value: category.value,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 16.0,
                                      height: 16.0,
                                      color: category.value.color,
                                    ),
                                    const SizedBox(width: 8.0),
                                    Text(category.value.name),
                                  ],
                                ),
                              ))
                          .toList(),
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('Reset'),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(itemName);
                        },
                        child: const Text('Save'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              )
            ],
          ),
        ),
      ),
    );
  }
}
