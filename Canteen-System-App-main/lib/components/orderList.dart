import 'package:flutter/material.dart';

import 'database.dart';

class OrderList extends StatefulWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  // Map<String, int> quantities = {'Item 1': 1, 'Item 2': 1, 'Item 3': 1};
  // Map<String, int> quantities = Map.fromIterable(
  //   orders.keys,
  //   key: (key) => key as String,
  //   value: (key) => 1,
  // );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: orders.entries
            .map(
              (entry) => Dismissible(
            key: Key(entry.key),
            onDismissed: (direction) {
              setState(() {
                orders.remove(entry.key);
                quantities.remove(entry.key);
              });
            },
            background: Container(
              color: Colors.red,
              child: Icon(Icons.delete, color: Colors.white),
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 16),
            ),
            child: ListTile(
              leading: Text('${quantities[entry.key]}'),
              title: Text(entry.key),
              subtitle: Text('${entry.value.toString()} Rs'),
              trailing: Container(
                height: 200,
                width: 125,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          quantities[entry.key] = quantities[entry.key]! + 1;
                          // You can add logic to update the total or do other operations here
                        });
                      },
                      icon: Icon(Icons.add_circle_outline),
                    ),
                    // Text('${quantities[entry.key]}', style: TextStyle(fontSize: 15)),
                    IconButton(
                      onPressed: () {
                        if (quantities[entry.key]! > 1) {
                          setState(() {
                            quantities[entry.key] = quantities[entry.key]! - 1;
                            // You can add logic to update the total or do other operations here
                          });
                        }
                      },
                      icon: Icon(Icons.remove_circle_outline),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
            .toList(),
      ),
    );
  }
}
