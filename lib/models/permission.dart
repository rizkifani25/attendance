class Permission {
  String statusPermission;
  String reason;

  Permission({this.statusPermission, this.reason});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status_permission'] = this.statusPermission ?? '-';
    data['reason'] = this.reason ?? '-';

    return data;
  }

  factory Permission.fromJson(Map<String, dynamic> json) {
    return Permission(
      statusPermission: json['status_permission'] ?? '-',
      reason: json['reason'] ?? '-',
    );
  }

  @override
  String toString() => 'Permission(statusPermission: $statusPermission, reason: $reason)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Permission && o.statusPermission == statusPermission && o.reason == reason;
  }

  @override
  int get hashCode => statusPermission.hashCode ^ reason.hashCode;
}
