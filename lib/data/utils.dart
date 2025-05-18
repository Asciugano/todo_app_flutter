import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_flutter/data/constraints.dart';

class Utils {
  static Future<int> getCurrentID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(KKeys.listTodoCurrentId) ?? 1;
  }
  
  static Future setCurrentID(int id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(KKeys.listTodoCurrentId, id);
  }
}