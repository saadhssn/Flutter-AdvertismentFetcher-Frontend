import 'dart:convert';
import 'package:advertisment_fetcher/static/utils/app_constant.dart';
import 'package:http/http.dart' as http;
class LoginService {


  Future<String> loginUser(String email, String password) async {
    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse(AppConstant.apiBaseURL+'/api/users/register/owner'));
    request.bodyFields = {
      'email': email,
      'password': password
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseString = await response.stream.bytesToString();
      Map<String, dynamic> responseData = jsonDecode(responseString);
      String accessToken = responseData['accessToken'];
      print('AccessToken: $accessToken');
      return accessToken;
    } else {
      print(response.reasonPhrase);
      String errorString = await response.stream.bytesToString();
      return errorString; // or you can handle the error scenario as needed.
    }

  }

  Future<Map<String, dynamic>?> getUserInfo(String accessToken) async {
    var headers = {
      'Authorization': 'Bearer $accessToken',
    };

    var request = http.Request('GET', Uri.parse(AppConstant.apiBaseURL + '/api/users/register/owner'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseString = await response.stream.bytesToString();
      Map<String, dynamic> responseData = jsonDecode(responseString);
      return responseData;
    } else {
      print('Failed to get user info: ${response.reasonPhrase}');
      return null;
    }
  }
}