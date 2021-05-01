import 'package:flutter/material.dart';
import '../../config/my_colors.dart';


class WelcomePage extends StatefulWidget {
  //WelcomePage();


  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.welcomeColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 250,
                    child: Center(
                      child: Text(
                          "Bem-vindo ao \n Dingo Message!",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,              
                          ),
                      ),
                    ),
                  ),
                  SizedBox(height: 150),
                  TextButton(
                    onPressed: () {
                      print("tap");
                    }, 
                    child: Text(
                      "Avançar >",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
          ),
        ),
      ),
    );
  }
}