import 'file:///C:/Users/danaq/AndroidStudioProjects/food_app/lib/Dependencies/app_constants.dart';
import 'file:///C:/Users/danaq/AndroidStudioProjects/food_app/lib/HomeSreen/data_modal.dart';

class ApiHit{

  List<String> foodNames = ["Butter Chicken", "Instant Pot Butter Chicken", "Tandoori Chicken", "Chicken Tikka Masala", "Chicken Vindaloo Curry", "Rogan Josh (Red Lamb)", "Malai Kofta",
  "Chole (Chickpea Curry)", "Palak Paneer (Spinach and Cottage Cheese)", "Kaali Daal (Black Lentils)"];
  List<DataModal> data = [];
  Future<List> getData(){

    for(int i=1 ; i<= AppConstants.instance.foodItemsCount; i++){
      int j = i-1;
      data.add(DataModal(foodImage: "assets/image_$i.jpg", foodName: foodNames[j]));
    }
    return Future.value(data);
  }
}