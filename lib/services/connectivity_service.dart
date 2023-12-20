import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  static Future<bool> isConnectedToInternet() async {
    final status = await Connectivity().checkConnectivity();
    return (status == ConnectivityResult.mobile || status == ConnectivityResult.wifi);
  }
}
