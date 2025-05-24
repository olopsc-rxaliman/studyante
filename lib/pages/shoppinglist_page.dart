import "package:flutter/material.dart";
import "package:studyante/components/base_alertdialog.dart";
import "package:studyante/services/hive/hive_shoppinglist_functions.dart";

class ShoppinglistPage extends StatefulWidget {
  const ShoppinglistPage({super.key});

  @override
  State<ShoppinglistPage> createState() => _ShoppinglistPageState();
}

class _ShoppinglistPageState extends State<ShoppinglistPage> {
  final TextEditingController _textController = TextEditingController();
  List shoppingList = [];

  void refreshHiveData() {
    setState(() {
      shoppingList = ShoppingListHiveFunctions.getAllItems();
    });
  }

  void submit(String data) async {
    if (_textController.text.trim().isEmpty) {
      return;
    }
    await ShoppingListHiveFunctions.addItem(
      name: _textController.text,
    );
    _textController.clear();
    refreshHiveData();
  }

  @override
  void initState() {
    refreshHiveData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade900,
      appBar: AppBar(
        backgroundColor: Colors.red.shade900,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "SHOPPING LIST",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => BaseAlertDialog(
                  onClickConfirm: () async {
                    await ShoppingListHiveFunctions.deleteAllItems();
                    if (context.mounted) {
                      Navigator.of(context).pop();
                      refreshHiveData();
                    }
                  },
                  onClickReject: () => Navigator.of(context).pop(),
                  actionButtonColor: Colors.red.shade900,
                  child: const Text(
                    "Delete all items in the shopping list?",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
          top: 8.0,
        ),
        child: Column(children: [
          Row(children: <Widget>[
            Expanded(
              child: TextField(
                controller: _textController,
                onEditingComplete: () {
                  submit(_textController.text);
                },
                decoration: const InputDecoration(
                  hintText: "Enter item name",
                  hintStyle: TextStyle(fontWeight: FontWeight.normal),
                  filled: true,
                  fillColor: Colors.white,
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                submit(_textController.text);
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 20,
                ),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Icon(Icons.add_shopping_cart),
            ),
          ]),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: shoppingList.length,
              itemBuilder: (context, index) => Card(
                color: Colors.white,
                child: ListTile(
                  title: Text(shoppingList[index]['name']),
                  textColor: Colors.black,
                  contentPadding: const EdgeInsets.only(
                    left: 16,
                    right: 12,
                  ),
                  trailing: IconButton(
                    onPressed: () async {
                      ShoppingListHiveFunctions.deleteItem(
                          key: shoppingList[index]['key']);
                      refreshHiveData();
                    },
                    icon: const Icon(
                      Icons.remove_circle_outline,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
