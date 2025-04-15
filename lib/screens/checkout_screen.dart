import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freebie/screens/address_screen.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';
import '../providers/price_provider.dart';
import '../providers/selected_address_provider.dart';
import 'my_orders_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _selectedPaymentIndex = 0;

  void _selectedPaymentOption(int index) {
    setState(() {
      _selectedPaymentIndex = index;
    });
  }

  // void _showOrderPlacedDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Order Placed'),
  //         content: Text('Your order has been successfully placed!'),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text('OK'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               Navigator.pushReplacement(
  //                 context,
  //                 MaterialPageRoute(builder: (context) => MyOrdersScreen()),
  //               );
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  void _showOrderPlacedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0), // Remove default padding
          content: Container(
            padding: EdgeInsets.all(20), // Custom padding
            child: Column(
              mainAxisSize: MainAxisSize.min, // Adjust size to content
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 3),
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xFFB4E380),
                    ),
                    child: Center(
                        child: Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 30,
                    )),
                  ),
                ),
                Text(
                  'Order Placed',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                SizedBox(height: 10),
                Text(
                  'Your order has been successfully placed!',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 15),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xFF1A1A1A)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MyOrdersScreen()),
                      );
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(color: Colors.white),
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
    final priceProvider = Provider.of<PriceProvider>(context);
    final selectedAddressProvider =
        Provider.of<SelectedAddressProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final orderProvider = Provider.of<OrderProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Checkout',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Delivery Address',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddressScreen()));
                  },
                  child: Text(
                    'Change Address',
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  SvgPicture.asset('assets/svg/icons/Location.svg'),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedAddressProvider.place,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Text(
                          selectedAddressProvider.selectedAddress,
                          style: TextStyle(color: Colors.grey),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Divider(),
            ),
            Text(
              'Payment Method',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BuildPaymentMethod(
                    isSelected: _selectedPaymentIndex == 0,
                    name: 'Card',
                    onTap: () {
                      _selectedPaymentOption(0);
                    },
                    paymentImg: 'assets/svg/icons/Card.svg',
                  ),
                  BuildPaymentMethod(
                    isSelected: _selectedPaymentIndex == 1,
                    name: 'Cash',
                    onTap: () {
                      _selectedPaymentOption(1);
                    },
                    paymentImg: 'assets/svg/icons/Cash.svg',
                  ),
                  BuildPaymentMethod(
                    isSelected: _selectedPaymentIndex == 2,
                    name: '',
                    onTap: () {
                      _selectedPaymentOption(2);
                    },
                    paymentImg: 'assets/svg/icons/apple-pay.svg',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(
                      color: Colors.grey,
                    )),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SvgPicture.asset('assets/svg/icons/visa.svg'),
                    ),
                    Text(
                      '**** **** **** 5123',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SvgPicture.asset('assets/svg/icons/Edit.svg'),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Order Summary',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Sub-Total:',
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                ),
                Text(
                  '₹${priceProvider.subtotal.toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Platform Fee:',
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                ),
                Text(
                  '₹${priceProvider.platformFee.toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Delivery Charges:',
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                ),
                Text(
                  '₹${priceProvider.deliveryCharges.toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Container(
                      height: 60,
                      width: 270,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(
                            color: Colors.grey,
                          )),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: SvgPicture.asset(
                                'assets/svg/icons/Discount.svg'),
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Enter promo code',
                                hintStyle:
                                    TextStyle(color: Colors.grey, fontSize: 16),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.black,
                      ),
                      child: Center(
                        child: Text(
                          'Add',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
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
                  orderProvider.addOrder(
                      cartProvider.items, priceProvider.total);
                  cartProvider.clearCart();
                  _showOrderPlacedDialog();
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

class BuildPaymentMethod extends StatelessWidget {
  final bool isSelected;
  final String? name;
  final void Function()? onTap;
  final String paymentImg;

  const BuildPaymentMethod({
    super.key,
    required this.isSelected,
    this.name,
    required this.onTap,
    required this.paymentImg,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 110,
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                paymentImg,
                color: isSelected ? Colors.white : Colors.black,
              ),
              SizedBox(width: 5),
              Text(
                name!,
                style:
                    TextStyle(color: isSelected ? Colors.white : Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
