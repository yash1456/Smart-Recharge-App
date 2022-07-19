import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_fb_auth_emailpass/pages/add_card.dart';
import 'package:flutter_initicon/flutter_initicon.dart';

class AddMoney extends StatefulWidget {
  AddMoney({Key? key}) : super(key: key);

  @override
  _AddMoneyState createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  final _formKey = GlobalKey<FormState>();
  final moneyController = TextEditingController();

  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Money'),
        centerTitle: true,
      ),
      body:FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
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
              snapshot.data!['cardNumber']==''?
              Container(
                margin: EdgeInsets.only(left: 10,right: 10,top: 50),
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddCard()
                        ),
                      );
                    },
                    child: Text('Add Card')) ,
              ):Column(
                children: [
                  CreditCardWidget(
                    height: 180,
                    cardNumber: snapshot.data!['cardNumber'],
                    expiryDate: snapshot.data!['expiryDate'],
                    cardHolderName: snapshot.data!['cardHolderName'],
                    cvvCode: snapshot.data!['cvvCode'],
                    showBackView: isCvvFocused,
                    obscureCardNumber: true,
                    obscureCardCvv: true,
                    isHolderNameVisible: true,
                    cardBgColor: Colors.amber,
                    isSwipeGestureEnabled: true,
                    onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
                  ),
                  SizedBox(height: 20,),
                  Container(
                    margin: EdgeInsets.only(left: 8,right: 8),
                    child:TextFormField(
                      autofocus: false,
                      decoration: InputDecoration(
                        labelText: 'Enter an amount to add: ',
                        labelStyle: TextStyle(fontSize: 20.0),
                        border: OutlineInputBorder(),
                        errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                      ),
                      controller: moneyController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter an amount';
                        }
                        return null;
                      },
                    ) ,
                  ),
                  SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, otherwise false.
                      /*if (_formKey.currentState!.validate()) {

                      }*/
                      int b=int.parse(snapshot.data!['balance']);
                      int total=b+int.parse(moneyController.text.trim());
                      FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(
                          {
                            'balance':total.toString()
                          });
                      showAlertDialog(context, moneyController.text.trim()+' Successfully added to your account');
                      moneyController.clear();
                    },
                    child: Text(
                      'Add',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                ],
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
