class BasicResponse {
  final int responseCode;
  final String responseMessage;
  final Object data;

  BasicResponse({this.responseCode, this.responseMessage, this.data});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['responseCode'] = this.responseCode;
    data['responseMessage'] = this.responseMessage;
    data['data'] = this.data;
    return data;
  }

  factory BasicResponse.fromJson(Map<String, dynamic> json) {
    return BasicResponse(
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
      data: json['data'],
    );
  }
}
