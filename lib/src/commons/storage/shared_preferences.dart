
import 'package:expense_manager/src/commons/constants/storage_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefManager {

  _saveToDisk(String key, dynamic value) async {
    final SharedPreferences _preferences = await SharedPreferences.getInstance();
    if (value is bool) {
      _preferences.setBool(key, value);
    } else if (value is String) {
      _preferences.setString(key, value);
    } else if (value is int) {
      _preferences.setInt(key, value);
    } else if (value is double) {
      _preferences.setDouble(key, value);
    } else if (value is List<String>) {
      _preferences.setStringList(key, value);
    }
  }

  dynamic _getFromDisk(String key) async {
    final SharedPreferences _preferences = await SharedPreferences.getInstance();
    var value = _preferences.get(key);
    return value;
  }

  get accessTokenDetails => _getFromDisk(StorageConstants.ACCESS_TOKEN_DETAILS) ;
  set accessTokenDetails(String value) => _saveToDisk(StorageConstants.ACCESS_TOKEN_DETAILS, value);

  get refreshTokenDetails => _getFromDisk(StorageConstants.REFRESH_TOKEN_DETAILS) ;
  set refreshTokenDetails(String value) => _saveToDisk(StorageConstants.REFRESH_TOKEN_DETAILS, value);

  get userData => _getFromDisk(StorageConstants.USER_DATA);
  set userData(String value) => _saveToDisk(StorageConstants.USER_DATA, value);

  get userDashboardData => _getFromDisk(StorageConstants.USER_DASHBOARD_DATA) ;
  set userDashboardData(String value) => _saveToDisk(StorageConstants.USER_DASHBOARD_DATA, value);

  get orders => _getFromDisk(StorageConstants.ORDERS);
  set orders(String value) => _saveToDisk(StorageConstants.ORDERS, value);

  get isLoggedIn => _getFromDisk(StorageConstants.IS_LOGGED_IN);
  set isLoggedIn(bool value) => _saveToDisk(StorageConstants.IS_LOGGED_IN, value);

}
