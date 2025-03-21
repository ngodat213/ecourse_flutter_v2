import 'dart:async';
import 'package:flutter/material.dart';
import '../core/base/base_view_model.dart';
import '../repositories/user_repository.dart';

class LearningStreakVM extends BaseVM {
  final UserRepository _userRepository = UserRepository();

  LearningStreakVM(context) : super(context);

  // Learning time tracking
  int _watchTimeInSeconds = 0;
  Timer? _timer;
  bool _isTracking = false;

  // Getters
  int get watchTimeInSeconds => _watchTimeInSeconds;
  int get watchTimeInMinutes => _watchTimeInSeconds ~/ 60;
  bool get isTracking => _isTracking;
  double get progressPercent => _watchTimeInSeconds / (TIME_LIMIT);

  // Constants
  static const int TIME_LIMIT = 30 * 60; // 30 phút

  // Streak info
  int _currentStreak = 0;
  int get currentStreak => _currentStreak;

  // Methods for time tracking
  void startTracking() {
    if (_isTracking) return;

    _isTracking = true;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _watchTimeInSeconds++;
      notifyListeners();

      // Check if reached time limit
      if (_watchTimeInSeconds >= TIME_LIMIT) {
        updateStreak();
      }
    });
  }

  void pauseTracking() {
    _isTracking = false;
    _timer?.cancel();
  }

  void resetTracking() {
    _watchTimeInSeconds = 0;
    _isTracking = false;
    _timer?.cancel();
    notifyListeners();
  }

  // API calls
  Future<void> updateStreak() async {
    try {
      final response = await _userRepository.updateStreak(
        duration: _watchTimeInSeconds,
        type: 'video',
      );

      if (response.allGood) {
        await getStreakInfo();
        resetTracking();
      }
    } catch (e) {
      debugPrint('Error updating streak: $e');
    }
  }

  Future<void> getStreakInfo() async {
    try {
      final response = await _userRepository.getStreakInfo();
      if (response.allGood) {
        _currentStreak = response.body['current_streak'] ?? 0;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error getting streak info: $e');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
