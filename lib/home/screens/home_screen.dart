import 'package:evently/events/screens/create_event_screen.dart';
import 'package:evently/home/tabs/home_tab/home_tab.dart';
import 'package:evently/home/tabs/love_tab/love_tab.dart';
import 'package:evently/home/tabs/map_tab/map_tab.dart';
import 'package:evently/home/tabs/profile_tab/profile_tab.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/providers/user_auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/map_tab_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/homeScreen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs = [
    HomeTab(),
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MapTapProvider(),
        )
      ],
      child: MapTab(),
    ),
    LoveTab(),
    ProfileTab()
  ];
  int index = 0;

  @override
  void initState() {
    super.initState();
    if (context.read<UserAuthProvider>().userModel == null &&
        FirebaseAuth.instance.currentUser != null) {
      context.read<UserAuthProvider>().getUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: index, children: tabs),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Theme.of(context).splashColor, width: 5),
        ),
        child: FloatingActionButton(
          heroTag: Text('btn1'),
          onPressed: () {
            Navigator.of(context).pushNamed(CreateEventScreen.routeName);
          },
          shape: CircleBorder(),
          backgroundColor: Theme.of(context).highlightColor,
          splashColor: Theme.of(context).splashColor,
          child: Icon(
            Icons.add_rounded,
            color: Theme.of(context).splashColor,
            size: 40,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 2,
        shape: CircularNotchedRectangle(),
        color: Theme.of(context).highlightColor,
        padding: EdgeInsets.zero,
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          onTap: (value) {
            index = value;
            setState(() {});
          },
          currentIndex: index,
          items: [
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.home),
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Icon(Icons.home_outlined),
                ),
                label: AppLocalizations.of(context)!.home),
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.location_on),
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Icon(Icons.location_on_outlined),
                ),
                label: AppLocalizations.of(context)!.map),
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.favorite),
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Icon(Icons.favorite_border_outlined),
                ),
                label: AppLocalizations.of(context)!.love),
            BottomNavigationBarItem(
                activeIcon: Icon(Icons.person_rounded),
                icon: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Icon(Icons.person_outline_rounded),
                ),
                label: AppLocalizations.of(context)!.profile)
          ],
        ),
      ),
    );
  }
}
