
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'file:///C:/Users/danaq/AndroidStudioProjects/food_app/lib/CheckoutScreen/checkout_screen_ui.dart';
import 'file:///C:/Users/danaq/AndroidStudioProjects/food_app/lib/HomeSreen/home_page_ui.dart';

void main(){

  testWidgets("Testing  initial state of ItemCount", ( WidgetTester tester) async{
    // Widgets
     final checkoutBtn = find.byKey(ValueKey("CheckoutBtn"));
     final proceedToPayment = find.byKey(ValueKey("ProceedToPayment"));


    //executing the actual step
    await tester.pumpWidget(MyFoodApp());
   // await tester.tap(checkoutBtn);
    await tester.pump();


    //check outputs
    expect(find.text("0"), findsWidgets);
  });


  testWidgets("Testing  initial state of checkout Btn", ( WidgetTester tester) async{
    // Widgets
    final checkoutBtn = find.byKey(ValueKey("CheckoutBtn"));


    //executing the actual step
    await tester.pumpWidget(MyFoodApp());



    //check outputs
    expect(checkoutBtn, findsOneWidget);
  });
  testWidgets("Testing  initial state of proceedToPayment Btn", ( WidgetTester tester) async{
    // Widgets

    final proceedToPayment = find.byKey(ValueKey("ProceedToPayment"));


    //executing the actual step
    await tester.pumpWidget(CheckoutScreen(selectedDataList: [],));

    //check outputs
    expect(proceedToPayment, findsOneWidget);
  });


  // testWidgets("Testing  initial state of checkout Btn", ( WidgetTester tester) async{
  //   // Widgets
  //   final checkoutBtn = find.byKey(ValueKey("CheckoutBtn"));
  //   final proceedToPayment = find.byKey(ValueKey("ProceedToPayment"));
  //
  //
  //   //executing the actual step
  //   await tester.pumpWidget(CheckoutScreen(selectedBlocItems: [], selectedDataList: [],));
  //   await tester.tap(proceedToPayment);
  //
  //
  //
  //
  //   //check outputs
  //   expect(find.byKey(ValueKey("AlertBox")), findsOneWidget);
  // });
}