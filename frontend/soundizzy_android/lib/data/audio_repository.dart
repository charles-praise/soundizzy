import 'dart:io';

import '../export.dart';

class AudioRepository {
  final Dio _dio = Dio();
  final Uuid _uuid = Uuid();

  //   Get local storage directory
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  //   Download audio files and save locally
  Future<String> downloadAudio(String url) async {
    try {
      final path = await _localPath;
      final fileName = '${_uuid.v4()}.mp3';
      final filePath = '$path/$fileName';
      await _dio.download(url, filePath);
      return filePath;
    } catch (e) {
      throw ('Failed to download audio: $e');
    }
  }

  //   check if file exist
  Future<bool> fileExists(String filePath) async {
    return File(filePath).exists();
  }

  //   get list of cached audio files
  Future<List<String>> getCachedAudioFiles() async {
    final path = await _localPath;
    final directory = Directory(path);
    final audioExtensions = ['.mp3', '.ogg', '.m4a'];
    for (String ext in audioExtensions) {
      return directory
          .listSync()
          .where((file) => file.path.endsWith(ext))
          .map((file) => file.path)
          .toList();
    }
    return [''];
  }
}
