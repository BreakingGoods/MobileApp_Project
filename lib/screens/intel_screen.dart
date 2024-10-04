import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/transaction_provider.dart';
import 'form_screen.dart'; 
import 'package:account/models/transaction.dart';

class IntelScreen extends StatelessWidget{
  final Transaction transaction;
    const IntelScreen({Key? key, required this.transaction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Details'),
      ),
      body: Padding(
        padding:const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Title: ${transaction.title}',style: TextStyle(fontSize: 20)),SizedBox(height: 10),
              Text('Reslease Year: ${transaction.year.round()}',style: TextStyle(fontSize: 20),),SizedBox(height: 10,),
              Text('Genre: ${transaction.genre}',style: TextStyle(fontSize: 20)),SizedBox(height: 10,),
              
            ],
          ),
      ),);}
}