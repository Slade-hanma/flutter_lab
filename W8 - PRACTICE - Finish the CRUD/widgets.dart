// lib/widgets.dart
import 'package:flutter/material.dart';

class ItemForm extends StatelessWidget {
  final Function(String, double) onSubmit;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController valueController = TextEditingController();

  ItemForm({required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        width: 250,   // Set the width of the form
        height: 150,
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Song Title'),
              validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
            ),
            TextFormField(
              controller: valueController,
              decoration: InputDecoration(labelText: 'Song Price'),
              keyboardType: TextInputType.number,
              validator: (value) => value!.isEmpty ? 'Please enter a value' : null,
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  onSubmit(nameController.text, double.parse(valueController.text));
                  nameController.clear();
                  valueController.clear();
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
