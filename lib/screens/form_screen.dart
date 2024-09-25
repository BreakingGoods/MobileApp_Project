import 'package:account/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/transaction_provider.dart';

class FormScreen extends StatelessWidget {
  FormScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
        appBar: AppBar(
          title: const Text('Movie Data'),
        ),
        body: Form(
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
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'ปีที่ฉาย',
                  ),
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  validator: (String? input) {
                    try {
                      double amount = double.parse(input!);
                      if (amount < 0) {
                        return 'กรุณากรอกข้อมูลมากกว่า 0';
                      }
                    } catch (e) {
                      return 'กรุณากรอกข้อมูลเป็นตัวเลข';
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Genre',
                  ),
                  autofocus: true,
                  controller: titleController,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return 'กรุณากรอกข้อมูล';
                    }
                  },
                ),
                TextButton(
                    child: const Text('บันทึก'),
                    onPressed: () {
                          if (formKey.currentState!.validate())
                            {
                              // create transaction data object
                              var statement = Transaction(
                                  title: titleController.text,
                                  year: double.parse(amountController.text),
                                  date: DateTime.now(), genre: ''
                                  );
                            
                              // add transaction data object to provider
                              var provider = Provider.of<TransactionProvider>(context, listen: false);
                              
                              provider.addTransaction(statement);

                              Navigator.pop(context);
                            }
                        })
              ],
            )));
  }
}
