import 'package:dio/dio.dart';
import '../model/api_msg.dart';
import '../model/api_resp.dart';
import '../presets/api_paths.dart';
import '../utils/err_m.dart';
import '../utils/mydio.dart';

abstract class LoginServices {
  static Future<ApiResp> fetchUser(String username, String password) async {
    dynamic resp;
    await errMAsync(
          () async {
        resp = await MyDio().customPost(
          ApiPaths.login,
          data: {'username': username, 'password': password},
        );
      },
      title: 'Login Failed',
    );

    if (resp is DioError) {
      // Handle DioError as before
    } else {
      respNew = resp != null
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
    return respNew;
  }


// abstract class LoginServices {
//   static Future<ApiResp> fetchUser(String email, String password, String fcmToken) async {
//     dynamic resp;
//     await errMAsync(() async {
//       resp = await MyDio().customPost(
//         ApiPaths.login,
//         data: {'email': email, 'password': password, 'device_id': fcmToken},
//       );
//       },
//       title: 'Login Failed',
//     );
//
//     if (resp is DioError) {
//       if (resp.response?.statusCode == 400) {
//         log('400 >> ${resp.response}');
//         showMsg("Invalid UserName or Password", "Login Failed");
//       }
//       if (resp.type == DioErrorType.connectTimeout) {
//         showMsg(
//             'Connection timed-out. Check internet connection.', "Login Failed");
//       }
//       if (resp.type == DioErrorType.receiveTimeout) {
//         showMsg('Unable to connect to the server', "Login Failed");
//       }
//       if (resp.type == DioErrorType.other) {
//         showMsg(
//             'Something went wrong with server communication', "Login Failed");
//       }
//     } else {
//       respNew = resp != null
//           ? ApiResp(
//         ok: true,
//         rdata: resp,
//         msgs: [
//           ApiMsg(
//             msg: "",
//             msgType: "",
//             title: "Success",
//           )
//         ],
//       )
//           : ApiResp(
//         ok: false,
//         rdata: "",
//         msgs: [
//           ApiMsg(
//             msg: "Server response failed",
//             msgType: "0",
//             title: "Failed",
//           )
//         ],
//       );
//     }
//     return respNew;
//   }

//   static Future<ApiResp> sendOTP(currentTwoFactorMethod) async {
//     try {
//       await MyDio().post(
//         ApiPaths.twoFactorAuthSendOTP,
//         data: {
//           'userid': App.user.userid,
//           'type': currentTwoFactorMethod,
//           'secret': App.user.authSecret
//         },
//       );
//       log('success');
//       respNew = ApiResp(
//         ok: true,
//         rdata: null,
//         msgs: [
//           ApiMsg(
//             msg: "",
//             msgType: "",
//             title: "Success",
//           )
//         ],
//       );
//       return respNew;
//     } catch (error) {
//       log('exception');
//       respNew = ApiResp(
//         ok: false,
//         rdata: null,
//         msgs: [
//           ApiMsg(
//             msg: "",
//             msgType: "",
//             title: "Exception",
//           )
//         ],
//       );
//       return respNew;
//     }
//   }
//
//   static Future<ApiResp> verifyOTP({otpText, currentTwoFactorMethod}) async {
//     dynamic resp;
//     await errMAsync(() async {
//       resp = await MyDio().post(ApiPaths.twoFactorAuthVerifyOTP, data: {
//         'userid': App.user.userid,
//         'otp': otpText,
//         'type': currentTwoFactorMethod,
//         'secret': App.user.authSecret
//       });
//     }, title: 'Login Failed', dialogDismiss: true);
//     log(resp.toString());
//     respNew = resp != null
//         ? ApiResp(
//       ok: true,
//       rdata: resp,
//       msgs: [
//         ApiMsg(
//           msg: "",
//           msgType: "",
//           title: "Success",
//         )
//       ],
//     )
//         : ApiResp(
//       ok: false,
//       rdata: "",
//       msgs: [
//         ApiMsg(
//           msg: "Server response failed",
//           msgType: "0",
//           title: "Failed",
//         )
//       ],
//     );
//     log('ok>>>${respNew.ok}');
//     return respNew;
//   }
}
