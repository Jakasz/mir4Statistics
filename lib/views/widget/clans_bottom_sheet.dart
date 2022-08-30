import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:legionstat/bloc/clans/clans_bloc.dart';
import 'package:legionstat/bloc/clans/clans_state.dart';
import 'package:legionstat/bloc/members/members_bloc.dart';
import 'package:legionstat/bloc/members/members_event.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'legion_clans.dart';

class BottomSheetClansList extends StatelessWidget {
  final Function changeClanId;

  BottomSheetClansList({required this.changeClanId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClanListBloc, ClansState>(
        listener: ((context, state) {}),
        builder: (context, state) {
          if (state is InitClansState) {}
          if (state is ClansStateError) {}

          if (state is ClansStateLoading) {
            return Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: CircularProgressIndicator()));
          }
          if (state is ClansStateLoaded) {
            final MemberBloc memberBloc = context.read<MemberBloc>();
            return Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: const EdgeInsets.all(5),
                  width: 180,
                  child: ElevatedButton.icon(
                    icon: FaIcon(FontAwesomeIcons.guilded, color: Colors.white),
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    onPressed: () {
                      showModalBottomSheet(
                          backgroundColor: Color(0xff243B55),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20))),
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return DraggableScrollableSheet(
                              expand: false,
                              initialChildSize: 0.4,
                              maxChildSize: 0.8,
                              builder: (BuildContext context,
                                  ScrollController scrollController) {
                                return (state.clanListData.length == 0)
                                    ? Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Divider(
                                              thickness: 5,
                                              height: 20,
                                              color: Colors.white,
                                              endIndent: 175,
                                              indent: 175,
                                            ),
                                            Text(
                                              'Nothing here, choose server',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                            SvgPicture.asset(
                                              'assets/undraw_the_search_s0xf.svg',
                                              fit: BoxFit.scaleDown,
                                              width: 150,
                                              height: 180,
                                            ),
                                          ],
                                        ),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.only(
                                            top: 20, left: 8, right: 8),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Divider(
                                              thickness: 5,
                                              height: 20,
                                              color: Colors.white,
                                              endIndent: 175,
                                              indent: 175,
                                            ),
                                            Expanded(
                                              child: ListView.builder(
                                                  controller: scrollController,
                                                  itemCount:
                                                      state.clanListData.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        setClanValue(state
                                                            .clanListData[index]
                                                            .clanId);
                                                        memberBloc.add(
                                                            MemberLoadingEvent());
                                                        changeClanId();
                                                      },
                                                      child: ClanDataSheet(
                                                        clanName: state
                                                            .clanListData[index]
                                                            .clanName,
                                                        clanId: state
                                                            .clanListData[index]
                                                            .clanId,
                                                        clanBM: state
                                                            .clanListData[index]
                                                            .clanBM,
                                                        clanLeader: state
                                                            .clanListData[index]
                                                            .clanLeader,
                                                        clanPosition: state
                                                            .clanListData[index]
                                                            .clanPosition,
                                                        index: index,
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          ],
                                        ),
                                      );
                              },
                            );
                          });
                    },
                    label: Text('Choose clan'),
                  ),
                ));
          }
          return SizedBox.shrink();
        });
  }

  void setClanValue(int clanId) async {
    final _prefInstance = await SharedPreferences.getInstance();
    _prefInstance.setInt('clanId', clanId);
  }
}
