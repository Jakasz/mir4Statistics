import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:legionstat/bloc/clans/clans_bloc.dart';
import 'package:legionstat/bloc/clans/clans_event.dart';
import 'package:legionstat/bloc/members/members_bloc.dart';
import 'package:legionstat/bloc/members/members_event.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../bloc/servers/server_list_bloc.dart';
import '../../bloc/servers/servers_list_event.dart';
import '../../bloc/servers/servers_list_state.dart';

class DrawerWidget extends StatelessWidget {
  final Function() changedWorld;

  DrawerWidget({required this.changedWorld});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServerListBloC, ServerListState>(
      listener: ((context, state) {
        if (state is ServerListLoadedState) {}
      }),
      builder: (context, state) {
        if (state is InitServerLoadState) {
          return Scaffold(body:
          const Center(child: CircularProgressIndicator(color: Colors.white,)));
        }

        if (state is ServerListLoadingEvent) {
          return Scaffold(body:
          const Center(child: CircularProgressIndicator(color: Colors.white,)));
        }

        if (state is ServerListLoadedState) {
          return Scaffold(
              body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                  right: MediaQuery.of(context).size.width - 230,
                  top: 10,
                  bottom: 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: const Text(
                          'Servers',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      )),
                  Expanded(
                    flex: 1,
                    child: ListView.builder(
                        itemCount: state.serverListModel.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: FaIcon(FontAwesomeIcons.server,
                                size: 36, color: Colors.blue),
                            onTap: () {
                              final ClanListBloc clanBloc = context.read<ClanListBloc>();
                              final MemberBloc memberBloc = context.read<MemberBloc>();
                              setWorldValue(state.serverListModel[index].subWorldId, clanBloc, memberBloc);
                              changedWorld();
                            },
                            title: Text(
                              state.serverListModel[index].subWorldName,
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                                state.serverListModel[index].worldName,
                                style: TextStyle(color: Colors.white)),
                          );
                        }),
                  )
                ],
              ),
            ),
          ));
        }

        if (state is ServerListLoadingStateError) {
          return const Scaffold(
            body: Center(
              child: const Text(
                'Error fetching data',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  void setWorldValue(int worldId, ClanListBloc clanBloc, MemberBloc memberBloc ) async {
    final _prefInstance  = await SharedPreferences.getInstance();
    // _prefInstance.clear();
    _prefInstance.setInt('globalWorldId', worldId);
    clanBloc.add(ClansLoadingEvent());
    memberBloc.add(MemberEmptyEvent());
  }

}
