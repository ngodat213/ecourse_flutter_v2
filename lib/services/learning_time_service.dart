import 'dart:async';

class LearningTimeService {
  static int _sessionWatchTime = 0;
  static Timer? _timer;

  // Getter để lấy thời gian học
  static int get sessionWatchTime => _sessionWatchTime;

  // Getter để lấy thời gian học định dạng chuỗi
  static int get secondsWatchTime {
    return _sessionWatchTime;
  }

  static int get minutesWatchTime {
    final minutes = _sessionWatchTime ~/ 60;
    return minutes;
  }

  // Bắt đầu đếm thời gian
  static void startCounting() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _sessionWatchTime++;
    });
  }

  // Tạm dừng đếm
  static void pauseCounting() {
    _timer?.cancel();
  }

  // Reset thời gian về 0
  static void reset() {
    _sessionWatchTime = 0;
    _timer?.cancel();
    _timer = null;
  }
}
