import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:freebie/screens/signup_screen.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Stack(
                children: [
                  const Positioned(
                    left: 20,
                    top: 15,
                    right: 0,
                    child: Text(
                      'Define \nyourself in \nyour unique \nway.',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 50,
                          fontFamily: 'GeneralSans'),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    left: 0,
                    right: 0,
                    child:
                        SvgPicture.asset('assets/svg/get_started_backdrop.svg'),
                  ),
                  Positioned(
                    top: 90,
                    left: 0,
                    right: 0,
                    child: Image.asset('assets/get_started_person.png'),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                            builder: (context) => const SignupScreen()));
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Get Started',
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
            ),
          ],
        ),
      ),
    );
  }
}
