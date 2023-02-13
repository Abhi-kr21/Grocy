import 'package:flutter/cupertino.dart';
import 'package:store/constants/database.dart';
import 'package:store/enums/enums.dart';
import 'package:store/models/category_model.dart';

class CategoryController extends ChangeNotifier {
  /// Creating a list of Category objects.
  List<Category> categorylist = [];
  CategoryStatus categorystatus = CategoryStatus.NIL;

  /// It fetches data from firestore and stores it in a list
  setcategory() async {
    List<Category> tempCategory = [];
    categorystatus = CategoryStatus.LOADING;
    await Future.delayed(const Duration(microseconds: 1));
    notifyListeners();
    try {
      var categorySnapshot = await categoryDb.get();
      for (var category in categorySnapshot.docs) {
        Category c = Category.fromJson(category.data());
        tempCategory.add(c);
      }
    } catch (e) {
      print(e);
    }
    categorylist = tempCategory;
    categorystatus = CategoryStatus.DONE;
    notifyListeners();
  }
}
