import 'package:flutter/material.dart';
import 'package:groceries_app/models/category.dart';
import 'package:groceries_app/data/categories.dart';
import 'package:groceries_app/models/grocery_item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewItem extends StatefulWidget {
  const NewItem({Key? key}) : super(key: key);
  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  var _itemName = '';
  var _quantity = 1;
  var _category = categories[Categories.vegetables]!;
  void _saveItem() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final url = Uri.https('flutter-prj-506e6-default-rtdb.firebaseio.com',
          'shopping-list.json');
      http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': _itemName[0].toUpperCase() + _itemName.substring(1),
          'quantity': _quantity,
          'category': _category.name,
        }),
      );

      Navigator.of(context).pop(
        GroceryItem(
          id: DateTime.now().toString(),
          name: _itemName[0].toUpperCase() + _itemName.substring(1),
          quantity: _quantity,
          category: _category,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Name: $_itemName | Quantity: $_quantity | Type: ${_category.name}'),
        ),
      );
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Grocery Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    _itemName = value;
                  });
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  labelText: 'Item Name',
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'Please enter a correct name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _itemName = value!;
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
                      initialValue: _quantity.toString(),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return 'Please enter a valitd, positive number.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _quantity = int.parse(value!);
                      },
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _category,
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
                      onChanged: (value) {
                        setState(() {
                          _category = value as Category;
                        });
                      },
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
                        onPressed: () {
                          _resetForm();
                        },
                        child: const Text('Reset'),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          _saveItem();
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
