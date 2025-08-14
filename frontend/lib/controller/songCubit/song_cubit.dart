import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'song_state.dart';

class SongCubit extends Cubit<SongState> {
  SongCubit() : super(SongInitial());
}
