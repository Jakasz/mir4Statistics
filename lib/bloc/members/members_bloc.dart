import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legionstat/bloc/members/member_state.dart';
import 'package:legionstat/bloc/members/members_event.dart';

import '../../api/repository/members_repositroy.dart';

class MemberBloc extends Bloc<MemberEvent, MemberState> {
  final MembersRepository memberRepository;

  MemberBloc({required this.memberRepository}) : super(InitialMemberState()) {
    on<MemberLoadingEvent>((event, emit) async {
      emit(MemberStateLoading());
      try {
        final _memberListData = await memberRepository.getAllMembers();
        emit(MemberStateLoaded(memberDataList: _memberListData));
      } catch (e) {
        emit(MemberStateError(message: e.toString()));
      }
    });
    on<MemberEmptyEvent>((event, emit) async {
      emit(InitialMemberState());
    });
  }
}
