import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freebie/screens/checkout_screen.dart';
import 'package:freebie/screens/saved_items_screen.dart';
import 'package:freebie/screens/search_screen.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/price_provider.dart';
import 'account_screen.dart';
import 'home_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int _selectedNavIndex = 3;

  void _onNavigationBarTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
        break;
      case 1:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SearchScreen()));
        break;
      case 2:
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => SavedItemScreen()));
        break;
      case 4:
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AccountScreen()));
        break;
      default:
        setState(() {
          _selectedNavIndex = index;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final priceProvider = Provider.of<PriceProvider>(context);
    final cartItems = cartProvider.items;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'My Cart',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
        ),
        centerTitle: true,
        leading: Icon(Icons.arrow_back),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: SvgPicture.asset(
              'assets/svg/icons/Bell.svg',
              height: 30,
            ),
          ),
        ],
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svg/icons/Cart_page.svg',
                    height: 70,
                    color: Color(0xFFB3B3B3),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 10),
                    child: Text(
                      "Your Cart Is Empty!",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 22,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    "When you add products, they’ll \nappear here.",
                    style: TextStyle(
                      color: Color(0xFF808080),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      final quantity = item['quantity'] ?? 1;
                      final price =
                          double.tryParse(item['price'].toString()) ?? 0.0;
                      final totalPrice = price * quantity;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border:
                              Border.all(color: Color(0xFFE6E6E6), width: 2),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                item['image'],
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        item['name'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Spacer(),
                                      IconButton(
                                        icon: SvgPicture.asset(
                                            'assets/svg/icons/Trash.svg'),
                                        onPressed: () {
                                          cartProvider.removeItem(index);
                                        },
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Size: ${item['size'] ?? 'Select a size'}',
                                    style: TextStyle(color: Color(0xFF808080)),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "₹${totalPrice.toStringAsFixed(2)}", // updated price display
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Spacer(),
                                      IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: () {
                                          if (quantity > 1) {
                                            cartProvider.updateItemQuantity(
                                                index, quantity - 1);
                                          }
                                        },
                                      ),
                                      Text(
                                        '$quantity',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: () {
                                          cartProvider.updateItemQuantity(
                                              index, quantity + 1);
                                        },
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
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Sub-Total:',
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 16),
                          ),
                          Text(
                            '₹${priceProvider.subtotal.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Platform Fee:',
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 16),
                          ),
                          Text(
                            '₹${priceProvider.platformFee.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Delivery Charges:',
                            style: TextStyle(
                                fontWeight: FontWeight.w300, fontSize: 16),
                          ),
                          Text(
                            '₹${priceProvider.deliveryCharges.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Divider(),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total:',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            '₹${priceProvider.total.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: const WidgetStatePropertyAll(
                                  Color(0xFF1A1A1A)),
                              shape: WidgetStatePropertyAll<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CheckoutScreen()));
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Go to Checkout',
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
      bottomNavigationBar: NavigationBar(
        indicatorColor: Colors.transparent,
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        elevation: 5,
        selectedIndex: _selectedNavIndex,
        onDestinationSelected: _onNavigationBarTapped,
        destinations: [
          NavigationDestination(
            icon: SvgPicture.asset(
              'assets/svg/icons/Home.svg',
              color: _selectedNavIndex == 0 ? Colors.black : Color(0xFF999999),
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              'assets/svg/icons/Search.svg',
              color: _selectedNavIndex == 1 ? Colors.black : Color(0xFF999999),
            ),
            label: 'Search',
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              'assets/svg/icons/Liked.svg',
              color: _selectedNavIndex == 2 ? Colors.black : Color(0xFF999999),
            ),
            label: 'Liked',
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              'assets/svg/icons/Cart.svg',
              color: _selectedNavIndex == 3 ? Colors.black : Color(0xFF999999),
            ),
            label: 'Cart',
          ),
          NavigationDestination(
            icon: SvgPicture.asset(
              'assets/svg/icons/Account.svg',
              color: _selectedNavIndex == 4 ? Colors.black : Color(0xFF999999),
            ),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}
