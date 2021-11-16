class APIBase {
  static String get baseURL {
    return 'https://gip.danielozeh.com.ng';
  }
}

class APIPathHelper {
  APIPathHelper();

  String kAuthLogin = APIBase.baseURL + '/api/auth/login';
}
