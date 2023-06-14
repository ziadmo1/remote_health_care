import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:remote_healthcare/screens/homeScreen_user/models/HomeUserRes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/loginScreen_admin/models/AuthAdminRes.dart';
import '../screens/loginScreen_user/models/AuthUserRes.dart';
import '../screens/notificationScreenAdmin/models/notifyAdminRes.dart';
import '../screens/searchScreen/models/SearchRes.dart';

class ApiManager{
  static Future<AuthUserRes> createAccountUser(String deviceId,String pass,String name,String phone, String gender,String age)async{
    var url = Uri.https('remote-healthcare-server.vercel.app', '/v2/users/patients/signup');
    var response = await http.post(url,body: {
      "username": name,
      "deviceId": deviceId,
      "password": pass,
      "gender": gender,
      "phoneNumber": phone,
      "age": age,
    });
    var json = jsonDecode(response.body);
    return AuthUserRes.fromJson(json);
  }
  static Future<AuthAdminRes> createAccountAdmin(String email,String pass,String name,String phone,String role, String gender,String age)async{
    var url = Uri.https('remote-healthcare-server.vercel.app', '/v2/users/admins/signup');
    var response = await http.post(url,body: {
      "username": name,
      "email": email,
      "password": pass,
      "role": role,
      "gender": gender,
      "phoneNumber": phone,
      "age": age,
    });
    var json = jsonDecode(response.body);
    return AuthAdminRes.fromJson(json);
  }
  static Future<AuthAdminRes> loginAccountAdmin(String email,String pass)async{
    var url = Uri.https('remote-healthcare-server.vercel.app', '/v2/users/admins/signin');
    var response = await http.post(url,body: {
      "email": email,
      "password": pass,
    });
    var json = jsonDecode(response.body);
    return AuthAdminRes.fromJson(json);
  }
  static Future<AuthUserRes> loginAccountUser(String deviceId,String pass)async{
    var url = Uri.https('remote-healthcare-server.vercel.app', '/v2/users/patients/signin');
    var response = await http.post(url,body: {
      "deviceId": deviceId,
      "password": pass,
    });
    var json = jsonDecode(response.body);
    return AuthUserRes.fromJson(json);
  }
  static Future<SearchRes> patientsSearch(String query,String email)async{
    var url = Uri.https('remote-healthcare-server.vercel.app', '/v2/users/patients',{
      'deviceId' : query,
      'adminEmail' : email
    });
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    return SearchRes.fromJson(json);
  }
  static Future<NotifyAdminRes> notifyAdmin(String id,)async{
    var url = Uri.https('remote-healthcare-server.vercel.app', '/v2/users/admins',{
      'id':id
    });
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    return NotifyAdminRes.fromJson(json);
  }
  static Future<AuthAdminRes> dataAdmin(String id,)async{
    var url = Uri.https('remote-healthcare-server.vercel.app', '/v2/users/admins/patients',{
      'id':id
    });
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    return AuthAdminRes.fromJson(json);
  }
  static Future<HomeUserRes> homeDataUser()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var url = Uri.https('remote-healthcare-server.vercel.app', '/v2/users/patients/signin',{
      'patientId' : prefs.getString('userId')??'',
    });
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    return HomeUserRes.fromJson(json);
  }

  static Future<AuthUserRes> sendReqAdmin(String deviceId,String email)async{
    var url = Uri.https('remote-healthcare-server.vercel.app', '/v2/users/admins/request_patient');
    var response = await http.put(url,body: {
      'deviceId' : deviceId,
      'adminEmail' : email,
    });
    var json = jsonDecode(response.body);
    return AuthUserRes.fromJson(json);
  }
  static Future<HomeUserRes> cancelReqPatient(String deviceId,String adminEmail)async{
    var url = Uri.https('remote-healthcare-server.vercel.app', '/v2/users/admins/request_patient/cancel');
    var response = await http.put(url,body: {
      'deviceId' : deviceId,
      'adminEmail' : adminEmail,
    });
    var json = jsonDecode(response.body);
    return HomeUserRes.fromJson(json);
  }
  static Future<HomeUserRes> deleteUser({required String deviceId,required String adminEmail})async{
    var url = Uri.https('remote-healthcare-server.vercel.app', '/v2/users/admins/cancel_patient');
    var response = await http.put(url,body: {
      'deviceId' : deviceId,
      'adminEmail' : adminEmail,
    });
    var json = jsonDecode(response.body);
    return HomeUserRes.fromJson(json);
  }
  static Future<HomeUserRes> deleteAdmin({ required String phone,required String adminEmail})async{
    var url = Uri.https('remote-healthcare-server.vercel.app', '/v2/users/admins/cancel_patient');
    var response = await http.put(url,body: {
      'adminEmail' : adminEmail,
      'phoneNumber' : phone,
    });
    var json = jsonDecode(response.body);
    return HomeUserRes.fromJson(json);
  }
  static Future<HomeUserRes> acceptReqPatient(String deviceId,String adminEmail)async{
    var url = Uri.https('remote-healthcare-server.vercel.app', '/v2/users/admins/request_patient/accept');
    var response = await http.put(url,body: {
      'deviceId' : deviceId,
      'adminEmail' : adminEmail,
    });
    var json = jsonDecode(response.body);
    return HomeUserRes.fromJson(json);
  }

}

