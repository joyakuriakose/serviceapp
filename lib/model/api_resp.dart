import 'dart:convert';


ApiResp apiRespFromJson(String str) => ApiResp.fromJson(json.decode(str));

String apiRespToJson(ApiResp data) => json.encode(data.toJson());

class ApiResp {
    bool ok;
    dynamic rdata;
    List<dynamic> msgs; // This should be changed to List<String> msgs;
    String message; // Add this property

    ApiResp({
        required this.ok,
        required this.rdata,
        required this.msgs,
        required this.message, // Add this constructor parameter
    });

    factory ApiResp.fromJson(Map<String, dynamic> json) {
        return ApiResp(
            ok: json['success'] ?? false,
            rdata: json['data'],
            msgs: json['data'] != null ? List<String>.from(json['data']['msgs'] ?? []) : [],
            message: json['message'], // Assign the value from JSON to message property
        );
    }

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "rdata": rdata,
        "msgs": List<dynamic>.from(msgs.map((x) => x)),
        "message": message, // Include message property in JSON serialization
    };
}
