import 'package:evently/common/services/firebase_services.dart';
import 'package:flutter/material.dart';

import '../../../models/event_data_model.dart';
import '../widgets/event_card.dart';

class LoveTab extends StatelessWidget {
  const LoveTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseServices.getFavEventsStream(),
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
          ),
        ],
      ),
    );
  }
}
