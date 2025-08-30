part of 'audio_cubit.dart';

class AudioState {
  final bool isPlaying;
  final bool isLoading;
  final String? error;
  final Duration position;
  final Duration duration;
  final String? filePath;
  final List<double>? waveformData;
  final PlayerController playerController;

  AudioState({
    this.isPlaying = false,
    this.isLoading = false,
    this.error,
    this.position = Duration.zero,
    this.duration = Duration.zero,
    this.filePath,
    this.waveformData,
    required this.playerController, // Make required
  });

  AudioState copyWith({
    bool? isPlaying,
    bool? isLoading,
    String? error,
    Duration? position,
    Duration? duration,
    String? filePath,
    List<double>? waveformData,
    PlayerController? playerController,
  }) {
    return AudioState(
      isPlaying: isPlaying ?? this.isPlaying,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      position: position ?? this.position,
      duration: duration ?? this.duration,
      filePath: filePath ?? this.filePath,
      waveformData: waveformData ?? this.waveformData,
      playerController: playerController ?? this.playerController,
    );
  }
}
