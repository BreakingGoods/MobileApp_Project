import 'package:account/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/transaction_provider.dart';

class FormScreen extends StatelessWidget {
  final bool isEditing;
  final int? movieIndex;
  final Transaction? movie;
  
  FormScreen({super.key, required this.isEditing, this.movieIndex, this.movie});

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final yearController = TextEditingController();
  final gentrController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    if (isEditing && movie != null) {
      titleController.text = movie!.title;
      yearController.text = movie!.year.toString();
      gentrController.text = movie!.gentr;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('แบบฟอร์มข้อมูล'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Movie Title',
                ),
                autofocus: true,
                controller: titleController,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return 'กรุณากรอกข้อมูล';
                  }
                  return null; 
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Year',
                ),
                keyboardType: TextInputType.number,
                controller: yearController,
                validator: (String? input) {
                  try {
                    double year = double.parse(input!);
                    if (year < 0) {
                      return 'กรุณากรอกข้อมูลมากกว่า 0';
                    }
                  } catch (e) {
                    return 'กรุณากรอกข้อมูลเป็นตัวเลข';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Genre'),
                controller: gentrController,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return 'กรุณากรอกข้อมูล';
                  }
                  return null; 
                },
              ),
              TextButton(
                child: const Text('Save'),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    var statement = Transaction(
                      title: titleController.text,
                      year: double.parse(yearController.text),
                      gentr: gentrController.text,
                    );

                    var provider = Provider.of<TransactionProvider>(context, listen: false);

                    if (isEditing && movieIndex != null) {
               
                      provider.updateTransaction(movieIndex!, statement);
                    } else {
                 
                      provider.addTransaction(statement);
                    }

                    Navigator.pop(context); 
                  }
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
