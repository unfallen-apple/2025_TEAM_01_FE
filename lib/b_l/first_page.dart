import 'package:semoton_front/main.dart';
import 'package:semoton_front/b_l/sign_up_page.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              'assets/chat_home.png',
              fit: BoxFit.fitWidth,
            ),
          ),
        Column(
          children: [
            Positioned(
              top: 400,
              left: 30,
              right: 30,
              child: Image.asset('assets/logo.png',width: 400,height: 400,),
            ),
            Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade200,
                        shadowColor: Colors.black.withOpacity(0.3),
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(color: Colors.white, width: 2),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 100),
                      ),
                      child: SizedBox(
                        width: 70,
                        height: 40,
                        child: Center(
                          child: const Text(
                            'LOGIN',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink.shade200,
                        shadowColor: Colors.black,
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(color: Colors.white, width: 2),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 100),
                      ),
                      child: SizedBox(
                        width: 70,
                        height: 40,
                        child: Center(
                          child: const Text(
                            'JOIN',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        ],
      ),

    );
  }
}

