import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../config/my_colors.dart';
import '../chat/chat.dart';

class ChatroomsPage extends StatefulWidget {
  
  final String userName;

  ChatroomsPage({this.userName});


  @override
  _ChatroomsPageState createState() => _ChatroomsPageState();
}

class _ChatroomsPageState extends State<ChatroomsPage> {

  TextEditingController textEditingController = TextEditingController();
  Stream salas;

  @override
  void initState() {

    salas = FirebaseFirestore.instance
        .collection("chatRooms")
        .snapshots();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.top,
        body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50),
                Text(
                  "Salas \n Disponíveis",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,                  
                  ),
                ),
                SizedBox(height: 100),
                Text(
                  "@${widget.userName}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                    fontSize: 20,                  
                  ),
                ),
                SizedBox(height: 50),
                _buildTextField("# Criar uma sala"),          
                SizedBox(height: 10),        
                add(),
                SizedBox(height: 10),
                todasSalas(),
                //allRooms(),
              ],
            ),
          ),
      ),
    );
  }

    Widget _buildTextField(String hint) {
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

  Widget todasSalas() {
    return StreamBuilder(
      stream: salas,
      builder: (context, snapshot) {
        if(snapshot.data == null) return Align(child: Container(padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0), child: CircularProgressIndicator()));
        final listaSalas = snapshot.data.docs;
        return Column(
          children: [
            for(int i = 0; i < listaSalas.length; i++)
              buildSala("# " + listaSalas[i]["nome_da_sala"], listaSalas[i]["horario"]),
          ],
        );
      },
    );
  }


  Widget buildSala(String nomeDaSala, int horarioDaSala) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) => ChatPage(userName: widget.userName, horarioDaSala: horarioDaSala, nomeDaSala: nomeDaSala))
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(nomeDaSala),
            Icon(Icons.circle, color: Colors.green,),
          ],      
        ),
      ),
    );
  }


  Widget add() {
    int horario = DateTime.now().millisecondsSinceEpoch;
    return GestureDetector(
      onTap: () {
        if(textEditingController.text.isNotEmpty){
          criarSala(textEditingController.text, widget.userName,horario);
          setState(() {
            textEditingController.text = "";
          });
        }        
      },
      child: Icon(Icons.add),
    );
  }



  void criarSala(String salaNome, String userName, int horario) {

    var salaDados = {
      "nome_da_sala": salaNome,
      "horario": horario,
      "criado_por": userName
    };

    FirebaseFirestore.instance.collection("chatRooms")
        .doc(horario.toString())
        .set(salaDados);
  }

}