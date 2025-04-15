import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountNotificationScreen extends StatefulWidget {
  const AccountNotificationScreen({super.key});

  @override
  State<AccountNotificationScreen> createState() =>
      _AccountNotificationScreenState();
}

class _AccountNotificationScreenState extends State<AccountNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Notifications',
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
            notificationsOptions(
                name: 'General Notifications',
                prefKey: 'general_notifications'),
            Divider(),
            notificationsOptions(name: 'Sound', prefKey: 'sound'),
            Divider(),
            notificationsOptions(name: 'Vibrate', prefKey: 'vibrate'),
            Divider(),
            notificationsOptions(
                name: 'Special Offers', prefKey: 'special_offers'),
            Divider(),
            notificationsOptions(
                name: 'Promo & Discounts', prefKey: 'promo_discounts'),
            Divider(),
            notificationsOptions(name: 'Payments', prefKey: 'payments'),
            Divider(),
            notificationsOptions(name: 'Cashback', prefKey: 'cashback'),
            Divider(),
            notificationsOptions(name: 'App Updates', prefKey: 'app_updates'),
            Divider(),
            notificationsOptions(
                name: 'New Service Available',
                prefKey: 'new_service_available'),
            Divider(),
            notificationsOptions(
                name: 'New Tips Available', prefKey: 'new_tips_available'),
            Divider(),
          ],
        ),
      ),
    );
  }
}

class notificationsOptions extends StatelessWidget {
  final String name;
  final String prefKey;

  const notificationsOptions({
    super.key,
    required this.name,
    required this.prefKey,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Text(
            name,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          Spacer(),
          ToggleSwitch(prefKey: prefKey),
        ],
      ),
    );
  }
}

class ToggleSwitch extends StatefulWidget {
  final String prefKey;

  ToggleSwitch({required this.prefKey});

  @override
  _ToggleSwitchState createState() => _ToggleSwitchState();
}

class _ToggleSwitchState extends State<ToggleSwitch> {
  bool isToggled = false;

  @override
  void initState() {
    super.initState();
    _loadToggleState();
  }

  _loadToggleState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isToggled = prefs.getBool(widget.prefKey) ?? false;
    });
  }

  _saveToggleState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(widget.prefKey, isToggled);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isToggled = !isToggled;
          _saveToggleState();
        });
      },
      child: Container(
        width: 60,
        height: 30,
        decoration: BoxDecoration(
          color: isToggled ? Colors.black : Color(0xFFE6E6E6),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              AnimatedPositioned(
                duration: Duration(milliseconds: 200),
                curve: Curves.easeIn,
                left: isToggled ? 30 : 0,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
