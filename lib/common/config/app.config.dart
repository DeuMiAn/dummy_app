class AppConfig {
  static ServerUrl serverUrl = ServerUrl.real;

  static bool get isDevMode => serverUrl == ServerUrl.dev;
  static String get apiDomain => serverUrl.apiDomain;
  static String get fileDomain => serverUrl.fileDomain;
  static String get imgDomain => serverUrl.imgDomain;

  // 개발모드 설정
  // static const bool devMode = false;
  static const bool webDebug = false; // 안드로이드 웹 디버깅 전용

  // 기본설정
  static const String appName = 'appName';
  static const String packageName = 'packageName';
  static const int pageSize = 20;

  // header
  static final Map<String, String> headers = {
    'Content-Type': 'application/x-www-form-urlencoded'
  };

  // domain
  static const String domain = 'domain';
  static const String releaseApiDomain = 'API 실서버url';
  static const String devApiDomain = 'API 테스트서버url';

  // Url
  static const String releaseWebDomain = 'https://$domain';
  static const String devWebDomain = 'https://t-www.$domain';
  static const String relFileDomain = 'https://file.$domain';
  static const String devFileDomain = 'https://t-file.$domain';
  static const String relImgDomain = 'https://img.$domain';
  static const String devImgDomain = 'https://t-img.$domain';

  // storeUrl
  static const String appStoreUrl = '';
  static const String playStoreUrl = '';

  AppConfig._();
}

enum ServerUrl {
  real(
    '운영서버',
    AppConfig.releaseWebDomain,
    AppConfig.relFileDomain,
    AppConfig.relImgDomain,
  ),
  dev(
    '테스트서버',
    AppConfig.devWebDomain,
    AppConfig.devFileDomain,
    AppConfig.devImgDomain,
  );

  final String name;
  final String apiDomain;
  final String fileDomain;
  final String imgDomain;

  const ServerUrl(
    this.name,
    this.apiDomain,
    this.fileDomain,
    this.imgDomain,
  );
}
