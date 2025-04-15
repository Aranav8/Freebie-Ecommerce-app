import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:freebie/screens/account_screen.dart';

import 'change_password_screen.dart';

class MyDetailsScreen extends StatefulWidget {
  const MyDetailsScreen({super.key});

  @override
  State<MyDetailsScreen> createState() => _MyDetailsScreenState();
}

class _MyDetailsScreenState extends State<MyDetailsScreen> {
  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'My Details',
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
          children: [
            // Text('Full Name'),
            // const SizedBox(height: 20),
            TextFields(
              name: 'Full Name',
              hintText: 'Enter your full name',
              controller: _nameController,
            ),
            const SizedBox(height: 20),
            TextFields(
              name: 'Email Address',
              hintText: 'Enter your Email Address',
              controller: _nameController,
            ),
            const SizedBox(height: 20),
            TextFields(
              name: 'Date of Birth',
              hintText: 'Select your Date of Birth',
              controller: _nameController,
            ),
            const SizedBox(height: 20),
            TextFields(
              name: 'Gender',
              hintText: 'Select you gender',
              controller: _nameController,
            ),
            const SizedBox(height: 20),
            TextFields(
              name: 'Phone Number',
              hintText: 'Enter your Phone Number',
              controller: _nameController,
            ),
            Spacer(),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        const WidgetStatePropertyAll(Color(0xFF1A1A1A)),
                    shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ))),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AccountScreen()));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Place Order',
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
    );
  }
}
