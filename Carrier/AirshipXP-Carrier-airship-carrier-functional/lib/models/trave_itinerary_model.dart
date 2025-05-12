class TravelItineraryModel {
  List<ItineraryData>? data;

  TravelItineraryModel({this.data});

  TravelItineraryModel.fromJson(Map<String, dynamic> json) {
    if (json['itinerarylist'] != null) {
      data = <ItineraryData>[];
      json['itinerarylist'].forEach((v) {
        data!.add(new ItineraryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['itinerarylist'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItineraryData {
  int? carriertravelid;
  String? sourcecity;
  String? sourceairport;
  String? desctinationcity;
  String? carrierdeparturedatetime;
  String? flightdetails;
  bool? activebooking;

  ItineraryData(
      {this.carriertravelid,
        this.sourcecity,
        this.sourceairport,
        this.desctinationcity,
        this.carrierdeparturedatetime,
        this.flightdetails,
        this.activebooking});

  ItineraryData.fromJson(Map<String, dynamic> json) {
    carriertravelid = json['carriertravelid'];
    sourcecity = json['sourcecity'];
    sourceairport = json['sourceairport'];
    desctinationcity = json['desctinationcity'];
    carrierdeparturedatetime = json['carrierdeparturedatetime'];
    flightdetails = json['flightdetails'];
    activebooking = json['activebooking'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['carriertravelid'] = this.carriertravelid;
    data['sourcecity'] = this.sourcecity;
    data['sourceairport'] = this.sourceairport;
    data['desctinationcity'] = this.desctinationcity;
    data['carrierdeparturedatetime'] = this.carrierdeparturedatetime;
    data['flightdetails'] = this.flightdetails;
    data['activebooking'] = this.activebooking;
    return data;
  }
}