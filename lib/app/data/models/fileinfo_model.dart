class FileInfo {
  final String? fileId;
  final String? url;
  final String? publicId;
  final int? width;
  final int? height;
  final String? format;
  final int? size;

  FileInfo({
    this.fileId,
    this.url,
    this.publicId,
    this.width,
    this.height,
    this.format,
    this.size,
  });

  factory FileInfo.fromJson(Map<String, dynamic> json) {
    return FileInfo(
      fileId: json['fileId'],
      url: json['url'],
      publicId: json['publicId'],
      width: json['width'],
      height: json['height'],
      format: json['format'],
      size: json['size'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (fileId != null) 'fileId': fileId,
      if (url != null) 'url': url,
      if (publicId != null) 'publicId': publicId,
      if (width != null) 'width': width,
      if (height != null) 'height': height,
      if (format != null) 'format': format,
      if (size != null) 'size': size,
    };
  }
}
