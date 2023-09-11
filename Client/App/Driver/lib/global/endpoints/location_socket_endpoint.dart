import 'package:network_info_plus/network_info_plus.dart';

// const String socketHardUrl = 'http://10.123.0.77:3000';
const String socketHardUrl = 'https://2955-115-73-217-121.ngrok-free.app';
const String socketListenUrl = 'http://172.18.0.1:3100';

class IpAddress {
  late NetworkInfo _networkInfo;

  Future<String> getIpAddress() async {
    _networkInfo = NetworkInfo();
    final ipAddress = await _networkInfo.getWifiIP();
    return ipAddress!;
  }

  Future<String> socketUrl() async {
    final ipAddress = await getIpAddress();
    return 'http://$ipAddress:3000';
  }
}
