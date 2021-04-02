import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Dependencies/app_constants.dart';

class CheckoutScreen extends StatelessWidget{
  final selectedDataList;
  CheckoutScreen({this.selectedDataList});
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: CheckoutScreen().toString(),
      theme: ThemeData(
        primarySwatch: AppConstants.instance.appThemeColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,),
      home: Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text(CheckoutScreen().toString())),
        ),
        bottomNavigationBar: BottomAppBar(
          child: FlatButton(key: Key("ProceedToPayment"),
            onPressed: (){
            return showDialog(
              context: context,
              barrierDismissible: false, // user must tap button!
              builder: (BuildContext context) {
                return AlertDialog(
                  key: Key("AlertBox"),
                  title: Text('AlertDialog Title'),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text('Payment Result'),
                        Text('You order has been placed'),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
            color: Colors.grey[300],
            child: Text("Proceed To Payment",
              style: TextStyle(color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 25,),
            ),
          ),
        ),
        body: ListView.builder(
          padding: EdgeInsets.fromLTRB(10, 12, 12, 10),
            itemCount: selectedDataList.length,
            itemBuilder: (BuildContext context, int index){
              return ListCell(index: index, selectedDataList: selectedDataList);
            }),
      ),
    );

  }

}

Widget ListCell({int index, List selectedDataList}){
  return  Container(
    color: Colors.grey[300],
    child: Column(children: [
      Image.asset("${selectedDataList[index].foodItemData.foodImage}",
        height: 300,
        width: 300,) ,
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children : [
          Text("${selectedDataList[index].foodItemData.foodName}",
              style: TextStyle(fontWeight: FontWeight.w400,
                fontSize: 20,)
          ),
          SizedBox(width: 30,),
          Container(
            child: Text("${selectedDataList[index].count}",
                style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 20,)
            ),
          )
        ],)
    ],),
  );
}



