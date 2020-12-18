class Permission {
  String statusPermission;
  String reason;
  DateTime datePermission;

  Permission({this.statusPermission, this.reason, this.datePermission});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status_permission'] = this.statusPermission;
    data['reason'] = this.reason;
    data['date_permission'] = this.datePermission.toString();

    return data;
  }

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      statusPermission: json['status_permission'],
      reason: json['reason'],
      datePermission: DateTime.parse(json['date_permission']),
    );
  }
}
