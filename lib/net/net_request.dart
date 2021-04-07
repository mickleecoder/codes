import 'package:dio/dio.dart';

class ComResponse<T> {
  int code;
  String msg;
  T data;

  ComResponse({this.code, this.msg, this.data});
}

class NetRequest {
  var dio = Dio();
  Future<ComResponse<T>> requestData<T>(String path,
      {Map<String, dynamic> quryParameters,
      dynamic data,
      String method = "get"}) async {
    try {
      Response response = method == "get"
          ? await dio.get(path, queryParameters: quryParameters)
          : await dio.post(path, data: data);
      return ComResponse(
          code: response.data['code'],
          msg: response.data['msg'],
          data: response.data['data']);
    } on DioError catch (e) {
      //DioError 只会返回服务器的错误 500
      print(e.message);
      String message = e.message;
      if (e.type == DioErrorType.connectTimeout)
        message = "Connection Timeout";
      else if (e.type == DioErrorType.receiveTimeout)
        message = "Recieve Timeout";
      else if (e.type == DioErrorType.response) {
        message = "404 server not foud ${e.response.statusCode}";
      }
      return Future.error(message);
    }
  }
}
