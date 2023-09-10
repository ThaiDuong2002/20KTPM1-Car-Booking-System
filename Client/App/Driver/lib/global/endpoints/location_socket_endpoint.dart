import 'package:network_info_plus/network_info_plus.dart';

// const String socketHardUrl = 'http://10.123.0.77:3000';
const String socketHardUrl = 'https://ae4f-42-115-94-181.ngrok-free.app';
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
