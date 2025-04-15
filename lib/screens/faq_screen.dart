import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FAQsScreen extends StatefulWidget {
  const FAQsScreen({super.key});

  @override
  State<FAQsScreen> createState() => _FAQsScreenState();
}

class _FAQsScreenState extends State<FAQsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'FAQs',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            children: [
              buildFAQs(
                faq: 'How do I make a purchase?',
                answer:
                    'To make a purchase, select the product, add it to your cart, and proceed to checkout.',
              ),
              buildFAQs(
                faq: 'What payment methods are accepted?',
                answer:
                    'We accept various payment methods such as credit cards, debit cards, and UPI.',
              ),
              buildFAQs(
                faq: 'How do I track my orders?',
                answer:
                    'You can track your orders from the "My Orders" section in your profile.',
              ),
              buildFAQs(
                faq: 'Can I cancel or return my order?',
                answer:
                    'Yes, you can cancel or return your order within the specified period. Please refer to our return policy.',
              ),
              buildFAQs(
                faq: 'How can I contact customer support for assistance?',
                answer:
                    'You can contact customer support through our help center or by emailing us at support@example.com.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class buildFAQs extends StatelessWidget {
  final String faq;
  final String answer;

  const buildFAQs({
    super.key,
    required this.faq,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: ExpansionTile(
        title: Container(
          child: Text(
            faq,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Color(0xFFF9F9F9),
              border: Border.all(color: Color(0xFFE6E6E6)),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Text(
              answer,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
