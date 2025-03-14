import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart' as path;

/// Chuyển đổi file path thành Uint8List bytes
Future<Uint8List> filePathToBytes(String filePath) async {
  final file = File(filePath);
  if (!await file.exists()) {
    throw Exception('File không tồn tại: $filePath');
  }
  return await file.readAsBytes();
}

/// Lấy tên file từ path
String getFileName(String filePath) {
  return path.basename(filePath);
}

/// Lấy extension của file
String getFileExtension(String filePath) {
  return path.extension(filePath);
}

/// Kiểm tra file có phải là ảnh không
bool isImageFile(String filePath) {
  final ext = getFileExtension(filePath).toLowerCase();
  return ['.jpg', '.jpeg', '.png', '.gif', '.webp'].contains(ext);
}

/// Kiểm tra kích thước file (bytes)
Future<int> getFileSize(String filePath) async {
  final file = File(filePath);
  if (!await file.exists()) {
    throw Exception('File không tồn tại: $filePath');
  }
  return await file.length();
}

/// Kiểm tra kích thước file có vượt quá giới hạn không (MB)
Future<bool> isFileSizeValid(String filePath, int maxSizeMB) async {
  final fileSize = await getFileSize(filePath);
  return fileSize <= maxSizeMB * 1024 * 1024;
}

/// Tạo tên file unique
String generateUniqueFileName(String originalFileName) {
  final timestamp = DateTime.now().millisecondsSinceEpoch;
  final ext = getFileExtension(originalFileName);
  final name = path.basenameWithoutExtension(originalFileName);
  return '${name}_$timestamp$ext';
}
