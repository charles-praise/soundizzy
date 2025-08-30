import '../../export.dart';

// function to get the screen height/ width
deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
// function to get device width
deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

// folder picker e.i. pick folders and there paths Using Platform channels
class FolderPicker {
  static const MethodChannel _channel = MethodChannel('folder_picker');

  static Future<List<String>?> pickAudioFiles() async {
    final List<dynamic>? result = await _channel.invokeMethod('pickFolder');
    return result?.cast<String>();
  }
}

// list all audio files in a directory
listAudioFiles(String? path) {}
