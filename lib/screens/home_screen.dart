import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freebie/data/items.dart';
import 'package:freebie/screens/account_screen.dart';
import 'package:freebie/screens/cart_screen.dart';
import 'package:freebie/screens/notification_screen.dart';
import 'package:freebie/screens/product_screens/item.dart';
import 'package:freebie/screens/saved_items_screen.dart';
import 'package:freebie/screens/search_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../providers/liked_item_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategoryIndex = 0;
  Set<int> _likedProductIndices = {};
  int _selectedNavIndex = 0;
  int _selectedSortIndex = 0;
  double _currentSliderValue = 0;
  List<Map<String, dynamic>> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _filteredProducts = List.from(products);
    _currentSliderValue = 10000;
    _requestNotificationPermission();
  }

  void _onCategoryTap(int index) {
    setState(() {
      _selectedCategoryIndex = index;
    });
  }

  void _onSortTap(int index) {
    setState(() {
      _selectedSortIndex = index;
    });
  }

  void _onLikedTap(int index) {
    Provider.of<LikedItemProvider>(context, listen: false)
        .toggleLikedItem(index);
  }

  void _onNavigationBarTapped(int index) {
    if (index == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SearchScreen()));
    }
    if (index == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SavedItemScreen()));
    }
    if (index == 3) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => CartScreen()));
    }
    if (index == 4) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AccountScreen()));
    }
    if (index == 5) {
    } else {
      setState(() {
        _selectedNavIndex = index;
      });
    }
  }

  void _applyFilters() {
    setState(() {
      _filteredProducts = products.where((product) {
        double price = double.parse(product['price']);
        return price <= _currentSliderValue;
      }).toList();

      if (_selectedSortIndex == 1) {
        _filteredProducts.sort((a, b) =>
            double.parse(a['price']).compareTo(double.parse(b['price'])));
      } else if (_selectedSortIndex == 2) {
        _filteredProducts.sort((a, b) =>
            double.parse(b['price']).compareTo(double.parse(a['price'])));
      }

      if (_filteredProducts.isEmpty) {
        _filteredProducts = List.from(products);
      }
    });
  }

  Future<void> _requestNotificationPermission() async {
    final status = await Permission.notification.status;

    if (status != PermissionStatus.granted) {
      final result = await Permission.notification.request();

      if (result == PermissionStatus.granted) {
        if (kDebugMode) {
          print('Notification permission granted');
        }
      } else {
        if (kDebugMode) {
          print('Notification permission denied');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leadingWidth: 150,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: SvgPicture.asset('assets/svg/name_logo.svg'),
        ),
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
          Row(
            children: [
              SizedBox(
                width: 320,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    readOnly: true,
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchScreen())),
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
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder:
                            (BuildContext context, StateSetter setModalState) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Colors.white,
                            ),
                            height: 400,
                            width: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    child: Container(
                                      width: 70,
                                      height: 5,
                                      color: Color(0xFFE6E6E6),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Filters',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 10),
                                  child: Divider(
                                    thickness: 2,
                                    color: Color(0xFFE6E6E6),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: Align(
                                    child: Text(
                                      'Sort By',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    alignment: Alignment.centerLeft,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 15),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        _buildCategories(
                                          name: 'Relevance',
                                          onTap: () {
                                            setModalState(() {
                                              _selectedSortIndex = 0;
                                            });
                                          },
                                          isSelected: _selectedSortIndex == 0,
                                        ),
                                        SizedBox(width: 8),
                                        _buildCategories(
                                          name: 'Price: Low - High',
                                          onTap: () {
                                            setModalState(() {
                                              _selectedSortIndex = 1;
                                            });
                                          },
                                          isSelected: _selectedSortIndex == 1,
                                        ),
                                        SizedBox(width: 8),
                                        _buildCategories(
                                          name: 'Price: High - Low',
                                          onTap: () {
                                            setModalState(() {
                                              _selectedSortIndex = 2;
                                            });
                                          },
                                          isSelected: _selectedSortIndex == 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 10),
                                  child: Divider(
                                    thickness: 2,
                                    color: Color(0xFFE6E6E6),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: Align(
                                    child: Text(
                                      'Price',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    alignment: Alignment.centerLeft,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                  child: Column(
                                    children: [
                                      Slider(
                                        activeColor: Colors.black,
                                        secondaryActiveColor: Colors.white,
                                        value: _currentSliderValue,
                                        min: 0,
                                        max: 10000,
                                        divisions: 100,
                                        label:
                                            '₹${_currentSliderValue.round()}',
                                        onChanged: (double value) {
                                          setModalState(() {
                                            _currentSliderValue = value;
                                          });
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('₹0',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text(
                                                '₹${_currentSliderValue.round()}',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text('₹10,000',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25, vertical: 25),
                                  child: SizedBox(
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              const WidgetStatePropertyAll(
                                                  Color(0xFF1A1A1A)),
                                          shape: WidgetStatePropertyAll<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ))),
                                      onPressed: () {
                                        _applyFilters();
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Apply Filters',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    width: double.infinity,
                                    height: 50,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: SvgPicture.asset(
                    'assets/svg/icons/Filter.svg',
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategories(
                    name: 'All',
                    onTap: () => _onCategoryTap(0),
                    isSelected: _selectedCategoryIndex == 0,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  _buildCategories(
                    name: 'T-Shirt',
                    onTap: () => _onCategoryTap(1),
                    isSelected: _selectedCategoryIndex == 1,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  _buildCategories(
                    name: 'Jeans',
                    onTap: () => _onCategoryTap(2),
                    isSelected: _selectedCategoryIndex == 2,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  _buildCategories(
                    name: 'Shoes',
                    onTap: () => _onCategoryTap(3),
                    isSelected: _selectedCategoryIndex == 3,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  _buildCategories(
                    name: 'Hoodies',
                    onTap: () => _onCategoryTap(4),
                    isSelected: _selectedCategoryIndex == 4,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                for (int i = 0; i < _filteredProducts.length; i += 2)
                  _buildProductRow([
                    _buildProductCard(
                      name: _filteredProducts[i]['name'],
                      image: _filteredProducts[i]['image'],
                      price: _filteredProducts[i]['price'],
                      isSelected:
                          Provider.of<LikedItemProvider>(context).isLiked(i),
                      onTapLiked: () => _onLikedTap(i),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemScreen(
                              product: _filteredProducts[i],
                            ),
                          ),
                        );
                      },
                    ),
                    if (i + 1 < _filteredProducts.length)
                      _buildProductCard(
                        name: _filteredProducts[i + 1]['name'],
                        image: _filteredProducts[i + 1]['image'],
                        price: _filteredProducts[i + 1]['price'],
                        isSelected: Provider.of<LikedItemProvider>(context)
                            .isLiked(i + 1),
                        onTapLiked: () => _onLikedTap(i + 1),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ItemScreen(
                                product: _filteredProducts[i + 1],
                              ),
                            ),
                          );
                        },
                      ),
                  ]),
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

  Widget _buildProductRow(List<Widget> products) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: products
            .map((product) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: product,
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class _buildProductCard extends StatelessWidget {
  final String name;
  final String image;
  final String price;
  final bool isSelected;
  final void Function()? onTapLiked;
  final void Function()? onTap;

  const _buildProductCard({
    super.key,
    required this.name,
    required this.image,
    required this.price,
    required this.isSelected,
    required this.onTapLiked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 130,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  child: Image.asset(
                    image,
                    fit: BoxFit.contain,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: onTapLiked,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(6),
                      child: SvgPicture.asset(
                        isSelected
                            ? 'assets/svg/icons/Heart-filled.svg'
                            : 'assets/svg/icons/Heart.svg',
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '₹$price',
            style: TextStyle(
                fontWeight: FontWeight.w500, color: Color(0xFF808080)),
          ),
        ],
      ),
    );
  }
}

class _buildCategories extends StatelessWidget {
  final String name;
  final void Function()? onTap;
  final bool isSelected;

  _buildCategories({
    super.key,
    required this.name,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.transparent,
            border: Border.all(
              color: Color(0xFFE6E6E6),
            ),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          child: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
