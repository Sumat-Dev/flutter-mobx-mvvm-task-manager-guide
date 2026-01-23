import 'package:provider/single_child_widget.dart';

class ApplicationProvider {
  factory ApplicationProvider.instance() {
    _instance ??= ApplicationProvider._init();
    return _instance!;
  }

  ApplicationProvider._init();

  static ApplicationProvider? _instance;

  List<SingleChildWidget> singleItems = [];
  List<SingleChildWidget> dependItems = [];
  List<SingleChildWidget> uiChangesItems = [];
}
