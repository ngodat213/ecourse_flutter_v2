import 'package:flutter_dotenv/flutter_dotenv.dart';

class FileMetadata {
  final int width;
  final int height;
  final dynamic duration;
  final dynamic pages;

  FileMetadata({
    required this.width,
    required this.height,
    this.duration,
    this.pages,
  });

  factory FileMetadata.fromJson(Map<String, dynamic> json) {
    return FileMetadata(
      width: json['width'],
      height: json['height'],
      duration: json['duration'],
      pages: json['pages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'width': width,
      'height': height,
      'duration': duration,
      'pages': pages,
    };
  }
}

class CloudinaryFile {
  final FileMetadata metadata;
  final String id;
  final String ownerId;
  final String ownerType;
  final String fileType;
  final String publicId;
  final String format;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  CloudinaryFile({
    required this.metadata,
    required this.id,
    required this.ownerId,
    required this.ownerType,
    required this.fileType,
    required this.publicId,
    required this.format,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory CloudinaryFile.fromJson(Map<String, dynamic> json) {
    return CloudinaryFile(
      metadata: FileMetadata.fromJson(json['metadata']),
      id: json['_id'],
      ownerId: json['owner_id'],
      ownerType: json['owner_type'],
      fileType: json['file_type'],
      publicId: json['public_id'],
      format: json['format'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'metadata': metadata.toJson(),
      '_id': id,
      'owner_id': ownerId,
      'owner_type': ownerType,
      'file_type': fileType,
      'public_id': publicId,
      'format': format,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }

  String get url => '${dotenv.env['BASE_CLOUDINARY_URL']}$publicId.$format';
}
