
import 'dart:async';
import 'file:///C:/Users/danaq/AndroidStudioProjects/food_app/lib/HomeSreen/data_modal.dart';
import 'api.dart';

enum CounterState{Decrement, Increament}

class Setdata{
  StreamController foodDataStreamController = StreamController();
  Stream get foodDataStream => foodDataStreamController.stream;
  StreamSink get foodDataSink => foodDataStreamController.sink;

  void getDataFrom(){
    final apiHit = ApiHit();
    apiHit.getData().then((value) => foodDataSink.add(value));

  }

}

class HomePageBloc{

   int count;
   bool isItemSelected;
   DataModal foodItemData;

   HomePageBloc({this.count = 0, this.isItemSelected = false, this.foodItemData});

   StreamController counterStreamController = StreamController.broadcast();
   Stream get counterStream => counterStreamController.stream;
   StreamSink get counterSink => counterStreamController.sink;

   void setInitialState(){
       counterSink.add(count);
   }

   void setCounter({CounterState state, CheckoutBtnState checkoutBtnState, List foodItemDataList}){
     if (state == CounterState.Decrement){
        if (count != 0){
          isItemSelected = true;
          count--;
          if(count ==0){
            isItemSelected = false;
          }
          counterSink.add(count);
        }else if (count == 0){
          isItemSelected = false;
        }
     }else if(state == CounterState.Increament){
       isItemSelected = true;
       count++;
       counterSink.add(count);
     }

     checkoutBtnState.checkoutBtnSink.add(SelectedItemsDataToPass(checkoutBtnState: checkIsCheckoutBtnHidden(data: foodItemDataList), selectedItemList: findSelectedItems(data: foodItemDataList)));
   }
   bool checkIsCheckoutBtnHidden({List data}){
     for(int i =0; i<data.length; i++){
       if (data[i].count != 0){
         return false;
       }
     }
     return true;
   }

   List findSelectedItems({List data}){
     List selectedItems = [];
     for (int i = 0; i< data.length; i++){
       if(data[i].isItemSelected){
         selectedItems.add(data[i]);
       }
     }
     return selectedItems;
   }
}

class FoodItemData{
  List foodItemsData = [];
  List getFoodData({List dataModal}){

    for(int i=0; i<dataModal.length; i++){
      final homePageBloc = HomePageBloc(foodItemData: dataModal[i]);
      homePageBloc.setInitialState();
      foodItemsData.add(homePageBloc);
    }
    return foodItemsData;

  }
}
class CheckoutBtnState{

  StreamController checkoutBtnStreamController = StreamController.broadcast();
  Stream get checkoutBtnStream => checkoutBtnStreamController.stream;
  StreamSink get checkoutBtnSink => checkoutBtnStreamController.sink;

    void setState(bool state){
      checkoutBtnSink.add(state);
    }
}
class SelectedItemsDataToPass{
  List selectedItemList = [];
  bool checkoutBtnState = true;
  SelectedItemsDataToPass({this.checkoutBtnState, this.selectedItemList});
}