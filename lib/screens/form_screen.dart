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
  final genreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (isEditing && movie != null) {
      titleController.text = movie!.title;
      yearController.text = movie!.year.toString();
      genreController.text = movie!.genre;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('แบบฟอร์มข้อมูล'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Increase padding for more spacing
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Movie Title',
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1.0), // Thin border
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.withOpacity(0.5), width: 1.0),
                  ),
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
              const SizedBox(height: 16), 
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Year',
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1.0),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.withOpacity(0.5), width: 1.0),
                  ),
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
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Genre',
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 1.0),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue.withOpacity(0.5), width: 1.0),
                  ),
                ),
                controller: genreController,
                validator: (String? str) {
                  if (str!.isEmpty) {
                    return 'กรุณากรอกข้อมูล';
                  }
                  return null; 
                },
              ),
              const SizedBox(height: 32), 
              Center( 
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      var transaction = Transaction(
                        title: titleController.text,
                        year: double.parse(yearController.text),
                        genre: genreController.text,
                      );

                      var provider = Provider.of<TransactionProvider>(context, listen: false);

                      if (isEditing && movieIndex != null) {
                        provider.updateTransaction(movieIndex!, transaction);
                      } else {
                        provider.addTransaction(transaction);
                      }

                      Navigator.pop(context); 
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[100], 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0), 
                  ),
                  child: const Text('Save', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
