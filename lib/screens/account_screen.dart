import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freebie/screens/account_notification.dart';
import 'package:freebie/screens/address_screen.dart';
import 'package:freebie/screens/faq_screen.dart';
import 'package:freebie/screens/help_center_screen.dart';
import 'package:freebie/screens/login_screen.dart';
import 'package:freebie/screens/my_details_screen.dart';
import 'package:freebie/screens/my_orders_screen.dart';
import 'package:freebie/screens/saved_items_screen.dart';
import 'package:freebie/screens/search_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'cart_screen.dart';
import 'home_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  int _selectedNavIndex = 4;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void _onNavigationBarTapped(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
    if (index == 1) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SearchScreen()));
    }
    if (index == 2) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SavedItemScreen()));
    }
    if (index == 3) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => CartScreen()));
    }
    if (index == 5) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => AccountScreen()));
    } else {
      setState(() {
        _selectedNavIndex = index;
      });
    }
  }

  void _logoutPlacedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          content: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFED1010), width: 3),
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0x20ED1010),
                    ),
                    child: Center(
                        child: Icon(
                      CupertinoIcons.exclamationmark,
                      color: Color(0xFFED1010),
                      size: 30,
                    )),
                  ),
                ),
                Text(
                  'Logout?',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  'Are you sure you want to logout?',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 15),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFFED1010)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      Navigator.of(context).pop(); // Close the dialog

                      // Sign out from Firebase
                      await _auth.signOut();
                      await _googleSignIn.signOut();

                      // Clear the navigation stack and navigate to Home or Login Screen after logout
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: const Text(
                      'Yes, Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.grey.shade300),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: const Text(
                      'No, Cancel',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Account',
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            accountOptions(
              option: 'My Orders',
              img: 'assets/svg/icons/orders.svg',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyOrdersScreen()));
              },
            ),
            Divider(
              height: 20,
              thickness: 8,
              color: Color(0xFFE6E6E6),
            ),
            accountOptions(
              option: 'My Details',
              img: 'assets/svg/icons/Details.svg',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyDetailsScreen()));
              },
            ),
            Divider(),
            accountOptions(
              option: 'Address Book',
              img: 'assets/svg/icons/Address.svg',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddressScreen()));
              },
            ),
            Divider(),
            accountOptions(
              option: 'Payment Methods',
              img: 'assets/svg/icons/Card.svg',
              onTap: () {},
            ),
            Divider(),
            accountOptions(
              option: 'Notifications',
              img: 'assets/svg/icons/Bell.svg',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AccountNotificationScreen()));
              },
            ),
            Divider(
              height: 40,
              thickness: 8,
              color: Color(0xFFE6E6E6),
            ),
            accountOptions(
              option: 'FAQs',
              img: 'assets/svg/icons/Question.svg',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FAQsScreen()));
              },
            ),
            Divider(),
            accountOptions(
              option: 'Help Center',
              img: 'assets/svg/icons/help_center.svg',
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HelpCenterScreen()));
              },
            ),
            Divider(
              height: 40,
              thickness: 8,
              color: Color(0xFFE6E6E6),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: GestureDetector(
                onTap: _logoutPlacedDialog,
                child: Row(
                  children: [
                    Icon(
                      Icons.logout_rounded,
                      color: Colors.red,
                    ),
                    SizedBox(width: 15),
                    Text(
                      'Logout',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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

class accountOptions extends StatelessWidget {
  final String option;
  final String img;
  final VoidCallback onTap;

  const accountOptions({
    super.key,
    required this.option,
    required this.img,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children: [
            SvgPicture.asset(
              img,
              height: 30,
              width: 30,
              color: Colors.black,
            ),
            SizedBox(width: 15),
            Text(
              option,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
