import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fb_auth_emailpass/pages/detailpage.dart';

class MobileRecharge extends StatefulWidget {
  MobileRecharge({Key? key}) : super(key: key);

  @override
  _MobileRechargeState createState() => _MobileRechargeState();
}

class _MobileRechargeState extends State<MobileRecharge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mobile Recharge'),
        centerTitle: true,
      ),
        body:StreamBuilder(
          stream: FirebaseFirestore.instance.collection('packs').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            return streamSnapshot.connectionState==ConnectionState.waiting?
            Center(child: CircularProgressIndicator(),):
            Container(
              child:ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: (BuildContext context,int index){
                    return Container(
                        margin: EdgeInsets.fromLTRB(8, 8, 8, 8),
                        padding: EdgeInsets.only(top: 12,),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.grey.shade300),
                        child:
                        Column(
                          children: [
                            Row(
                              //  mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('\u{20B9} '+streamSnapshot.data!.docs[index]['charges'].toString(),style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                                        SizedBox(height: 10,),
                                        Text('unlimited calls',style: TextStyle(color: Colors.grey.shade700,)),
                                      ],
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        Text(streamSnapshot.data!.docs[index]['data'],style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                                        SizedBox(height: 8,),
                                        Text('per day',style: TextStyle(color: Colors.grey.shade700,)),
                                      ],
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        Text(streamSnapshot.data!.docs[index]['sms'].toString()+' SMS',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                                        SizedBox(height: 8,),
                                        Text('per day',style: TextStyle(color: Colors.grey.shade700,)),
                                      ],
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: Column(
                                      children: [
                                        Text(streamSnapshot.data!.docs[index]['validity'].toString()+' Days',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                                        SizedBox(height: 8,),
                                        Text('validity',style: TextStyle(color: Colors.grey.shade700,)),
                                      ],
                                    ))
                              ],
                            ),
                            SizedBox(height: 10,),
                            Divider(color: Colors.grey.shade600,),
                            Align(alignment: Alignment.centerRight,
                              child: TextButton(child: Text('View details'),
                                onPressed: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailPage(streamSnapshot.data!.docs[index].id)
                                    ),
                                  );
                                },),)
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
