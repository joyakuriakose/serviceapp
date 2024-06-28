import 'dart:convert';


ApiResp apiRespFromJson(String str) => ApiResp.fromJson(json.decode(str));

String apiRespToJson(ApiResp data) => json.encode(data.toJson());

class ApiResp {
    ApiResp({
        this.ok,
        this.rdata,
        this.msgs,
    });

    bool? ok;
    dynamic? rdata;
    List<dynamic>? msgs;

    factory ApiResp.fromJson(Map<String, dynamic> json) => ApiResp(
        ok: json["ok"],
        rdata: json["rdata"],
        msgs: List<dynamic>.from(json["msgs"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "rdata": rdata,
        "msgs": List<dynamic>.from(msgs!.map((x) => x)),
    };
}

