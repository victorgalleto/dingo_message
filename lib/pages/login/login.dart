import 'package:flutter/material.dart';
import '../../config/my_colors.dart';

class LoginPage extends StatefulWidget {
  //LoginPage();


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

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
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,                  
                  ),
                ),
                SizedBox(height: 250),
                _buildTextFormField("@usuario"),
                SizedBox(height: 100),
                button("Entrar"),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField(String hint, {int maxLine = 1}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100], 
          borderRadius: BorderRadius.circular(10.0)
      ),
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        initialValue: "",
        decoration: InputDecoration(hintText: "$hint"),
        maxLines: maxLine,
        keyboardType: TextInputType.text,
        validator: (String value) {
          // String error
          if (value.isEmpty) {
            return "O seu campo está vazio";
          }
        },
        onSaved: (String value) {
          setState(() {
            userName = value;
          });
        }
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