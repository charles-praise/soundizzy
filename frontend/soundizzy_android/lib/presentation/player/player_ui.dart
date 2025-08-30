import '../../export.dart';

class Player extends StatelessWidget {
  const Player({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ElevatedButton(
          onPressed: () async {
            final audioFiles = await FolderPicker.pickAudioFiles();
            if (audioFiles != null && audioFiles.isNotEmpty) {
              print("Found audio files:");
              audioFiles.forEach(print);
            } else {
              print("No audio files found or folder not selected.");
            }
          },
          child: Text("Pick Audio Folder"),
        ),
      ),
    );
  }
}
