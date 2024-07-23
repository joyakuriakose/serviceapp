import '../model/api_resp.dart';
import '../utils/err_m.dart';
import '../utils/mydio.dart';

abstract class ServiceHistoryServices {
  static Future<ApiResp> fetchServiceHistory(int customer_id) async {
    dynamic resp;
    await errMAsync(() async {
      resp = await MyDio().get('https://seowebsites.in/service_management/api/v1/service-history?customer_id=$customer_id');
    });
    return resp != null
        ? ApiResp(
      ok: true,
      rdata: resp,
      msgs: [],
      message: '',
    )
        : ApiResp(
      ok: false,
      rdata: resp,
      msgs: [],
      message: '',
    );
  }
}
