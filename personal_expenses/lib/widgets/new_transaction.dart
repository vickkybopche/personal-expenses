import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

   DateTime  _selectedDate = DateTime.now(); 


  void _submitData() {
    if(_amountController.text.isEmpty==null){
      return ;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(_titleController.text, double.parse(_amountController.text),
      _selectedDate,
    );

    Navigator.of(context).pop();
  }
  void _presentDatePicker(){
    showDatePicker(
      context: context,
       initialDate: DateTime.now(),
        firstDate: DateTime(2019),
         lastDate: DateTime.now(),).then((pickedDate) {
           if(pickedDate == null)
           {
             return;
           }
           setState(() {
             _selectedDate = pickedDate;
           });

         } );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5.0,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom +10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                // onChanged: (value)=>titleText=value,
                controller: _titleController,
                onSubmitted: (_) => _submitData,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                //  onChanged: (value){amountText=value;},
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData,
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(child: Text(_selectedDate==null?"NO DATE CHOOSEN!":'Picked Date : ${DateFormat.yMd().format(_selectedDate)}')),
                    FlatButton(
                        onPressed: _presentDatePicker,
                        child: Text(
                          "Choose Date",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.purple),
                        ))
                  ],
                ),
              ),
              RaisedButton(
                  onPressed:
                      // print(titleText),
                      // print(amountText)
                      // print(titleController.text),
                      // print(amountController.text)
                      _submitData,
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button?.color,
                  child: Text("Add Transcation",)),
            ],
          ),
        ),
      ),
    );
  }
}
