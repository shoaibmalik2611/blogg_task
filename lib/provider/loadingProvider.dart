import 'package:flutter/cupertino.dart';

class LoadingProvider extends ChangeNotifier {
  bool? _isLoading = false;

  get getLoadingStatus => _isLoading;

  setLoadingStatus() {
    _isLoading = !_isLoading!;
    notifyListeners();
  }
}
