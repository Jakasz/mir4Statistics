import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/ads_manager.dart';

class AdViewWidget extends StatelessWidget {
  AdViewWidget({Key? key}) : super(key: key) {
    adManager.addAd(true);
  }

  final adManager = AdManager();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: Text(
              'Hey, viewing this ads will help project to live and part of the amount will go to'
                  ' the Armed Forces of Ukraine. Thanks for watching',

              style: TextStyle(fontSize: 23, color: Colors.white), textAlign: TextAlign.center),
        ),
        SvgPicture.asset('assets/video.svg',
            height: MediaQuery.of(context).size.height / 2),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
              primary: Colors.blue, elevation: 12, minimumSize: Size(200, 45)),
          onPressed: () {
            if (adManager.checkAd()) {
              adManager.showRewardedAd();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(''
                  'The Ad is loading')));
            }
          },
          icon: Icon(Icons.video_library_rounded),
          label: Text('Watch Ads',style: TextStyle(fontSize: 18)),
        )
      ],
    );
  }
}
