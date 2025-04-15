import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Help Center',
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
            helpOptions(
                img: 'assets/svg/icons/Headphones.svg',
                helpName: 'Customer Service'),
            helpOptions(
                img: 'assets/svg/icons/Whatsapp.svg', helpName: 'Whatsapp'),
            helpOptions(img: 'assets/svg/icons/Web.svg', helpName: 'Website'),
            helpOptions(
                img: 'assets/svg/icons/Facebook.svg', helpName: 'Facebook'),
            helpOptions(
                img: 'assets/svg/icons/Twitter.svg', helpName: 'Twitter'),
            helpOptions(
                img: 'assets/svg/icons/Instagram.svg', helpName: 'Instagram'),
          ],
        ),
      ),
    );
  }
}

class helpOptions extends StatelessWidget {
  final String img;
  final String helpName;
  const helpOptions({super.key, required this.img, required this.helpName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Color(0xFFE6E6E6))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SvgPicture.asset(img),
              SizedBox(width: 15),
              Text(
                helpName,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
