class BaseResponseModel {
  BaseResponseModel({
    this.status,
    this.message,
    this.data,});

  BaseResponseModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];
  }

  int? status;
  String? message;
  String? error;
  int? errorCode;
  dynamic data;

  BaseResponseModel.withError(String errorMessage,this.errorCode) {
    error = errorMessage;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }


}