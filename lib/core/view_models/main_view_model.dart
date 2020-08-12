import 'package:todoList/core/view_models/base_view_model.dart';
import 'package:todoList/core/view_models/models/items.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainViewModel extends BaseViewModel {
  static MainViewModel _mainViewModel;

  static MainViewModel instance() {
    if (_mainViewModel == null) {
      _mainViewModel = MainViewModel();
    }
    return _mainViewModel;
  }

  List<Items> items = List();

  MainViewModel() {
    Future.delayed(Duration(seconds: 5), () => populate());
  }

  // functions

  void populate() {
    items = [
      Items(
        id: 0,
        name: 'Maça',
        value: 0,
      ),
      Items(
        id: 1,
        name: 'uva',
        value: 0,
      ),
      Items(
        id: 2,
        name: 'pera',
        value: 0,
      ),
    ];
    notifyListeners();
  }

  void readItemList() async {
    List<String> list = await getList();
    for (var item in list) {
      var aux = item.split("&");
      items.add(
        Items(
          id: int.parse(aux[0]),
          name: aux[1],
          value: double.parse(aux[2]),
        ),
      );
    }
  }

  void createStringList() async {
    List<String> list = List<String>();
    for (var item in items) {
      list.add("${item.id}&${item.name}&${item.value}");
    }

    print(list);
    await saveList(list);
  }

  Future<List<String>> saveList(List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setStringList('buyList', list) ?? List<String>();
  }

  Future<List<String>> getList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('buyList') ?? List<String>();
  }

  void changeValue(int index, double value) {
    items[index].value = value;
    notifyListeners();
  }
}
