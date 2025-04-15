import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freebie/screens/home_screen.dart';
import 'package:freebie/screens/product_screens/item.dart';
import 'package:freebie/screens/saved_items_screen.dart';

import '../data/items.dart';
import 'account_screen.dart';
import 'cart_screen.dart';
import 'notification_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController _searchController = TextEditingController();
  String searchQuery = '';
  int _selectedNavIndex = 1;

  void _onNavigationBarTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
    if (index == 2) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SavedItemScreen()));
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
    List<Map<String, dynamic>> filteredProducts = products.where((product) {
      return product['name'].toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        title: Text(
          'Search',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationScreen())),
              child: SvgPicture.asset(
                'assets/svg/icons/Bell.svg',
                height: 30,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search for clothes...',
                  prefixIcon: Image.asset(
                    'assets/Search.png',
                    width: 20,
                  ),
                  prefixIconColor: Color(0xFFB3B3B3),
                  suffixIcon: Image.asset(
                    'assets/Mic.png',
                    width: 20,
                  ),
                  suffixIconColor: Color(0xFFB3B3B3),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFB3B3B3),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFB3B3B3),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: searchQuery.isEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/svg/icons/Search_not_found.svg',
                        height: 70,
                        color: Color(0xFFB3B3B3),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25, bottom: 10),
                        child: Text(
                          "Start Searching!",
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 22),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        "Tell us what you're looking for, \nand we'll help you find it.",
                        style: TextStyle(
                          color: Color(0xFF808080),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )
                : Expanded(
                    child: filteredProducts.isEmpty
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/svg/icons/Search_not_found.svg',
                                height: 70,
                                color: Color(0xFFB3B3B3),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 25, bottom: 10),
                                child: Text(
                                  "No Results Found!",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 22),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Text(
                                "Try a similar word or something \nmore general.",
                                style: TextStyle(
                                  color: Color(0xFF808080),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )
                        : ListView.builder(
                            itemCount: filteredProducts.length,
                            itemBuilder: (context, index) {
                              final product = filteredProducts[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: Image.asset(
                                    product['image'],
                                    width: 50,
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                  title: Text(
                                    product['name'],
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    '₹${product['price']}',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.grey[700]),
                                  ),
                                  trailing: Icon(CupertinoIcons.arrow_up_right),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ItemScreen(product: product)));
                                  },
                                ),
                              );
                            },
                          ),
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
