import 'package:flutter/material.dart';

abstract class BaseVM extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;

  bool get isLoading => _isLoading;
  String? get error => _error;

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

  // Dispose resources
  @override
  void dispose() {
    _error = null;
    _isLoading = false;
    super.dispose();
  }
}
