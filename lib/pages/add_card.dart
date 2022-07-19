import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class AddCard extends StatefulWidget {
  AddCard({Key? key}) : super(key: key);

  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {

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
        title: Text('Add Card'),
        centerTitle: true,
      ),
        body:Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 30,),
                  CreditCardWidget(
                    //  glassmorphismConfig: useGlassMorphism ? Glassmorphism.defaultConfig() : null,
                    height: 180,
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardHolderName: cardHolderName,
                    cvvCode: cvvCode,
                    showBackView: isCvvFocused,
                    obscureCardNumber: true,
                    obscureCardCvv: true,
                    isHolderNameVisible: true,
                    cardBgColor: Colors.amber,
                  /*  backgroundImage:
                    useBackgroundImage ? 'assets/card_bg.png' : null,*/
                    isSwipeGestureEnabled: true,
                    onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
                   /* customCardTypeIcons: <CustomCardTypeIcon>[
                      CustomCardTypeIcon(
                        cardType: CardType.mastercard,
                        cardImage: Image.asset('assets/mastercard.png',
                          height: 48,
                          width: 48,
                        ),
                      ),
                    ],*/
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          CreditCardForm(
                            formKey: formKey,
                            obscureCvv: true,
                            obscureNumber: true,
                            cardNumber: cardNumber,
                            cvvCode: cvvCode,
                            isHolderNameVisible: true,
                            isCardNumberVisible: true,
                            isExpiryDateVisible: true,
                            cardHolderName: cardHolderName,
                            expiryDate: expiryDate,
                            themeColor: Colors.amber,
                            textColor: Colors.black87,
                            cardNumberDecoration: InputDecoration(
                              labelText: 'Number',
                              hintText: 'XXXX XXXX XXXX XXXX',
                              hintStyle: const TextStyle(color: Colors.black54),
                              labelStyle: const TextStyle(color: Colors.black54),
                              focusedBorder: border,
                              enabledBorder: border,
                            ),
                            expiryDateDecoration: InputDecoration(
                              hintStyle: const TextStyle(color: Colors.black54),
                              labelStyle: const TextStyle(color: Colors.black54),
                              focusedBorder: border,
                              enabledBorder: border,
                              labelText: 'Expired Date',
                              hintText: 'XX/XX',
                            ),
                            cvvCodeDecoration: InputDecoration(
                              hintStyle: const TextStyle(color: Colors.black54),
                              labelStyle: const TextStyle(color: Colors.black54),
                              focusedBorder: border,
                              enabledBorder: border,
                              labelText: 'CVV',
                              hintText: 'XXX',
                            ),
                            cardHolderDecoration: InputDecoration(
                              hintStyle: const TextStyle(color: Colors.black54),
                              labelStyle: const TextStyle(color: Colors.black54),
                              focusedBorder: border,
                              enabledBorder: border,
                              labelText: 'Card Holder',
                            ),
                            onCreditCardModelChange: onCreditCardModelChange,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          /*Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              'Glassmorphism',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            Switch(
                              value: useGlassMorphism,
                              inactiveTrackColor: Colors.grey,
                              activeColor: Colors.white,
                              activeTrackColor: Colors.green,
                              onChanged: (bool value) => setState(() {
                                useGlassMorphism = value;
                              }),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              'Card Image',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            Switch(
                              value: useBackgroundImage,
                              inactiveTrackColor: Colors.grey,
                              activeColor: Colors.white,
                              activeTrackColor: Colors.green,
                              onChanged: (bool value) => setState(() {
                                useBackgroundImage = value;
                              }),
                            ),
                          ],
                        ),*/
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            primary: Colors.amber,
                          ),
                           child: Container(
                            margin: const EdgeInsets.all(12),
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'halter',
                                fontSize: 14,
                                package: 'flutter_credit_card',
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              print('valid!');
                              FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(
                                  {
                                    'cardNumber':cardNumber,
                                    'cardHolderName':cardHolderName,
                                    'cvvCode':cvvCode,
                                    'expiryDate':expiryDate
                                  });
                              Navigator.pop(context);
                            } else {
                              print('invalid!');
                            }
                          },
                        ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )

      /*  FutureBuilder<DocumentSnapshot>(
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
              Container(
                  padding: EdgeInsets.only(top: 20,left: 20,bottom: 20),
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20))
                      ,color: Colors.amber),
                  child:Column(
                    children: [
                      Row(
                        children: [
                          Initicon(
                            text: snapshot.data!['name'],
                            elevation: 4,
                            size: 60,
                            backgroundColor: Colors.blue.shade400,
                          ),
                          SizedBox(width: 20,),
                          Expanded(
                            child:Text(snapshot.data!['name'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)
                            ,flex: 2,),
                          Expanded(child: Text(' \u{20B9} '+snapshot.data!['balance'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20)),flex: 1,)


                        ],
                      ),
                      InkWell(
                        onTap: (){

                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 35,
                          margin: EdgeInsets.fromLTRB(40, 20, 40, 10),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: Colors.blue.shade400),
                          child:Center(child:Text('Add Money',style: TextStyle(color: Colors.white),),),
                        ),
                      )
                    ],
                  )
              ),
              SizedBox(height: 40,),
              Container(
                  margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                  padding: EdgeInsets.only(top: 12,bottom: 8,left: 8,right: 8),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),border: Border.all(color: Colors.grey,width: 1)),
                  child:Column(children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MobileRecharge()
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    // shape: BoxShape.circle,
                                      color: Colors.grey.shade400,
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Icon(Icons.mobile_screen_share_outlined, color: Colors.white,),
                                  alignment: Alignment.center,
                                ),
                              ),
                              SizedBox(height: 6,),
                              Text('Mobile Recharge')
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  // shape: BoxShape.circle,
                                    color: Colors.grey.shade400,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child:ImageIcon(
                                  AssetImage("electricity_bill.png"),
                                  color: Colors.white,
                                ),
                                alignment: Alignment.center,
                              ),
                              SizedBox(height: 6,),
                              Text('Electric Bill')
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  // shape: BoxShape.circle,
                                    color: Colors.grey.shade400,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: ImageIcon(
                                  AssetImage("gas_bill.png"),
                                  color: Colors.white,
                                ),
                                alignment: Alignment.center,
                              ),
                              SizedBox(height: 6,),
                              Text('Gas Bill')
                            ],
                          ),
                        ]),
                    SizedBox(height: 10,),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  // shape: BoxShape.circle,
                                    color: Colors.grey.shade400,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: ImageIcon(
                                  AssetImage("other_payments.png"),
                                  color: Colors.white,
                                ),
                                alignment: Alignment.center,
                              ),
                              SizedBox(height: 6,),
                              Text('Other Payments')
                            ],
                          ),
                        ])
                  ],)
              )
            ],
          );
        },
      ),*/
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
