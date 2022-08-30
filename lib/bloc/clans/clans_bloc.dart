import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legionstat/bloc/clans/clans_event.dart';
import 'package:legionstat/bloc/clans/clans_state.dart';

import '../../api/repository/clans_repository.dart';

class ClanListBloc extends Bloc<ClansEvent, ClansState> {
  final ClanRepository clansRepository;

  ClanListBloc({required this.clansRepository})
      : super(InitClansState()) {
    on<ClansLoadingEvent>((event, emit) async {
      emit(ClansStateLoading());
      try {
        final _clanListData = await clansRepository.getAllClans();
        emit(ClansStateLoaded(clanListData: _clanListData));
      } catch (e) {
        emit(ClansStateError(message: e.toString()));
      }
    },);
  }
}
