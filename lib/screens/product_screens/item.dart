import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../notification_screen.dart';

class ItemScreen extends StatefulWidget {
  final Map<String, dynamic> product;
  const ItemScreen({super.key, required this.product});

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  int? selectedIndex;

  void _selectSize(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final sizeOptions = (product['sizes'] as List?)?.cast<String>() ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Details',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              ),
              child: SvgPicture.asset(
                'assets/svg/icons/Bell.svg',
                height: 30,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Image.asset(product['image']),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Text(
                product['name'],
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Row(
                children: [
                  SvgPicture.asset('assets/svg/icons/Star.svg'),
                  SizedBox(width: 5),
                  Text(
                    '4.0/5',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 5),
                  Text(
                    '(45 reviews)',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Text(
                product['text'],
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 15),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Text(
                'Choose Size',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Row(
                children: [
                  for (int i = 0; i < sizeOptions.length; i++)
                    buildSizeChoose(i, sizeOptions[i]),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Text(
                'Reviews',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                children: [
                  Text(
                    product['rating'],
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 48,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/svg/icons/Star.svg',
                              height: 25,
                              width: 25,
                            ),
                            SizedBox(width: 5),
                            SvgPicture.asset(
                              'assets/svg/icons/Star.svg',
                              height: 25,
                              width: 25,
                            ),
                            SizedBox(width: 5),
                            SvgPicture.asset(
                              'assets/svg/icons/Star.svg',
                              height: 25,
                              width: 25,
                            ),
                            SizedBox(width: 5),
                            SvgPicture.asset(
                              'assets/svg/icons/Star.svg',
                              height: 25,
                              width: 25,
                            ),
                            SizedBox(width: 5),
                            SvgPicture.asset(
                              'assets/svg/icons/Star.svg',
                              color: Colors.grey,
                              height: 25,
                              width: 25,
                            ),
                            SizedBox(width: 5),
                          ],
                        ),
                        Text(
                          '1034 Ratings',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Row(
                children: [
                  SvgPicture.asset('assets/svg/icons/Star.svg'),
                  SizedBox(width: 5),
                  SvgPicture.asset('assets/svg/icons/Star.svg'),
                  SizedBox(width: 5),
                  SvgPicture.asset('assets/svg/icons/Star.svg'),
                  SizedBox(width: 5),
                  SvgPicture.asset('assets/svg/icons/Star.svg'),
                  SizedBox(width: 5),
                  SvgPicture.asset('assets/svg/icons/Star.svg'),
                  SizedBox(width: 15),
                  Container(
                    width: 200,
                    height: 10,
                    decoration: BoxDecoration(
                        color: Color(0xFFE6E6E6),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Row(
                children: [
                  SvgPicture.asset('assets/svg/icons/Star.svg'),
                  SizedBox(width: 5),
                  SvgPicture.asset('assets/svg/icons/Star.svg'),
                  SizedBox(width: 5),
                  SvgPicture.asset('assets/svg/icons/Star.svg'),
                  SizedBox(width: 5),
                  SvgPicture.asset('assets/svg/icons/Star.svg'),
                  SizedBox(width: 5),
                  SvgPicture.asset(
                    'assets/svg/icons/Star.svg',
                    color: Colors.grey,
                  ),
                  SizedBox(width: 15),
                  Container(
                    width: 200,
                    height: 10,
                    decoration: BoxDecoration(
                        color: Color(0xFFE6E6E6),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Row(
                children: [
                  SvgPicture.asset('assets/svg/icons/Star.svg'),
                  SizedBox(width: 5),
                  SvgPicture.asset('assets/svg/icons/Star.svg'),
                  SizedBox(width: 5),
                  SvgPicture.asset('assets/svg/icons/Star.svg'),
                  SizedBox(width: 5),
                  SvgPicture.asset(
                    'assets/svg/icons/Star.svg',
                    color: Colors.grey,
                  ),
                  SizedBox(width: 5),
                  SvgPicture.asset(
                    'assets/svg/icons/Star.svg',
                    color: Colors.grey,
                  ),
                  SizedBox(width: 15),
                  Container(
                    width: 200,
                    height: 10,
                    decoration: BoxDecoration(
                        color: Color(0xFFE6E6E6),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Row(
                children: [
                  SvgPicture.asset('assets/svg/icons/Star.svg'),
                  SizedBox(width: 5),
                  SvgPicture.asset(
                    'assets/svg/icons/Star.svg',
                    color: Colors.grey,
                  ),
                  SizedBox(width: 5),
                  SvgPicture.asset(
                    'assets/svg/icons/Star.svg',
                    color: Colors.grey,
                  ),
                  SizedBox(width: 5),
                  SvgPicture.asset(
                    'assets/svg/icons/Star.svg',
                    color: Colors.grey,
                  ),
                  SizedBox(width: 5),
                  SvgPicture.asset(
                    'assets/svg/icons/Star.svg',
                    color: Colors.grey,
                  ),
                  SizedBox(width: 15),
                  Container(
                    width: 200,
                    height: 10,
                    decoration: BoxDecoration(
                        color: Color(0xFFE6E6E6),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: Text(
                '45 Reviews',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                ),
              ),
            ),
            Review(
              comment:
                  'The item is very good, my son likes it very much and plays every day.',
              name: 'Wade Warren',
              postedOn: '• 6 days ago',
            ),
            Review(
              comment:
                  'The seller is very fast in sending packet, I just bought it and the item arrived in just 1 day!',
              name: 'Guy Hawkins',
              postedOn: '• 1 week ago',
              color: Colors.grey,
            ),
            Review(
              comment:
                  'I just bought it and the stuff is really good! I highly recommend it!',
              name: 'Robert Fox',
              postedOn: '• 2 weeks ago',
              color: Colors.grey,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Price',
                        style: TextStyle(
                            fontWeight: FontWeight.w300, color: Colors.grey),
                      ),
                      Text(
                        "₹${product['price']}",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 22),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 230,
                    height: 50,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xFF1A1A1A)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                      ),
                      onPressed: () {
                        if (selectedIndex == null) {
                          // Show error if no size selected
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please select a size!'),
                            ),
                          );
                        } else {
                          // Add item to cart
                          Provider.of<CartProvider>(context, listen: false)
                              .addItem(product, sizeOptions[selectedIndex!]);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Item added to cart!'),
                            ),
                          );
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/svg/icons/Bag.svg'),
                          SizedBox(width: 5),
                          Text(
                            'Add to Cart',
                            style: TextStyle(color: Colors.white),
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
      ),
    );
  }

  Padding buildSizeChoose(int index, String size) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => _selectSize(index),
        child: Container(
          decoration: BoxDecoration(
            color: selectedIndex == index ? Colors.black : Colors.transparent,
            border: Border.all(
              color: selectedIndex == index ? Colors.black : Color(0xFFE6E6E6),
              width: 2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          width: 60,
          height: 60,
          child: Center(
            child: Text(
              size,
              style: TextStyle(
                  color: selectedIndex == index ? Colors.white : Colors.black,
                  fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}

class Review extends StatelessWidget {
  final String comment;
  final String name;
  final String postedOn;
  final Color? color;

  Review({
    super.key,
    required this.comment,
    required this.name,
    required this.postedOn,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Row(
            children: [
              SvgPicture.asset('assets/svg/icons/Star.svg'),
              SizedBox(width: 5),
              SvgPicture.asset('assets/svg/icons/Star.svg'),
              SizedBox(width: 5),
              SvgPicture.asset('assets/svg/icons/Star.svg'),
              SizedBox(width: 5),
              SvgPicture.asset('assets/svg/icons/Star.svg'),
              SizedBox(width: 5),
              SvgPicture.asset(
                'assets/svg/icons/Star.svg',
                color: color,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: Text(comment),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: Row(
            children: [
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              SizedBox(width: 5),
              Text(
                postedOn,
                style:
                    TextStyle(fontWeight: FontWeight.w400, color: Colors.grey),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          child: Divider(),
        ),
      ],
    );
  }
}
