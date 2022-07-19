import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transactions extends StatefulWidget {
  Transactions({Key? key}) : super(key: key);

  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:StreamBuilder(
          stream: FirebaseFirestore.instance.collection('transactions').where('userid',isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            return streamSnapshot.connectionState==ConnectionState.waiting?
            Center(child: CircularProgressIndicator(),):
            Container(
              child:ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (BuildContext context,int index){
                    DateTime dateTime = (streamSnapshot.data!.docs[index]['date']).toDate();
                    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
                    return Container(
                        margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                        padding: EdgeInsets.only(top: 12,left: 10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey.shade300),
                        child:
                        Column(
                          children: [
                            Row(
                              //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                    flex: 4,
                                    child:
                                        Text(streamSnapshot.data!.docs[index]['plan'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                                     ),
                                Expanded(
                                    flex: 2,
                                    child:
                                        Text('\u{20B9} '+streamSnapshot.data!.docs[index]['price'].toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                                    ),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Align(alignment: Alignment.centerLeft,
                             child: Text(formattedDate),),
                            SizedBox(height: 10,)
                          ],
                        )
                    );
                  }
              ),
            );
          },
        )
    );
  }
}
