import 'package:legionstat/models/clans_list_model.dart';

abstract class ClansState {}

class InitClansState extends ClansState {}


class ClansStateLoading extends ClansState {}

class ClansStateLoaded extends ClansState {
  final List<ClanListData> clanListData;

  ClansStateLoaded({required this.clanListData});
}

class ClansStateError extends ClansState {
  final String message;

  ClansStateError({required this.message});
}