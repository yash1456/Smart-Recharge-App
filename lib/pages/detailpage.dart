import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  String id;
  DetailPage(this.id,{Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text('pack details'),
         centerTitle: true,
       ),
        body:FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance
              .collection('packs')
              .doc(widget.id)
              .get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError)
              return Center(
                child: Text(snapshot
                    .hasError
                    .toString()),
              );
            if(snapshot.connectionState==ConnectionState.waiting)
              return Center(child:CircularProgressIndicator());
            return Column(
              children: [
               SizedBox(height: 40,),
               Center(child: Text('\u{20B9} '+snapshot.data!['charges'].toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16)),),
               Container(
            margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
            padding: EdgeInsets.only(top: 12,bottom: 8),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey.shade300),
            child:
            Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            Row(
            children: [
            Expanded(
            flex: 1,
            child: Icon(Icons.call)
            ),
            Expanded(
            flex: 3,
            child: Text(snapshot.data!['calls'].toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
            ),
            ],
            ),
            Divider(color: Colors.grey,),
            Row(
            children: [
            Expanded(
            flex: 1,
            child: Icon(Icons.four_g_mobiledata)
            ),
            Expanded(
            flex: 3,
            child: Text(snapshot.data!['data'].toString()+' per day',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
            ),
            ],
            ),
            Divider(color: Colors.grey,),
            Row(
            children: [
            Expanded(
            flex: 1,
            child: Icon(Icons.calendar_month_sharp)
            ),
            Expanded(
            flex: 3,
            child: Text(snapshot.data!['validity'].toString()+' days',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
            ),
            ],
            ),
            Divider(color: Colors.grey,),
            Row(
            children: [
            Expanded(
            flex: 1,
            child: Icon(Icons.sms_sharp)
            ),
            Expanded(
            flex: 3,
            child: Text(snapshot.data!['sms'].toString()+' per day',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
            ),
            ],
            ),
            ])
            ),
               Container(
                 margin: EdgeInsets.only(left: 10,right: 10),
                 width: double.infinity,
                 child: ElevatedButton(
                     onPressed: () async {
                       int b;
                       int price=snapshot.data!['charges'];
                       int remainnig;
                       var document = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid);
                       document.get().then((value) => {
                         print(value['balance']),
                         b=int.parse(value['balance']),
                         if(b<1 || b<price)
                         {
                           showAlertDialog(context,'Your Remaining balance is not enough to recharge this pack!'),
                         }
                         else{
                           remainnig=b-price,
                           FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(
                               {
                                 'balance':remainnig.toString(),
                               }).whenComplete(() => {
                                 FirebaseFirestore.instance.collection('transactions').add(
                                     {
                                       'plan':snapshot.data!['name'],
                                       'userid':FirebaseAuth.instance.currentUser!.uid,
                                       'price':snapshot.data!['charges'],
                                       'date':DateTime.now()
                                     })
                           }),
                           showAlertDialog(context,'You have successfully recharged! ')
                         },
                       });
                     },
                     child: Text('RECHARGE NOW')) ,
               )
              ],
            );
          },
        ),
    );
  }

  showAlertDialog(BuildContext context,String msg) {

    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
     // title: Text("My title"),
      content: Text(msg),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
