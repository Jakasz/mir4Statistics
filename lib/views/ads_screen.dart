import 'package:flutter/material.dart';
import 'package:legionstat/views/widget/ads_widget.dart';

class AdsScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ads'),
        backgroundColor: Color(0xff243B55),
      ),
      body: AdViewWidget(),
    );
  }

}