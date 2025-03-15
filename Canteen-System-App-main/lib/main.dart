import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const DigiCanteenApp());
}

class DigiCanteenApp extends StatelessWidget {
  const DigiCanteenApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'DigiCanteen Food App',
        theme: ThemeData(primarySwatch: Colors.pink),
        home: const LoginScreen(),
        routes: {
          '/signup': (context) => const SignupScreen(),
          '/reset': (context) => const ResetPasswordScreen(),
          '/home': (context) => HomeScreen(),
          '/cart': (context) => CartScreen(),
        },
      ),
    );
  }
}

// ================= LOGIN SCREEN =================
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthScreen(
      title: "DigiCanteen",
      fields: [
        CustomTextField(label: "Email", icon: Icons.email),
        CustomTextField(label: "Password", icon: Icons.lock, isPassword: true),
      ],
      buttonText: "Log In",
      bottomText: "Not a registered user?",
      bottomActionText: "Sign Up here",
      bottomAction: () => Navigator.pushNamed(context, '/signup'),
      extraActionText: "Forgot Password?",
      extraAction: () => Navigator.pushNamed(context, '/reset'),
    );
  }
}

// ================= SIGNUP SCREEN =================
class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthScreen(
      title: "DigiCanteen",
      fields: [
        CustomTextField(label: "User Name", icon: Icons.person),
        CustomTextField(label: "Email", icon: Icons.email),
        CustomTextField(label: "Contact Number", icon: Icons.phone),
        CustomTextField(label: "Password", icon: Icons.lock, isPassword: true),
        CustomTextField(label: "Confirm Password", icon: Icons.lock, isPassword: true),
      ],
      buttonText: "Sign Up",
      bottomText: "Already a registered user?",
      bottomActionText: "Log In here",
      bottomAction: () => Navigator.pushNamed(context, '/'),
    );
  }
}

// ================= RESET PASSWORD SCREEN =================
class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthScreen(
      title: "DigiCanteen",
      fields: [
        CustomTextField(label: "Enter your Email", icon: Icons.email),
      ],
      buttonText: "Reset Password",
      bottomText: "",
      bottomActionText: "",
    );
  }
}

// ================= CART PROVIDER =================
class CartProvider extends ChangeNotifier {
  Map<String, int> _cart = {};
  double totalPrice = 0;

  Map<String, int> get cart => _cart;

  void addItem(String item, double price) {
    _cart[item] = (_cart[item] ?? 0) + 1;
    totalPrice += price;
    notifyListeners();
  }

  void removeItem(String item, double price) {
    if (_cart.containsKey(item) && _cart[item]! > 0) {
      _cart[item] = _cart[item]! - 1;
      totalPrice -= price;
      if (_cart[item] == 0) _cart.remove(item);
      notifyListeners();
    }
  }

  void clearCart() {
    _cart.clear();
    totalPrice = 0;
    notifyListeners();
  }
}

// ================= HOME SCREEN =================
class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> menuItems = [
    {'name': 'Chicken Biryani', 'price': 55.0, 'image': 'assets/chicken_biryani.jpg'},
    {'name': 'Mini Meals', 'price': 25.0, 'image': 'assets/mini_meals.jpg'},
    {'name': 'Gobi Manchurian', 'price': 15.0, 'image': 'assets/gobi_manchurian.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('JkkmDigiCanteen')),
      backgroundColor: Colors.lightBlue.shade50,
      body: ListView(
        children: menuItems.map((item) {
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              leading: Image.asset(item['image'], width: 50, height: 50, fit: BoxFit.cover),
              title: Text(item['name']),
              subtitle: Text('Cost: ${item['price']} INR'),
              trailing: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Provider.of<CartProvider>(context, listen: false)
                      .addItem(item['name'], item['price']);
                },
              ),
            ),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_cart),
        onPressed: () => Navigator.pushNamed(context, '/cart'),
      ),
    );
  }
}

// ================= CART SCREEN =================
class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Cart')),
      body: ListView(
        children: cartProvider.cart.entries.map((entry) {
          return ListTile(
            title: Text(entry.key),
            trailing: Text('x${entry.value}'),
          );
        }).toList(),
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {},
        child: Text('Proceed to Buy'),
      ),
    );
  }
}
