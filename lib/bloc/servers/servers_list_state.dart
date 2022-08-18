import '../../models/world_model.dart';

abstract class ServerListState {}

class InitServerLoadState extends ServerListState {}

class ServerListLoadingState extends ServerListState {}

class ServerListLoadingStateError extends ServerListState {
  final String message;

  ServerListLoadingStateError({required this.message});
}

class ServerListLoadedState extends ServerListState {
  final List<WorldsData> serverListModel;

  ServerListLoadedState({required this.serverListModel});
}
