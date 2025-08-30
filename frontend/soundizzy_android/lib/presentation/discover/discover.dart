import '../../export.dart';

class Discover extends StatelessWidget {
  final String audioUrl =
      "https://freesound.org/s/819471/"; // Replace with your URL

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AudioCubit>();
    return Scaffold(
      appBar: AppBar(title: Text('Audio Streaming App')),
      body: BlocBuilder<AudioCubit, AudioState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state.isLoading) CircularProgressIndicator(),
                if (state.error != null) Text('Error: ${state.error}'),
                if (state.waveformData != null &&
                    state.waveformData!.isNotEmpty)
                  AudioFileWaveforms(
                    size: Size(MediaQuery.of(context).size.width, 100),
                    playerController: state.playerController,
                    enableSeekGesture: true,
                    playerWaveStyle: PlayerWaveStyle(
                      scaleFactor: 100,
                      waveThickness: 2,
                      fixedWaveColor: Colors.blue,
                      liveWaveColor: Colors.blueAccent,
                    ),
                  )
                else
                  Text('No waveform data available'),
                Text(
                  'Position: ${state.position.inSeconds}s / ${state.duration.inSeconds}s',
                ),
                Slider(
                  value: state.position.inSeconds.toDouble(),
                  max:
                      state.duration.inSeconds.toDouble() > 0
                          ? state.duration.inSeconds.toDouble()
                          : 1.0,
                  onChanged:
                      (value) => cubit.seek(Duration(seconds: value.toInt())),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        state.isPlaying ? Icons.pause : Icons.play_arrow,
                      ),
                      onPressed: () {
                        if (state.isPlaying) {
                          cubit.pauseAudio();
                        } else {
                          cubit.playAudio(audioUrl);
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.stop),
                      onPressed: () => cubit.stopAudio(),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
