import '../model/api_resp.dart';
import '../utils/err_m.dart';
import '../utils/mydio.dart';

abstract class NonAmcFeedbackServices {
  static Future<ApiResp> fetchNonamcFeedDetails(int customerId) async {
    dynamic resp;
    await errMAsync(() async {
      resp = await MyDio().get('https://tipsandplans.com/admin/api/v1/nonamcservice-history?customer_id=$customerId');
    });
    return resp != null
        ? ApiResp(
      ok: true,
      rdata: resp,
      msgs: [

      ], message: '',
    )
        : ApiResp(
      ok: false,
      rdata: resp,
      msgs: [

      ], message: '',
    );
  }
}