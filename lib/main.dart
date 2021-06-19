
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
void main()=> runApp(MiApp());
class MiApp extends StatelessWidget {
  const MiApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MiApp",
      home: Inicio(),
    );
  }
}
  class Inicio extends StatefulWidget {
    Inicio({Key key}) : super(key: key);
  
    @override
    _InicioState createState() => _InicioState();
  }
  
  class _InicioState extends State<Inicio> {
    Future<List<Post>>getData() async{
      var response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/comments"),
        headers: {"Accept":"application/json"}
      );
      var data=json.decode(response.body);
      print(data);
      List<Post> posts=[];
      for(var p in data){
        Post post=Post(p["id"],p["name"],p["email"]);
        posts.add(post);
      }
      print(posts.length);
      return posts;
    }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
         appBar: AppBar(
           title:Text("Leonardo Arabe") 
         ),
         body: Container(
           child: FutureBuilder(
             future: getData(),
             builder: (BuildContext context, AsyncSnapshot snapshot) {
               print(snapshot.data);
               if(snapshot.data == null){
                 return Container(child: Center(child: Text("Cargando..."),),);
               }
               else{
                 return ListView.builder(
                   itemCount: snapshot.data.length,
                   itemBuilder: (BuildContext context, int id){
                     return ListTile(title:Text(snapshot.data[id].name),
                     subtitle: Text(snapshot.data[id].email.toString()));
                   }
                 );
               }
             }
             )
         )
      );
    }
  }
class Post {
  final int id;
  final String name;
  final String email;

  Post (this.id, this.name, this.email);
}
