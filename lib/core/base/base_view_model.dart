import 'package:flutter/material.dart';

abstract class BaseVM extends ChangeNotifier {
  final BuildContext context;
  bool _disposed = false;
  bool _mounted = true;
  bool _isLoading = false;
  String? _error;

  BaseVM(this.context) {
    onInit();
  }

  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get mounted => _mounted;

  // Set loading state
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  // Set error message
  void setError(String? error) {
    _error = error;
    notifyListeners();
  }

  // Clear error message
  void clearError() {
    _error = null;
    notifyListeners();
  }

  void onInit() {}

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _mounted = false;
    _disposed = true;
    _error = null;
    _isLoading = false;
    super.dispose();
  }

  // Helper method để kiểm tra trước khi thực hiện các tác vụ
  bool canExecute() {
    return _mounted && !_disposed;
  }
}
