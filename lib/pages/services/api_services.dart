import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class ApiServices {
  ApiServices._();
  static String baseUri = "http://localhost:1000/auth";

  static Future<dynamic> uploadImage(Uint8List bytes, String filename) async {
    final Uri url = Uri.parse("https://api.escuelajs.co/api/v1/files/upload");
    var request = http.MultipartRequest("POST", url);
    var myFile = http.MultipartFile(
      "file",
      http.ByteStream.fromBytes(bytes),
      bytes.length,
      filename: filename,
    );
    request.files.add(myFile);

    var res = await request.send();
    if (res.statusCode == 201) {
      var data = await res.stream.bytesToString();
      return jsonDecode(data);
    } else {
      return null;
    }
  }

  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final res = await http.post(
        Uri.parse("$baseUri/register"),
        headers: {"content-type": "application/json"},
        body: jsonEncode({"name": name, "email": email, "password": password}),
      );
      if (res.statusCode == 201 &&
          res.body.contains("User register successfully")) {
        final data = jsonDecode(res.body);
        return {
          "message": "Success",
          "statuCode": res.statusCode,
          "data": data,
        };
      }
      return {"message": "Faild to register", "statusCode": res.statusCode};
    } catch (e) {
      return {"message": "Somthing went wrong try again"};
    }
  }

  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final res = await http.post(
        Uri.parse("$baseUri/login"),
        headers: {"content-type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );
      if (res.statusCode == 200) {
        return {
          "message": "Success",
          "statusCode": res.statusCode,
          "data": res.body,
        };
      } else {
        return {"message": "user not found"};
      }
    } catch (e) {
      return {"message": "Somthing went wrong 1"};
    }
  }

  static Future<Map<String, dynamic>> dashboard({required String token}) async {
    try {
      final res = await http.get(
        Uri.parse("$baseUri/dashboard"),
        headers: {"Authorization": "Beaer $token"},
      );
      if (res.statusCode == 200) {
        return {"statusCode": res.statusCode, "data": res.body};
      } else {
        return {
          "message": "Somthing went wrong2222",
          "status": jsonDecode(res.body),
          "statusCode": res.statusCode,
        };
      }
    } catch (e) {
      return {"message": "Somthing went wrong"};
    }
  }
}

// {"message":"User register successfully","user":{"name":"ja","email":"a@a2.com","password":"$2b$10$zpw5QIo4Ym2NsW2OxyML4OJv7d7pE.pD5/UkBVCqPk2MfUwLwfGW6","role":"user","_id":"67d148a98f37046bc0c78a22","__v":0}}
