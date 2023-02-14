/// message : "doctor signin successed"
/// isSuccess : true
/// data : {"doctor":{"_id":"63959f26c2020086da74a25c","username":"hassan","gender":"male","phoneNumber":"13","age":50,"email":"hassann@gmail.com","patients":[{"username":"ziad","gender":"male","phoneNumber":"0155646456","age":54}]}}

class AuthAdminRes {
  AuthAdminRes({
      this.message, 
      this.isSuccess, 
      this.data,});

  AuthAdminRes.fromJson(dynamic json) {
    message = json['message'];
    isSuccess = json['isSuccess'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? message;
  bool? isSuccess;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    map['isSuccess'] = isSuccess;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// doctor : {"_id":"63959f26c2020086da74a25c","username":"hassan","gender":"male","phoneNumber":"13","age":50,"email":"hassann@gmail.com","patients":[{"username":"ziad","gender":"male","phoneNumber":"0155646456","age":54}]}

class Data {
  Data({
      this.doctor,});

  Data.fromJson(dynamic json) {
    doctor = json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
  }
  Doctor? doctor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (doctor != null) {
      map['doctor'] = doctor?.toJson();
    }
    return map;
  }

}

/// _id : "63959f26c2020086da74a25c"
/// username : "hassan"
/// gender : "male"
/// phoneNumber : "13"
/// age : 50
/// email : "hassann@gmail.com"
/// patients : [{"username":"ziad","gender":"male","phoneNumber":"0155646456","age":54}]

class Doctor {
  Doctor({
      this.id, 
      this.username, 
      this.gender, 
      this.phoneNumber, 
      this.age, 
      this.email, 
      this.patients,});

  Doctor.fromJson(dynamic json) {
    id = json['_id'];
    username = json['username'];
    gender = json['gender'];
    phoneNumber = json['phoneNumber'];
    age = json['age'];
    email = json['email'];
    if (json['patients'] != null) {
      patients = [];
      json['patients'].forEach((v) {
        patients?.add(Patients.fromJson(v));
      });
    }
  }
  String? id;
  String? username;
  String? gender;
  String? phoneNumber;
  num? age;
  String? email;
  List<Patients>? patients;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['username'] = username;
    map['gender'] = gender;
    map['phoneNumber'] = phoneNumber;
    map['age'] = age;
    map['email'] = email;
    if (patients != null) {
      map['patients'] = patients?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// username : "ziad"
/// gender : "male"
/// phoneNumber : "0155646456"
/// age : 54

class Patients {
  Patients({
      this.username, 
      this.gender, 
      this.phoneNumber, 
      this.age,});

  Patients.fromJson(dynamic json) {
    username = json['username'];
    gender = json['gender'];
    phoneNumber = json['phoneNumber'];
    age = json['age'];
  }
  String? username;
  String? gender;
  String? phoneNumber;
  num? age;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['gender'] = gender;
    map['phoneNumber'] = phoneNumber;
    map['age'] = age;
    return map;
  }

}