import 'package:radreviews/alert.dart';
import 'package:radreviews/constants.dart';
import 'package:radreviews/linkOpener.dart';
import 'package:flutter/material.dart';
import 'package:radreviews/screens/home.dart';
import 'package:radreviews/screens/myaccount.dart';
import 'package:radreviews/screens/settings.dart';
import 'package:radreviews/screens/smsSent.dart';
import 'package:radreviews/size_config.dart';
import 'package:flutter_icons/flutter_icons.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Feather.settings,
            size: 2.0 * SizeConfig.heightMultiplier,
          ),
          title: Text(
            'Settings',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 1.4 * SizeConfig.heightMultiplier,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Feather.phone_call,
            size: 2.36 * SizeConfig.heightMultiplier,
          ),
          title: Text(
            'Support',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 1.4 * SizeConfig.heightMultiplier,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.phone_in_talk,
            size: 0.0,
          ),
          title: Text(
            '',
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            AntDesign.message1,
            size: 2.6 * SizeConfig.heightMultiplier,
          ),
          title: Text(
            'SMS Sent',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 1.4 * SizeConfig.heightMultiplier,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person_outline,
            size: 3.0 * SizeConfig.heightMultiplier,
          ),
          title: Text(
            'Account',
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: 1.4 * SizeConfig.heightMultiplier,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: kshadeColor1,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(
          () {
        selectedIndex = index;
        if (index == 0) {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Home()));
        } else if (index == 1) {
          QuickLaunchLink().hitLink(
              'mailto:support@ethink.solutions?subject=Need%20Help&body=Hi%20Support');
        } else if (index == 2) {
//      TODO  Navigator.push(context, MaterialPageRoute(builder: (context)=>XDMyAccount(),),);
        } else if (index == 3) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SMSSent(),
            ),
          );
        }
        else if (index == 4) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyAccount(),
            ),
          );
        }
      },
    );
  }

  void showAlert() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomAlertDialog();
      },
    );
  }

}
