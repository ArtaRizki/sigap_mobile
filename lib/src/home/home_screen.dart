import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sigap_mobile/common/component/custom_navigator.dart';
import 'package:sigap_mobile/common/helper/constant.dart';
import 'package:sigap_mobile/generated/assets.dart';
import 'package:sigap_mobile/src/login/login_bloc.dart';
import 'package:sigap_mobile/src/login/login_screen.dart';
import 'package:sigap_mobile/src/pre_inspection/data_table/data_table_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Constant.primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(18),
            bottomRight: Radius.circular(18),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Constant.xSizedBox32,
            Constant.xSizedBox16,
            Image.asset(
              Assets.imagesImgLogoSigap,
              width: 127.29,
              height: 36,
            ),
            Constant.xSizedBox24,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Image.asset(Assets.imagesImgAvatar),
                ),
                Constant.xSizedBox16,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Saimin',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Constant.xSizedBox4,
                      Text(
                        'Operator Alat',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.clear();
                    CusNav.nPushAndRemoveUntil(context, LoginScreen());
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Image.asset(Assets.iconsIcLogout),
                  ),
                ),
              ],
            ),
            Constant.xSizedBox8,
          ],
        ),
      );
    }

    Widget banner() {
      return Container(
        height: 160,
        margin: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Color(0xffD9D9D9),
          borderRadius: BorderRadius.circular(18),
        ),
      );
    }

    Widget menuItem() {
      return InkWell(
        onTap: () async {
          CusNav.nPush(context, DataTableScreen());
        },
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Constant.primaryColor,
                    Constant.secondaryColor,
                  ],
                ),
              ),
              child: Image.asset(Assets.iconsIcPreInspectionList),
            ),
            Text(
              'Pre Inspection List',
              style: TextStyle(color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header(),
            Constant.xSizedBox16,
            Constant.xSizedBox4,
            banner(),
            Constant.xSizedBox24,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Main Menu',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            Constant.xSizedBox24,
            Expanded(
              child: GridView.count(
                padding: EdgeInsets.symmetric(horizontal: 8),
                crossAxisCount: 4,
                crossAxisSpacing: 0,
                mainAxisSpacing: 16,
                children: List.generate(1, (i) => menuItem()),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    'Sigap V1.0 (Build 59) Supported by',
                    style: TextStyle(color: Color(0xffB9B9B9), fontSize: 12),
                  ),
                  Constant.xSizedBox8,
                  Image.asset(Assets.imagesImgPelindo),
                ],
              ),
            ),
            Constant.xSizedBox16,
          ],
        ),
      ),
    );
  }
}
