import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/danaq/AndroidStudioProjects/food_app/lib/Dependencies/app_constants.dart';
import 'file:///C:/Users/danaq/AndroidStudioProjects/food_app/lib/CheckoutScreen/checkout_screen_ui.dart';
import 'bloc.dart';

void main() {
  runApp(MyFoodApp());
}

class MyFoodApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final checkoutBtnState = CheckoutBtnState();
    return MaterialApp(
      title: AppConstants.instance.appName,
      theme: ThemeData(
          primarySwatch: AppConstants.instance.appThemeColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,),

    home: Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text("${AppConstants.instance.appName}")),
      ),
      bottomNavigationBar: StreamBuilder(
        stream:  checkoutBtnState.checkoutBtnStream,
        builder: (context, snapshot){
          bool state = true;
          if (!snapshot.hasData){
                state = true;
          }else{
            state = snapshot.data.checkoutBtnState;
          }

          return Opacity(
            opacity: state ? 0 : 1,
            child: BottomAppBar(
              child: FlatButton(key: Key("CheckoutBtn"),
                onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CheckoutScreen(selectedDataList: snapshot.data.selectedItemList)),
                );
              },
                color: Colors.grey[300],
                child: Text(" Checkout ",
                  style: TextStyle(color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 25,),
                ),
            ),
            ),
          );
        },
      ),
      body: AppBody(checkoutBtnState: checkoutBtnState),
      ),
    );
  }

}

class AppBody extends StatelessWidget{
  final checkoutBtnState;
  AppBody({this.checkoutBtnState});
  @override
  Widget build(BuildContext context) {
    final apiHit = Setdata();
   apiHit.getDataFrom();

    return StreamBuilder(
      stream: apiHit.foodDataStream,
      builder: (context, snapshot){
        if (snapshot.hasError){
          return Container(child: Text(snapshot.error),);
        }else if(snapshot.hasData){
          final foodItemData = FoodItemData();
          final foodItemDataList = foodItemData.getFoodData(dataModal: snapshot.data);
          return ListView.builder(padding: EdgeInsets.fromLTRB(10, 12, 12, 10),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index){
                return  FoodItemCell(indexForItem : index , foodItemDataList: foodItemDataList, checkoutBtnState: checkoutBtnState,);
              });
        }
        return Container();
      },

    );
  }

}
class FoodItemCell extends StatelessWidget{
  final indexForItem;
  final foodItemDataList;
  final checkoutBtnState;
  FoodItemCell({this.indexForItem,this.foodItemDataList, this.checkoutBtnState});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: foodItemDataList[indexForItem].counterStream,
      builder: (context, snapshot){
          return  Container(
            color: Colors.grey[300],
            child: Column(children: [
              Image.asset(foodItemDataList[indexForItem].foodItemData.foodImage,
                height: 300,
                width: 300,) ,
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children : [
                  Container(
                    width: 100,
                    child: Text(foodItemDataList[indexForItem].foodItemData.foodName,
                        style: TextStyle(fontWeight: FontWeight.w400,
                          fontSize: 20,)
                    ),
                  ),
                  SizedBox(width: 30,),
                  Container(
                    child: Row(mainAxisAlignment : MainAxisAlignment.spaceEvenly,
                      children: [
                        FlatButton(onPressed: (){
                          foodItemDataList[indexForItem].setCounter(state : CounterState.Decrement, checkoutBtnState:  checkoutBtnState, foodItemDataList: foodItemDataList);
                        },
                            child: Text("-",
                                style: TextStyle(fontWeight: FontWeight.bold,
                                  fontSize: 40,)
                            )
                        ),
                        Text("${foodItemDataList[indexForItem].count}",
                            style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 20,)
                        ),
                        FlatButton(onPressed: (){
                          foodItemDataList[indexForItem].setCounter(state : CounterState.Increament, checkoutBtnState: checkoutBtnState, foodItemDataList: foodItemDataList);

                        }, child: Text("+",
                            key: Key("PlusBtn"),
                            style: TextStyle(fontWeight: FontWeight.bold,
                              fontSize: 35,)
                        )
                        ),
                      ], ),
                  )
                ],)
            ],),
          );


        return Container();
      },

    );
  }
}

