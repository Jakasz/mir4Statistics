import 'package:legionstat/models/member_model.dart';

abstract class MemberState {}

class InitialMemberState extends MemberState {}

class MemberStateLoading extends MemberState {}

class MemberStateLoaded extends MemberState {
  final List<MemberData> memberDataList;

  MemberStateLoaded({required this.memberDataList});
}

class MemberStateError extends MemberState {
  final String message;

  MemberStateError({required this.message});
}
