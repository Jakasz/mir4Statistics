import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legionstat/api/repository/clans_repository.dart';
import 'package:legionstat/api/repository/members_repositroy.dart';
import 'package:legionstat/bloc/clans/clans_bloc.dart';
import 'package:legionstat/bloc/members/members_bloc.dart';
import 'package:legionstat/utils/ads_manager.dart';
import 'package:legionstat/views/widget/clans_bottom_sheet.dart';
import 'package:legionstat/views/widget/drawer_widget.dart';
import 'package:legionstat/views/widget/main_screen_widget.dart';

import '../api/repository/world_repository.dart';
import '../bloc/servers/server_list_bloc.dart';
import '../bloc/servers/servers_list_event.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double xOffset = 0;
  late double yOffset = 0;
  late double scaleValue = 0;
  bool isDragging = false;
  bool isDrawerIsOpen = false;
  Color homeColor = Color(0xFF141E30);

  @override
  void initState() {
    openDrawer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<WorldRepository>(
          create: (context) => WorldRepository(),
        ),
        RepositoryProvider<ClanRepository>(
            create: (context) => ClanRepository()),
        RepositoryProvider<MembersRepository>(
            create: (context) => MembersRepository())
      ],
      child: MultiBlocProvider(
        providers: [
          //Provider for server list on drawer
          BlocProvider(
              create: (context) =>
                  ServerListBloC(worldApi: context.read<WorldRepository>())
                    ..add(ServerListLoadingEvent())),
          //Provider for changing clans list in bottom sheet. calls after choosing server
          BlocProvider(
              create: (context) => ClanListBloc(
                  clansRepository: context.read<ClanRepository>())),
          BlocProvider(
              create: (context) => MemberBloc(
                  memberRepository: context.read<MembersRepository>()))
        ],
        child: WillPopScope(
          onWillPop: () async {
            if (isDrawerIsOpen) {
              closeDrawer();
              return false;
            } else {
              return true;
            }
          },
          child: Scaffold(
              body: Stack(children: [
            DrawerWidget(
              changedWorld: changeWorldId,
            ),
            GestureDetector(
              onTap: () {
                closeDrawer();
              },
              onHorizontalDragStart: (details) => isDragging = true,
              onHorizontalDragUpdate: (details) {
                if (!isDragging) return;
                const delta = 1;
                if (details.delta.dx > delta) {
                  openDrawer();
                } else if (details.delta.dx < -delta) {
                  closeDrawer();
                }
              },
              child: AnimatedContainer(
                  duration: Duration(milliseconds: 150),
                  transform: Matrix4.translationValues(xOffset, yOffset, 0)
                    ..scale(scaleValue),
                  child: AbsorbPointer(
                    absorbing: isDrawerIsOpen,
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(isDrawerIsOpen ? 20 : 0),
                      child: HomeWidget(
                        openDrawer: openDrawer,
                        backColor: homeColor,
                      ),
                    ),
                  )),
            ),
            BottomSheetClansList(changeClanId: changeClanId)
          ])),
        ),
      ),
    );
  }

  void openDrawer() => setState(() {
        xOffset = 230;
        yOffset = 130;
        scaleValue = 0.6;
        isDrawerIsOpen = true;
        homeColor = Color(0xff243B55);
      });

  void closeDrawer() => setState(() {
        xOffset = 0;
        yOffset = 0;
        scaleValue = 1;
        isDrawerIsOpen = false;
        homeColor = Color(0xFF141E30);
      });

  changeWorldId() {
    setState(() {
      closeDrawer();
    });
  }

  changeClanId() {
    Navigator.pop(context);
  }
}
