import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vk_login/model/vk_scope.dart';
import 'package:vk_login/model/vk_user.dart';
import 'package:vk_login/pages/login_page.dart';
import 'package:vk_login/services/vk_api_service.dart';
import 'package:vk_login/utils/global_vars.dart';

class VkProvider with ChangeNotifier {
  late VkApi _vkApi;
  late final SharedPreferences _prefs;
  late final int _appId;
  String? _token;
  VkUser? _profile;
  bool _isInit = false;

  String? get token => _token;
  VkUser? get profile => _profile;
  int get appId => _appId;
  bool get isInit => _isInit;

  /// first you must call the init() method
  /// the token will be searched in local storage
  /// the [appID] parameter is the identifier of your application. You can find it here https://vk.com/apps?act=manage
  /// [appId] by default - VK Me app ID
  Future<void> init({appId = 6146827}) async {
    _appId = appId;
    _prefs = await SharedPreferences.getInstance();
    _token = _prefs.getString('token');
    _isInit = true;
    await _setToken(_token);
  }

  /// permissions - token permission list
  /// it is recommended to always use VKScope.offline
  Future<void> login(BuildContext context, {required List<VKScope> permissions}) async {
    if (_isInit == false) throw "You should call unit() before";

    if (_token != null && _profile != null) return;

    /// after closing this page, the value of the token will be written in the [GlobalVars.token]
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage(
                  appId: _appId,
                  permissions: permissions,
                )));
    await _setToken(GlobalVars.token);
  }

  Future<void> _setToken(String? token) async {
    if (_isInit == false) throw "You should call unit() before";

    _token = token;
    if (_token != null) {
      _prefs.setString('token', _token!);
      _vkApi = VkApi(token: _token!);
      await updateData();
    }
  }

  Future<void> logout() async {
    _token = null;
    _profile = null;
    GlobalVars.token = null;
    _prefs.clear();
    notifyListeners();
  }

  /// updates data to actual
  Future<void> updateData() async {
    if (_isInit == false) throw "You should call unit() before";

    if (_token == null) throw "You should call login() before";

    var user = await _vkApi.method('account.getProfileInfo');

    if (user == null) {
      _profile = null;
      _token = null;
      return notifyListeners();
    }

    var photosInfo = await _vkApi.method('users.get',
        params: {'fields': 'photo_50,photo_100,photo_200,photo_max_orig', 'user_ids': '${user['id']}'});
    _profile = VkUser.fromJSON(user, photosInfo[0]);
    notifyListeners();
  }
}
