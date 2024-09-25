import 'package:account/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/transaction_provider.dart';

class FormScreen extends StatelessWidget {
  FormScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final yearController = TextEditingController();
  final gentrController = TextEditingController();

  @override
  Widget build(BuildContext context) {
  
    var scaffold = Scaffold(
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
                      labelText: 'ชื่อรายการ',
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
                      labelText: 'Year',
                    ),
                    keyboardType: TextInputType.number,
                    controller: yearController,
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
                    labelText: 'gentr'
                    ),
                    controller: gentrController,
                  ),
                  TextButton(
                      child: const Text('บันทึก'),
                      onPressed: () {
                            if (formKey.currentState!.validate())
                              {
                              
                                var statement = Transaction(
                                    title: titleController.text,
                                    year: double.parse(yearController.text),
                                    gentr: gentrController.text
                                   
                                    );
                              
                         
                                var provider = Provider.of<TransactionProvider>(context, listen: false);
                                
                                provider.addTransaction(statement);
          
                                Navigator.pop(context);
                              }
                          },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white, backgroundColor:Colors.blue,
                        ) ,)
                        
                ],
              )),
        ));
    return scaffold;
  }
}
