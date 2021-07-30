import 'dart:convert';
import 'package:http/http.dart' as http;

class VkApi {
  late final String versionApi;
  late final String token;

  static const String _baseUrl = 'https://api.vk.com/method/';

  VkApi({required this.token, this.versionApi = '5.131'});

  Future method(String method, { Map<String, dynamic>? params }) async {

    if (params == null)
      params = {"v":"$versionApi"};
    params['access_token'] = token;
    params['v'] = versionApi;


    http.Response res = await http.post(Uri.parse('$_baseUrl$method'), body: params);
    var jsonRes = await jsonDecode(res.body);
    if (jsonRes['error'] != null)
      return null;
    return jsonRes['response'];
  }
}
