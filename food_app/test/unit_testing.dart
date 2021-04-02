import 'package:flutter_test/flutter_test.dart';
import 'file:///C:/Users/danaq/AndroidStudioProjects/food_app/lib/HomeSreen/data_modal.dart';
import 'file:///C:/Users/danaq/AndroidStudioProjects/food_app/lib/HomeSreen/api.dart';
import 'file:///C:/Users/danaq/AndroidStudioProjects/food_app/lib/HomeSreen/bloc.dart';
import 'package:mockito/mockito.dart';

class MockExample extends Mock implements ApiHit{
  @override
  List<DataModal> data;

  // @override
  // Future<List> getData() {
  //   List data = ["sucessful"];
  //   return Future.value(data);
  // }

}

void main(){

  test('Test the Mock Api', () async {
    ApiHit mockitoExample = MockExample();
    when(mockitoExample.getData())
        .thenAnswer((value) async {
      return Future.value(["sucessful"]);
    });

    mockitoExample.getData().then((value) => expect( value, ["sucessful"]));

  });
  test('Test the counter initial State', () async {

    final homePageBloc = HomePageBloc();
    homePageBloc.setInitialState();
    expect( homePageBloc.count, 0);
  });
  test('Test the counter Stream', () async {

    final homePageBloc = HomePageBloc();
    homePageBloc.setCounter(state: CounterState.Increament, checkoutBtnState: CheckoutBtnState(), foodItemDataList: []);
    expect( homePageBloc.count, 1);
  });
  test('Test the CheckoutBtn Stream', () async {

    final checkoutBtnState = CheckoutBtnState();
    checkoutBtnState.checkoutBtnSink.add(true);
    checkoutBtnState.checkoutBtnStream.listen((event) {
      expect( event, true);
    });

  });

}