import "dart:async";

import "package:flutter/material.dart";
import "package:studyante/components/base_widget.dart";
import "package:studyante/pages/shoppinglist_page.dart";
import "package:studyante/services/hive/hive_shoppinglist_functions.dart";

class ShoppinglistWidget extends StatelessWidget {
  const ShoppinglistWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(milliseconds: 500)),
      builder: (context, snapshot) {
        String shoppingItemCount =
            ShoppingListHiveFunctions.getAllItems().length.toString();

        return BaseWidget(
          title: "Shopping List",
          backgroundColor: Colors.red.shade900,
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return const ShoppinglistPage();
            }));
          },
          child: Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 30,
            runSpacing: 5,
            children: [
              IntrinsicWidth(
                child: Row(
                  children: [
                    const Icon(
                      Icons.shopping_bag,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Items",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          shoppingItemCount,
                          style: const TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
