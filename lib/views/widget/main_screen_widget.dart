import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:legionstat/bloc/members/member_state.dart';
import 'package:legionstat/bloc/members/members_bloc.dart';
import 'package:legionstat/bloc/members/members_event.dart';
import 'package:legionstat/views/ads_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/ads_manager.dart';
import '../charts_screen.dart';
import 'legion_user.dart';

class HomeWidget extends StatelessWidget {
  final VoidCallback openDrawer;
  final Color backColor;

  HomeWidget({Key? key, required this.openDrawer, required this.backColor})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MemberBloc, MemberState>(
      listener: ((context, state) {
        if (state is MemberStateLoaded) {}
      }),
      builder: (context, state) {
        if (state is InitialMemberState) {
          return Scaffold(
            backgroundColor: backColor,
            appBar: AppBar(
                backgroundColor: Color(0xff243B55),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdsScreen()));
                      },
                      icon: Icon(Icons.ondemand_video))
                ],
                leading: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    openDrawer();
                  },
                ),
                title: Row(
                  children: [
                    const Text('Clan members'),
                  ],
                )),
            body: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: const Text(
                        'Choose world or clan to load data',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/look_down.svg',
                      width: 200,
                      height: 230,
                    ),
                  ],
                )),
          );
        }

        if (state is MemberLoadingEvent) {
          return Scaffold(
              backgroundColor: backColor,
              appBar: AppBar(
                  backgroundColor: Color(0xff243B55),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdsScreen()));
                        },
                        icon: Icon(Icons.ondemand_video))
                  ],
                  leading: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      openDrawer();
                    },
                  ),
                  title: Row(
                    children: [
                      const Text('Clan members'),
                    ],
                  )),
              body: const Center(child: CircularProgressIndicator()));
        }

        if (state is MemberStateLoaded) {
          return Scaffold(
              backgroundColor: backColor,
              appBar: AppBar(
                  backgroundColor: Color(0xff243B55),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdsScreen()));
                        },
                        icon: Icon(Icons.ondemand_video))
                  ],
                  leading: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      openDrawer();
                    },
                  ),
                  title: Row(
                    children: [
                      (state.memberDataList.isNotEmpty)
                          ? Text(state.memberDataList[0].clanName)
                          : const Text('Clan members'),
                    ],
                  )),
              body: SizedBox(
                child: Container(
                  child: GridView.builder(
                      itemCount: state.memberDataList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        return Material(
                          color: Colors.transparent,
                          child: InkWell(
                            highlightColor: Color(0xff0B486B),
                            onTap: () {
                              getWorldValue(
                                  state.memberDataList[index].memberName);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChartsScreen()));

                            },
                            child: ClanMemberWidget(
                                memberName:
                                state.memberDataList[index].memberName,
                                clanName: state.memberDataList[index].clanName,
                                lastCheck: state.memberDataList[index].loadDate
                                    .toString(),
                                battleRate:
                                state.memberDataList[index].battleRate),
                          ),
                        );
                      }),
                ),
              ));
        }
        if (state is MemberStateError) {
          return Scaffold(
            backgroundColor: backColor,
            appBar: AppBar(
                backgroundColor: Color(0xff243B55),
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AdsScreen()));
                      },
                      icon: Icon(Icons.ondemand_video))
                ],
                leading: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    openDrawer();
                  },
                ),
                title: Row(
                  children: [
                    const Text('Clan members'),
                  ],
                )),
            body: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: const Text(
                        'No loaded data. Try again..',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/look_down.svg',
                      width: 200,
                      height: 230,
                    ),
                  ],
                )),
          );
        }
        return Scaffold(
          backgroundColor: backColor,
          appBar: AppBar(
              backgroundColor: Color(0xff243B55),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdsScreen()));
                    },
                    icon: Icon(Icons.ondemand_video))
              ],
              leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  openDrawer();
                },
              ),
              title: Row(
                children: [
                  const Text('Clan members'),
                ],
              )),
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  void getWorldValue(String userName) async {
    final _prefInstance = await SharedPreferences.getInstance();
    _prefInstance.setString('userName', userName);
  }
}
