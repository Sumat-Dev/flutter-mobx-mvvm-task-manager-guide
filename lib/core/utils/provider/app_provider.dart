class AppProvider{
  AppProvider._init();
  static AppProvider? _instance;
  static Future<AppProvider> get instance async {
    _instance ??= AppProvider._init();
    return _instance!;
  }
}
