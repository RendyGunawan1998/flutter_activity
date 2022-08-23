// To parse this JSON data, do
//
//     final dispayActivity = dispayActivityFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators, prefer_null_aware_operators

import 'dart:convert';

List<DispayActivity> dispayActivityFromJson(String str) =>
    List<DispayActivity>.from(
        json.decode(str).map((x) => DispayActivity.fromJson(x)));

String dispayActivityToJson(List<DispayActivity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DispayActivity {
  DispayActivity({
    this.id,
    this.activityType,
    this.institution,
    this.when,
    this.objective,
    this.remarks,
    this.status,
  });

  int id;
  String activityType;
  String institution;
  String when;
  String objective;
  String remarks;
  int status;

  factory DispayActivity.fromJson(Map<String, dynamic> json) => DispayActivity(
        id: json["id"] == null ? null : json["id"],
        activityType:
            json["activityType"] == null ? null : json["activityType"],
        institution: json["institution"] == null ? null : json["institution"],
        // when: json["when"] == null ? null : DateTime.parse(json["when"]),
        when: json["when"] == null ? null : json["when"],
        objective: json["objective"] == null ? null : json["objective"],
        remarks: json["remarks"] == null ? null : json["remarks"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "activityType": activityType == null ? null : activityType,
        "institution": institution == null ? null : institution,
        // "when": when == null ? null : when.toIso8601String(),
        "when": when == null ? null : when,
        "objective": objective == null ? null : objective,
        "remarks": remarks == null ? null : remarks,
        "status": status == null ? null : status,
      };
}
