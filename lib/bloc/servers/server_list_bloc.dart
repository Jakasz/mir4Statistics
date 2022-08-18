import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legionstat/bloc/servers/servers_list_event.dart';
import 'package:legionstat/bloc/servers/servers_list_state.dart';

import '../../api/repository/world_repository.dart';

class ServerListBloC extends Bloc<ServerListEvent, ServerListState> {
  final WorldRepository worldApi;

  ServerListBloC({required this.worldApi}) : super(InitServerLoadState()) {
    on<ServerListLoadingEvent>((event, emit) async {
      emit(ServerListLoadingState());
      try {
        final _serverListRep = await worldApi.getAllWorlds();
        emit(ServerListLoadedState(serverListModel: _serverListRep));
      } catch (e) {
        emit(ServerListLoadingStateError(message: e.toString()));
      }
    });
  }
}
