import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class OrderProvider extends ChangeNotifier {
  Map<String, int> orders = {};

  int calculateTotalAmount() {
    int totalAmount = 0;
    for (var entry in orders.entries) {
      totalAmount += entry.value;
    }
    return totalAmount;
  }

  void updateQuantity(String item, int quantity) {
    orders[item] = quantity;
    notifyListeners();
  }

  void removeItem(String item) {
    orders.remove(item);
    notifyListeners();
  }
}
