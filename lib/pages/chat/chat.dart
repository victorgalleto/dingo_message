import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../config/my_colors.dart';

class ChatPage extends StatefulWidget {
  
  final String userName;
  final int horarioDaSala;
  final String nomeDaSala;

  ChatPage({this.userName, this.horarioDaSala, this.nomeDaSala});


  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  TextEditingController textEditingController = TextEditingController();
  Stream mensagens;

  @override
  void initState() {

    mensagens = FirebaseFirestore.instance
        .collection("chatRooms")
        .doc(widget.horarioDaSala.toString())
        .collection("mensagens")
        .snapshots();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.top,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 55),
              child: allMessages(),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: _buildTextField("Mensagem..."),
            ),
          ],
        ),
      ),
    );
  }

  Widget allMessages() {
    return StreamBuilder(
      stream: mensagens,
      builder: (context, snapshot) {
        if(snapshot.data == null) return Align(child: Container(padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0), child: CircularProgressIndicator()));
        final listaMensagens = snapshot.data.docs;
        return SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              Text(
                widget.nomeDaSala,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,                  
                ),
              ),
              SizedBox(height: 100),
              for(int i = 0; i < listaMensagens.length; i++)
                buildMensagem(listaMensagens[i]["enviado_por"], listaMensagens[i]["conteudo"])
            ],
          ),
        );
      }
    );
  }

  Widget buildMensagem(String enviadoPor, String conteudo) {
    return Container(
      margin: EdgeInsets.only(left: 30, bottom: 10),
      child: Row(
        children: [
          Icon(Icons.person, color: MyColors.mainColor, size: 30,),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  enviadoPor,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                Text(
                  conteudo,
                  style: TextStyle(fontSize: 15),
                ),            
              ],
            ),
          ),
        ],
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
      child: Row(
        children: [
          Expanded(
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
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              if(textEditingController.text.isNotEmpty){
                addMessage(widget.userName, DateTime.now().millisecondsSinceEpoch, widget.horarioDaSala, textEditingController.text);
                textEditingController.text = "";
              }
            },
            child: Icon(Icons.send, color: MyColors.mainColor,)
          )
        ],
      ),
    );
  }

  void addMessage(String userName, int horarioDaMensagem, int horarioDaSala, String conteudo){
    var mensagem = {
      "conteudo": conteudo,
      "horario": horarioDaMensagem,
      "enviado_por": userName,
    };

    FirebaseFirestore.instance.collection("chatRooms")
        .doc(horarioDaSala.toString())
        .collection("mensagens")
        .doc(horarioDaMensagem.toString())
        .set(mensagem);
  }

  /* Future<Stream> lerMessage() async {
    mensagens = FirebaseFirestore.instance
        .collection("chatRooms")
        .doc(widget.horarioDaSala.toString())
        .collection("mensagens")
        .snapshots();

    return mensagens;
  } */

}