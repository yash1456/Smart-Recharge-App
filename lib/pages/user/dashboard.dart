import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fb_auth_emailpass/pages/add_money.dart';
import 'package:flutter_fb_auth_emailpass/pages/detailpage.dart';
import 'package:flutter_fb_auth_emailpass/pages/mobile_recharge.dart';
import 'package:flutter_initicon/flutter_initicon.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddMoney()
                          ),
                        );
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
      ),
    );
  }
}
