import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freebie/screens/product_screens/item.dart';
import 'package:freebie/screens/search_screen.dart';
import 'package:provider/provider.dart';

import '../data/items.dart';
import '../providers/liked_item_provider.dart';
import 'account_screen.dart';
import 'cart_screen.dart';
import 'home_screen.dart';

class SavedItemScreen extends StatefulWidget {
  const SavedItemScreen({super.key});

  @override
  State<SavedItemScreen> createState() => _SavedItemScreenState();
}

class _SavedItemScreenState extends State<SavedItemScreen> {
  int _selectedNavIndex = 2;

  void _onNavigationBarTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
    if (index == 1) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SearchScreen()));
    }
    if (index == 3) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => CartScreen()));
    }
    if (index == 4) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AccountScreen()));
    }
    if (index == 5) {
    } else {
      setState(() {
        _selectedNavIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final likedItems = Provider.of<LikedItemProvider>(context).likedItems;
    final savedProducts = products
        .asMap()
        .entries
        .where((entry) => likedItems.contains(entry.key))
        .map((entry) => entry.value)
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Saved Items',
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
      body: savedProducts.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svg/icons/Heart.svg',
                    height: 70,
                    color: Color(0xFFB3B3B3),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, bottom: 10),
                    child: Text(
                      "No Saved Items!",
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    "You don't have any saved items. \nGo to home and add some.",
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
          : ListView.builder(
              itemCount: savedProducts.length,
              itemBuilder: (context, index) {
                final product = savedProducts[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ItemScreen(product: product)));
                  },
                  child: ListTile(
                    leading: Image.asset(product['image']),
                    title: Text(product['name']),
                    subtitle: Text("\₹${product['price']}"),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        Provider.of<LikedItemProvider>(context, listen: false)
                            .toggleLikedItem(product['id']);
                      },
                    ),
                  ),
                );
              },
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
