import 'dart:io';

bool isCharlesProxyEnabled = false;

HttpClient getHttpClient() {
  if (isCharlesProxyEnabled) {
    return HttpClient()
      ..findProxy = (uri) {
        return Platform.isAndroid
            ? 'PROXY 10.0.2.2:8888;'
            : 'PROXY 127.0.0.1:8888;';
      }
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
  } else {
    return HttpClient();
  }
}
