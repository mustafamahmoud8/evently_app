import 'package:evently/common/services/firebase_services.dart';
import 'package:evently/models/category_slider_model.dart';
import 'package:evently/providers/home_tab_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../models/event_data_model.dart';
import '../../widgets/event_card.dart';

class EventsListView extends StatelessWidget {
  const EventsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: FirebaseServices.getAllEventsStream(
            categoryValues: context.watch<HomeTabProvider>().selectedCategory !=
                    CategoryValues.all
                ? context.watch<HomeTabProvider>().selectedCategory
                : null),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            List<EventDataModel> data = snapshot.data ?? [];
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: data.length,
              itemBuilder: (context, index) => EventCard(
                eventDataModel: data[index],
                index: index,
              ),
            );
          }
        },
      ),
    );
  }
}
