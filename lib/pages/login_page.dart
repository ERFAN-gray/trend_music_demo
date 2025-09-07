import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:glossy/glossy.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trend_music_demo/models/constants.dart';
import 'package:trend_music_demo/pages/home_page.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Flexible(
            //   child: Hero(
            //     tag: 'logo',
            //     child: Image.asset("assets/logo/tremu_logo.png", height: 150),
            //   ),
            // ),
            Flexible(
              child: Hero(
                tag: 'title',
                child: Text(
                  "T r e m u",
                  style: GoogleFonts.workbench(
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black45,
                        offset: Offset(7.0, 5.0),
                      ),
                    ],
                    fontSize: 70,
                    color: Color.fromARGB(255, 232, 97, 126),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/backgrounds/musicBack2.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: GlossyContainer(
                padding: EdgeInsets.all(5),
                height: 400,
                width: double.infinity,
                borderRadius: BorderRadius.circular(35),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/backgrounds/cuteanimegirl.png",
                      height: 150,
                    ),

                    //text fields
                    kTextfieldDecoration("Username", Icons.person),
                    SizedBox(height: 5),
                    kTextfieldDecoration("Password", Icons.lock),
                    //login button
                    Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            207,
                            252,
                            46,
                            115,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 130,
                            vertical: 20,
                          ),
                        ),
                        onPressed: () async {
                          // Handle login logic here
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => HomePage()),
                          // );

                          try {
                            final url = Uri.parse(
                              "https://73vkk68w-3000.usw3.devtunnels.ms/auth/login",
                            );
                            final response = await http.post(
                              url,
                              headers: {"Content-Type": "application/json"},
                              body: jsonEncode({
                                "identifier": "grayerf",
                                "password": "12341234",
                              }),
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );

                            print(response.body);
                          } catch (e) {}
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
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
      ),
    );
  }
}
