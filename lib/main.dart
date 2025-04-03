// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'repository.dart';
import 'provider.dart';
import 'widgets.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD App'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Add Item'),
                  content: ItemForm(onSubmit: (name, value) {
                    itemProvider.addItem(name, value);
                    Navigator.of(context).pop();
                  }),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: itemProvider.isLoading
            ? CircularProgressIndicator()
            : itemProvider.hasData
                ? ListView.builder(
                    itemCount: itemProvider.itemsState!.data!.length,
                    itemBuilder: (context, index) {
                      final item = itemProvider.itemsState!.data![index];
                      return ListTile(
                        title: Text(item.name),
                        subtitle: Text('${item.value}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            itemProvider.removeItem(item.id);
                          },
                        ),
                      );
                    },
                  )
                : Text('No items found'),
      ),
    );
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ItemProvider(FirebaseItemRepository()),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: const App()),
    ),
  );
}
