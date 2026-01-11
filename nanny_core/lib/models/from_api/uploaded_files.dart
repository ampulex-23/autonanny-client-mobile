class UploadedFiles {
  UploadedFiles({
    required this.paths,
    required this.types
  });

  final List<String> paths;
  final List<int> types;

  UploadedFiles.fromJson(Map<String, dynamic> json)
    : paths = List<String>.from(json['files_path']),
      types = List<int>.from(json['files_type']);
}