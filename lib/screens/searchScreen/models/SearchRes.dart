/// message : "patient search successed"
/// isSuccess : true
/// data : {"patients":[{"_id":"63989985b91a97878ce76007","username":"sherief","gender":"male","phoneNumber":"01003128000","age":57,"device":{"deviceId":"1234567abcde"},"isRequestedAlready":true},{"_id":"6398999fb91a97878ce76017","username":"obada","gender":"male","phoneNumber":"01003128000","age":21,"device":{"deviceId":"123456789011"},"isRequestedAlready":true}]}

class SearchRes {
  SearchRes({
      this.message, 
      this.isSuccess, 
      this.data,});

  SearchRes.fromJson(dynamic json) {
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

/// patients : [{"_id":"63989985b91a97878ce76007","username":"sherief","gender":"male","phoneNumber":"01003128000","age":57,"device":{"deviceId":"1234567abcde"},"isRequestedAlready":true},{"_id":"6398999fb91a97878ce76017","username":"obada","gender":"male","phoneNumber":"01003128000","age":21,"device":{"deviceId":"123456789011"},"isRequestedAlready":true}]

class Data {
  Data({
      this.patients,});

  Data.fromJson(dynamic json) {
    if (json['patients'] != null) {
      patients = [];
      json['patients'].forEach((v) {
        patients?.add(Patients.fromJson(v));
      });
    }
  }
  List<Patients>? patients;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (patients != null) {
      map['patients'] = patients?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "63989985b91a97878ce76007"
/// username : "sherief"
/// gender : "male"
/// phoneNumber : "01003128000"
/// age : 57
/// device : {"deviceId":"1234567abcde"}
/// isRequestedAlready : true

class Patients {
  Patients({
      this.id, 
      this.username, 
      this.gender, 
      this.phoneNumber, 
      this.age, 
      this.device, 
      this.isRequestedAlready,});

  Patients.fromJson(dynamic json) {
    id = json['_id'];
    username = json['username'];
    gender = json['gender'];
    phoneNumber = json['phoneNumber'];
    age = json['age'];
    device = json['device'] != null ? Device.fromJson(json['device']) : null;
    isRequestedAlready = json['isRequestedAlready'];
  }
  String? id;
  String? username;
  String? gender;
  String? phoneNumber;
  num? age;
  Device? device;
  bool? isRequestedAlready;

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
    map['isRequestedAlready'] = isRequestedAlready;
    return map;
  }

}

/// deviceId : "1234567abcde"

class Device {
  Device({
      this.deviceId,});

  Device.fromJson(dynamic json) {
    deviceId = json['deviceId'];
  }
  String? deviceId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['deviceId'] = deviceId;
    return map;
  }

}