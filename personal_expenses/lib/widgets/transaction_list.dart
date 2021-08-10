import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteTx;
  TransactionList(this.userTransactions, this.deleteTx);
  @override
  Widget build(BuildContext context) {
    return userTransactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text(
                  "Not Any Transaction added Yet",
                  style: Theme.of(context).textTheme.title,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              // return Card(
              //     child: Row(
              //   children: [
              //     Container(
              //       margin: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
              //       decoration: BoxDecoration(
              //           border: Border.all(color: Colors.purple, width: 2)),
              //       padding: EdgeInsets.all(10),
              //       child: Text(
              //         '\$${userTransactions[index].amount.toStringAsFixed(2)}',
              //         style: TextStyle(
              //             color: Colors.purple,
              //             fontSize: 20,
              //             fontWeight: FontWeight.bold),
              //       ),
              //     ),
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           userTransactions[index].title,
              //           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              //         ),
              //         Text(
              //           DateFormat.yMMMd().format(userTransactions[index].date),
              //           style: TextStyle(
              //             color: Colors.grey,
              //           ),
              //         )
              //       ],
              //     )
              //   ],
              // )
              // );
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: (ListTile(
                  trailing:MediaQuery.of(context).size.width >360 ?
                  FlatButton.icon(
                    onPressed: ()=>deleteTx(userTransactions[index].id),
                     icon: Icon(Icons.delete),
                     label: Text("Delete"),
                     textColor: Theme.of(context).errorColor,
                    )
                  : IconButton(
                    onPressed: () => deleteTx(userTransactions[index].id),
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                  ),
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text(
                                '\$${userTransactions[index].amount.toStringAsFixed(2)}'))),
                  ),
                  title: Text(
                    userTransactions[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                      DateFormat.yMMMd().format(userTransactions[index].date)),
                )),
              );
            },
            itemCount: userTransactions.length,
          );
  }
}
