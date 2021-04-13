import 'package:testapp/config/net_aip.dart';
import 'package:web_socket_channel/io.dart';

class WebSocketUtils {
  IOWebSocketChannel _channel;
  //连接服务器
  void connect() {
    _channel = IOWebSocketChannel.connect(NetApi.address);
  }

  void send(dynamic data) {
    if (_channel != null) {
      _channel.sink.add(data);
    }
  }

  Stream get stream => _channel?.stream;
  //断开连接
  void disConnect() {
    if (_channel != null) {
      _channel.sink.close();
    }
  }
}
