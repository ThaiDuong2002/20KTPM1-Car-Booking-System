import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceModule {
  static const String userInfoKey = 'userInfo';

  Future<void> saveUserInfo(Map<String, dynamic> userInfo) async {
    try {
      // Chuyển đổi map thành chuỗi JSON
      String jsonUserInfo = jsonEncode(userInfo);

      // Lưu chuỗi JSON vào SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(userInfoKey, jsonUserInfo);
    } catch (e) {
      // Xử lý lỗi (nếu có)
      print('Lỗi từ Sharepreference: $e');
    }
  }
  Future<Map<String, dynamic>> getUserInfo() async {
    try {
      // Truy xuất chuỗi JSON từ SharedPreferences
      print("check here");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? jsonUserInfo = prefs.getString(userInfoKey);
      print(jsonUserInfo);
      // Kiểm tra xem chuỗi JSON có tồn tại không
      if (jsonUserInfo != null) {
        // Chuyển đổi chuỗi JSON thành đối tượng Map
        Map<String, dynamic> userInfo = jsonDecode(jsonUserInfo);
        return userInfo;
      }
    } catch (e) {
      // Xử lý lỗi (nếu có)
      print('Lỗi Sharepreference : $e');
    }
    return {};
  }

  Future<void> clearUserInfo() async {
    try {
      // Xóa thông tin người dùng từ SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(userInfoKey);
    } catch (e) {
      // Xử lý lỗi (nếu có)
      print('Lỗi Sharepreference : $e');
    }
  }
}
