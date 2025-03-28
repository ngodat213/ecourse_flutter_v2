import 'package:ecourse_flutter_v2/core/services/base_api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ecourse_flutter_v2/app/data/repositories/user_repository_impl.dart';

class StreakService {
  static const String _WATCH_DURATION_KEY = 'watch_duration';
  static const String _LAST_STREAK_DATE_KEY = 'last_streak_date';
  static const String _DAILY_WATCH_TIME_KEY = 'daily_watch_time';
  static const int TIME_LIMIT = 30 * 60; // 5 phút

  final SharedPreferences _prefs;
  final UserRepositoryImpl _userRepository;

  // Singleton pattern
  static StreakService? _instance;
  static Future<StreakService> getInstance() async {
    if (_instance == null) {
      final prefs = await SharedPreferences.getInstance();
      _instance = StreakService._(prefs, UserRepositoryImpl());
    }
    return _instance!;
  }

  StreakService._(this._prefs, this._userRepository) {
    _checkAndResetDaily();
  }

  // Lấy tổng thời gian đã xem
  int get totalWatchedDuration => _prefs.getInt(_WATCH_DURATION_KEY) ?? 0;

  // Thêm getters cho thống kê
  int get todayWatchTime => _prefs.getInt(_DAILY_WATCH_TIME_KEY) ?? 0;
  int get streakProgress => totalWatchedDuration * 100 ~/ TIME_LIMIT;

  // Cập nhật thời gian xem
  Future<void> addWatchDuration(int seconds) async {
    await _checkAndResetDaily();

    // Cập nhật tổng thời gian
    final total = totalWatchedDuration + seconds;
    await _prefs.setInt(_WATCH_DURATION_KEY, total);

    // Cập nhật thời gian học trong ngày
    final dailyTime = todayWatchTime + seconds;
    await _prefs.setInt(_DAILY_WATCH_TIME_KEY, dailyTime);

    // Kiểm tra và update streak nếu đủ điều kiện
    if (total >= TIME_LIMIT) {
      await updateStreak();
    }
  }

  Future<void> _checkAndResetDaily() async {
    final now = DateTime.now();
    final lastStreakDate = DateTime.fromMillisecondsSinceEpoch(
      _prefs.getInt(_LAST_STREAK_DATE_KEY) ?? 0,
    );

    // Reset nếu khác ngày
    if (!_isSameDay(lastStreakDate, now)) {
      await _prefs.setInt(_WATCH_DURATION_KEY, 0);
      await _prefs.setInt(_DAILY_WATCH_TIME_KEY, 0);
      await _prefs.setInt(_LAST_STREAK_DATE_KEY, now.millisecondsSinceEpoch);
    }
  }

  Future<ApiResponse> updateStreak() async {
    final response = await _userRepository.updateStreak(
      duration: TIME_LIMIT,
      type: 'video',
    );

    if (response.allGood) {
      await _prefs.setInt(_WATCH_DURATION_KEY, 0);
    }

    return response;
  }

  Future<ApiResponse> getStreakInfo() async {
    return await _userRepository.getStreakInfo();
  }

  // Thêm method để lấy thống kê học tập
  Future<Map<String, dynamic>> getLearningStats() async {
    final streakInfo = await _userRepository.getStreakInfo();

    return {
      'today_watch_time': todayWatchTime,
      'streak_progress': streakProgress,
      'total_streak_days': streakInfo.body['total_days'] ?? 0,
      'current_streak': streakInfo.body['current_streak'] ?? 0,
    };
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
