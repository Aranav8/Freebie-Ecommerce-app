import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../providers/selected_address_provider.dart';
import 'checkout_screen.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  int _isSelected = 0;
  final List<String> addresses = [
    '925 S Chugach St #APT 10, Alaska 99645',
    '2438 6th Ave, Ketchikan, Alaska 99901, USA',
    '2551 Vista Dr #B301, Juneau, Alaska 99801, USA',
    '4821 Ridge Top Cir, Anchorage, Alaska 99508, USA',
  ];

  final List<String> place = [
    'Home',
    'Office',
    'Apartment',
    "Parent's House",
  ];

  void _selectedAddress(int index) {
    setState(() {
      _isSelected = index;
    });
    final selectedAddressProvider =
        Provider.of<SelectedAddressProvider>(context, listen: false);
    selectedAddressProvider.updateAddress(addresses[index], place[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Address',
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
              Text(
                'Saved Address',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
              ),
              buildAddress(
                place: 'Home',
                address: addresses[0],
                isSelected: _isSelected == 0,
                onTap: () => _selectedAddress(0),
              ),
              buildAddress(
                place: 'Office',
                address: addresses[1],
                isSelected: _isSelected == 1,
                onTap: () => _selectedAddress(1),
              ),
              buildAddress(
                place: 'Apartment',
                address: addresses[2],
                isSelected: _isSelected == 2,
                onTap: () => _selectedAddress(2),
              ),
              buildAddress(
                place: "Parent's House",
                address: addresses[3],
                isSelected: _isSelected == 3,
                onTap: () => _selectedAddress(3),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add),
                      SizedBox(width: 15),
                      Text(
                        'Add New Address',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16),
                      )
                    ],
                  ),
                ),
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
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CheckoutScreen()));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Apply',
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
        ));
  }
}

class buildAddress extends StatelessWidget {
  final String place;
  final String address;
  final bool isSelected;
  final VoidCallback onTap;
  const buildAddress({
    super.key,
    required this.place,
    required this.address,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
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
                        place,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16),
                      ),
                      SizedBox(height: 5),
                      Text(
                        address,
                        style: TextStyle(color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: isSelected ? Colors.black : Colors.grey),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: isSelected
                      ? Center(
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.black
                                  : Colors.transparent,
                              border: Border.all(
                                  color:
                                      isSelected ? Colors.black : Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
