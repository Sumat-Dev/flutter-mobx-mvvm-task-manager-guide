class AppProvider{
  AppProvider._init();
  static AppProvider? _instance;
  static AppProvider get instance{
    _instance ??= AppProvider._init();
    return _instance!;
  }


}