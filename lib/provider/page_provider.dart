import 'package:flutter/foundation.dart';

class PageProvider with ChangeNotifier {
  int _currentPage = 0;
  String _currentTitle = '';

  int get currentPage => _currentPage;
  String get currentTitle => _currentTitle;

  void setCurrentPage(int page, String title) {
    _currentPage = page;
    _currentTitle = title;
    notifyListeners();
  }
}
