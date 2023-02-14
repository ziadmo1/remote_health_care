/// message : "patient query successed"
/// isSuccess : true
/// data : {"patient":{"_id":"639b3ffcbf9cb7cdcb7a8a32","username":"Ziad Mohamed","gender":"male","phoneNumber":"0121210203","age":76,"device":{"fall":false,"updatedAt":"2022-12-17T13:58:00.728Z","deviceId":"123456789011"},"adminsRequests":[{"username":"saad","role":"doctor","gender":"male","phoneNumber":"01001010333","age":101,"email":"saad@gmail.com"}]}}

class HomeUserRes {
  HomeUserRes({
      this.message, 
      this.isSuccess, 
      this.data,});

  HomeUserRes.fromJson(dynamic json) {
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

/// patient : {"_id":"639b3ffcbf9cb7cdcb7a8a32","username":"Ziad Mohamed","gender":"male","phoneNumber":"0121210203","age":76,"device":{"fall":false,"updatedAt":"2022-12-17T13:58:00.728Z","deviceId":"123456789011"},"adminsRequests":[{"username":"saad","role":"doctor","gender":"male","phoneNumber":"01001010333","age":101,"email":"saad@gmail.com"}]}

class Data {
  Data({
      this.patient,});

  Data.fromJson(dynamic json) {
    patient = json['patient'] != null ? Patient.fromJson(json['patient']) : null;
  }
  Patient? patient;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (patient != null) {
      map['patient'] = patient?.toJson();
    }
    return map;
  }

}

/// _id : "639b3ffcbf9cb7cdcb7a8a32"
/// username : "Ziad Mohamed"
/// gender : "male"
/// phoneNumber : "0121210203"
/// age : 76
/// device : {"fall":false,"updatedAt":"2022-12-17T13:58:00.728Z","deviceId":"123456789011"}
/// adminsRequests : [{"username":"saad","role":"doctor","gender":"male","phoneNumber":"01001010333","age":101,"email":"saad@gmail.com"}]

class Patient {
  Patient({
      this.id, 
      this.username, 
      this.gender, 
      this.phoneNumber, 
      this.age, 
      this.device, 
      this.adminsRequests,});

  Patient.fromJson(dynamic json) {
    id = json['_id'];
    username = json['username'];
    gender = json['gender'];
    phoneNumber = json['phoneNumber'];
    age = json['age'];
    device = json['device'] != null ? Device.fromJson(json['device']) : null;
    if (json['adminsRequests'] != null) {
      adminsRequests = [];
      json['adminsRequests'].forEach((v) {
        adminsRequests?.add(AdminsRequests.fromJson(v));
      });
    }
  }
  String? id;
  String? username;
  String? gender;
  String? phoneNumber;
  num? age;
  Device? device;
  List<AdminsRequests>? adminsRequests;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['username'] = username;
    map['gender'] = gender;
    map['phoneNumber'] = phoneNumber;
    map['age'] = age;
    if (device != null) {
      map['device'] = device?.toJson();
    }
    if (adminsRequests != null) {
      map['adminsRequests'] = adminsRequests?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// username : "saad"
/// role : "doctor"
/// gender : "male"
/// phoneNumber : "01001010333"
/// age : 101
/// email : "saad@gmail.com"

class AdminsRequests {
  AdminsRequests({
      this.username, 
      this.role, 
      this.gender, 
      this.phoneNumber, 
      this.age, 
      this.email,});

  AdminsRequests.fromJson(dynamic json) {
    username = json['username'];
    role = json['role'];
    gender = json['gender'];
    phoneNumber = json['phoneNumber'];
    age = json['age'];
    email = json['email'];
  }
  String? username;
  String? role;
  String? gender;
  String? phoneNumber;
  num? age;
  String? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['role'] = role;
    map['gender'] = gender;
    map['phoneNumber'] = phoneNumber;
    map['age'] = age;
    map['email'] = email;
    return map;
  }

}

/// fall : false
/// updatedAt : "2022-12-17T13:58:00.728Z"
/// deviceId : "123456789011"

class Device {
  Device({
      this.fall, 
      this.updatedAt, 
      this.deviceId,});

  Device.fromJson(dynamic json) {
    fall = json['fall'];
    updatedAt = json['updatedAt'];
    deviceId = json['deviceId'];
  }
  bool? fall;
  String? updatedAt;
  String? deviceId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fall'] = fall;
    map['updatedAt'] = updatedAt;
    map['deviceId'] = deviceId;
    return map;
  }

}