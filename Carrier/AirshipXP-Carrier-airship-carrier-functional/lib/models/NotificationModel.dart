class NotificationModel {
  NotificationModel({
      this.data,});

  NotificationModel.fromJson(dynamic json) {
    data = json['data'] != null ? NotificationData.fromJson(json['data']) : null;
  }
  NotificationData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class NotificationData {
  NotificationData({
    this.totalcount,
    this.notifications,});

  NotificationData.fromJson(dynamic json) {
    totalcount = json['totalcount'];
    if (json['notifications'] != null) {
      notifications = [];
      json['notifications'].forEach((v) {
        notifications?.add(Notifications.fromJson(v));
      });
    }
  }
  int? totalcount;
  List<Notifications>? notifications;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalcount'] = totalcount;
    if (notifications != null) {
      map['notifications'] = notifications?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Notifications {
  Notifications({
    this.notificationid,
    this.notificationtitle,
    this.notificationbody,
    this.createdondate,});

  Notifications.fromJson(dynamic json) {
    notificationid = json['notificationid'];
    notificationtitle = json['notificationtitle'];
    notificationbody = json['notificationbody'];
    createdondate = json['createdondate'];
  }
  int? notificationid;
  String? notificationtitle;
  String? notificationbody;
  String? createdondate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['notificationid'] = notificationid;
    map['notificationtitle'] = notificationtitle;
    map['notificationbody'] = notificationbody;
    map['createdondate'] = createdondate;
    return map;
  }

}