import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<OrderProvider>(context, listen: false).loadOrders();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'My Orders',
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
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TabBar(
                  dividerColor: Colors.transparent,
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey[600],
                  labelStyle:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  unselectedLabelStyle:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                  tabs: [
                    Tab(
                        child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text("Ongoing"),
                    )),
                    Tab(
                        child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text("Completed"),
                    )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrderList("In Transit"),
          _buildOrderList("Completed"),
        ],
      ),
    );
  }

  Widget _buildOrderList(String status) {
    return Consumer<OrderProvider>(
      builder: (context, orderProvider, child) {
        final orders = orderProvider.orders
            .where((order) => order['status'] == status)
            .toList();
        if (orders.isEmpty) {
          return _buildEmptyOrdersScreen("No $status Orders!");
        }
        return ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return _buildOrderItem(order);
          },
        );
      },
    );
  }

  Widget _buildOrderItem(Map<String, dynamic> order) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Color(0xFFE6E6E6))),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Order #${order['id']}',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            ...order['items']
                .map<Widget>((item) => _buildOrderItemRow(item))
                .toList(),
            SizedBox(height: 8),
            Text('Total: ₹${order['total'].toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Status: ${order['status']}'),
            SizedBox(height: 8),
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
                onPressed: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Track Order',
                      style: TextStyle(color: Colors.white),
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

  Widget _buildOrderItemRow(Map<String, dynamic> item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Image.asset(item['image'], width: 50, height: 50),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item['name'],
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Size: ${item['size']} | Quantity: ${item['quantity']}'),
              ],
            ),
          ),
          Text('₹${item['price']}'),
        ],
      ),
    );
  }

  Widget _buildEmptyOrdersScreen(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/svg/icons/Box.svg',
            height: 70,
            color: Color(0xFFB3B3B3),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25, bottom: 10),
            child: Text(
              message,
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            "You don't have any orders \nat this time.",
            style: TextStyle(
              color: Color(0xFF808080),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
