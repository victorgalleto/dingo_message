import 'package:dingo_message/pages/chat_rooms/chat_rooms.dart';
import 'package:flutter/material.dart';
import '../../config/my_colors.dart';

class LoginPage extends StatefulWidget {
  //LoginPage();


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController textEditingController = TextEditingController();
  String userName;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.top,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Usuário",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,                  
                  ),
                ),
                SizedBox(height: 250),
                _buildTextField("@usuario"),
                SizedBox(height: 100),
                GestureDetector(
                  onTap: () {
                    if(textEditingController.text.isNotEmpty) {                      
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) => ChatroomsPage(userName: textEditingController.text,)),
                      );
                    }                    
                  },
                  child: button("Entrar"),
                ),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

    Widget _buildTextField(String hint, {int maxLine = 1}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100], 
          borderRadius: BorderRadius.circular(10.0)
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: Colors.grey,//redAccent[400],//orangeAccent[400],//redAccent[400],//orangeAccent[700],//purple[900],
              fontSize: 16,
              fontWeight: FontWeight.w400
            ),
            border: InputBorder.none
        ),
      ),
    );
  }

  Widget button(String btnText) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: 50.0,
      decoration: BoxDecoration(
          color: MyColors.mainColor, 
          borderRadius: BorderRadius.circular(25.0)
      ),
      child: Center(
        child: Text(
          "$btnText",
          style: TextStyle(
            color: Colors.white,//indice == 0? Colors.white : Colors.purple[900],
            fontSize: 18.0,
            fontWeight: FontWeight.bold,//indice == 0? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

}