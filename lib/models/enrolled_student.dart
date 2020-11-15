class Enrolled {
  final String studentId;
  final int status;

  Enrolled({
    this.studentId,
    this.status,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['student_id'] = this.studentId;
    data['status'] = this.status;
    return data;
  }

  factory Enrolled.fromJson(Map<String, dynamic> json) {
    return Enrolled(
      studentId: json['student_id'],
      status: json['status'],
    );
  }
}
