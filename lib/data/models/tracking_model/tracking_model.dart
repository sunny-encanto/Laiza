class TrackingDetailModel {
  String status;
  List<TrackingDetailList> trackingDetailList;

  TrackingDetailModel({
    required this.status,
    required this.trackingDetailList,
  });

  factory TrackingDetailModel.fromJson(Map<String, dynamic> json) =>
      TrackingDetailModel(
        status: json["status"],
        trackingDetailList: List<TrackingDetailList>.from(
            json["trackingDetailList"]
                .map((x) => TrackingDetailList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "trackingDetailList":
            List<dynamic>.from(trackingDetailList.map((x) => x.toJson())),
      };
}

class TrackingDetailList {
  String journeyType;
  String customerOrderNumber;
  String trackingId;
  String currentStatus;
  DateTime dateTime;
  dynamic expectedDeliveryDate;
  String courierPartnerName;
  List<StatusLogList> statusLogList;

  TrackingDetailList({
    required this.journeyType,
    required this.customerOrderNumber,
    required this.trackingId,
    required this.currentStatus,
    required this.dateTime,
    required this.expectedDeliveryDate,
    required this.courierPartnerName,
    required this.statusLogList,
  });

  factory TrackingDetailList.fromJson(Map<String, dynamic> json) =>
      TrackingDetailList(
        journeyType: json["journeyType"],
        customerOrderNumber: json["customerOrderNumber"],
        trackingId: json["trackingId"],
        currentStatus: json["currentStatus"],
        dateTime: DateTime.parse(json["dateTime"]),
        expectedDeliveryDate: json["expectedDeliveryDate"],
        courierPartnerName: json["courierPartnerName"],
        statusLogList: List<StatusLogList>.from(
            json["statusLogList"].map((x) => StatusLogList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "journeyType": journeyType,
        "customerOrderNumber": customerOrderNumber,
        "trackingId": trackingId,
        "currentStatus": currentStatus,
        "dateTime": dateTime.toIso8601String(),
        "expectedDeliveryDate": expectedDeliveryDate,
        "courierPartnerName": courierPartnerName,
        "statusLogList":
            List<dynamic>.from(statusLogList.map((x) => x.toJson())),
      };
}

class StatusLogList {
  String status;
  String remarks;
  dynamic location;
  dynamic city;
  String? state;
  String country;
  DateTime dateTime;

  StatusLogList({
    required this.status,
    required this.remarks,
    required this.location,
    required this.city,
    required this.state,
    required this.country,
    required this.dateTime,
  });

  factory StatusLogList.fromJson(Map<String, dynamic> json) => StatusLogList(
        status: json["status"],
        remarks: json["remarks"],
        location: json["location"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        dateTime: DateTime.parse(json["dateTime"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "remarks": remarks,
        "location": location,
        "city": city,
        "state": state,
        "country": country,
        "dateTime": dateTime.toIso8601String(),
      };
}
