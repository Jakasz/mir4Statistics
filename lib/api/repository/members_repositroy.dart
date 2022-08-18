
import 'package:legionstat/models/member_model.dart';
import '../../bloc/members/member_service.dart';

class MembersRepository{
  final MembersApi _memberProvider = MembersApi();
  Future<List<MemberData>> getAllMembers() => _memberProvider.getMemberData();
}