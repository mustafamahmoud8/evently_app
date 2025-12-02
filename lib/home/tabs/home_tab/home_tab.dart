import 'package:evently/home/tabs/home_tab/widgets/events_list_view.dart';
import 'package:evently/home/tabs/home_tab/widgets/home_tab_header.dart';
import 'package:evently/providers/home_tab_provider.dart';
import 'package:evently/providers/map_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeTabProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => MapTapProvider(),
        ),
      ],
      child: Column(
        children: [
          HomeTabHeader(),
          EventsListView(),
        ],
      ),
    );
  }
}
