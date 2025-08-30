import '../../export.dart';

part 'audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  final AudioRepository _repository;
  final AudioPlayer _audioPlayer = AudioPlayer();
  final PlayerController _playerController = PlayerController();

  AudioCubit(this._repository)
    : super(AudioState(playerController: PlayerController()));
  Future<bool> requestPermission() async {
    final status = await Permission.storage.request();
    if (!status.isGranted) {
      throw Exception('storage permission denied');
    }
    return status.isGranted;
  }

  Future<void> playAudio(String url, {bool isLocal = false}) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      String source = url;
      if (!isLocal) {
        // Check if file is cached
        final cachedFiles = await _repository.getCachedAudioFiles();
        final cachedFile = cachedFiles.firstWhere(
          (file) => file.contains(url.split('/').last),
          orElse: () => '',
        );
        if (cachedFile.isNotEmpty) {
          source = cachedFile;
          isLocal = true;
        } else {
          source = await _repository.downloadAudio(url);
          isLocal = true;
        }
      }

      // Initialize PlayerController for waveform
      await _playerController.preparePlayer(
        path: source,
        shouldExtractWaveform: true,
        noOfSamples: 100,
      );

      // Get waveform data
      final waveformData = _playerController.waveformData;
      emit(
        state.copyWith(
          waveformData: waveformData,
          filePath: source,
          playerController: _playerController,
        ),
      );

      // Start audio playback with audioplayers
      await _audioPlayer.play(
        isLocal ? DeviceFileSource(source) : UrlSource(url),
      );
      emit(state.copyWith(isPlaying: true, isLoading: false));

      // Update position and duration
      _audioPlayer.onPositionChanged.listen((position) {
        emit(state.copyWith(position: position));
      });
      _audioPlayer.onDurationChanged.listen((duration) {
        emit(state.copyWith(duration: duration));
      });
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> pauseAudio() async {
    await _audioPlayer.pause();
    await _playerController.pausePlayer();
    emit(state.copyWith(isPlaying: false));
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer.seek(position);
    await _playerController.seekTo(position.inMilliseconds);
    emit(state.copyWith(position: position));
  }

  Future<void> stopAudio() async {
    await _audioPlayer.stop();
    await _playerController.stopPlayer();
    emit(state.copyWith(isPlaying: false, position: Duration.zero));
  }

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    _playerController.dispose();
    return super.close();
  }
}
