import 'package:evently/common/app_colors.dart';
import 'package:evently/common/custom_text_styles.dart';
import 'package:evently/common/services/firebase_services.dart';
import 'package:evently/events/screens/event_details_screen.dart';
import 'package:evently/models/event_data_model.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventCard extends StatelessWidget {
  final EventDataModel eventDataModel;
  final int index;

  const EventCard(
      {super.key, required this.eventDataModel, required this.index});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed(EventDetailsScreen.routeName, arguments: eventDataModel);
      },
      child: Padding(
        padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: index == 0 ? 16 : 8,
            bottom: index == EventDataModel.dummyData.length - 1 ? 16 : 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            key: UniqueKey(),
            children: [
              Image.asset(
                eventDataModel.categoryValues.getImage(
                    context.watch<ThemeProvider>().themeMode == ThemeMode.dark),
                height: height * 0.26,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 0,
                left: 0,
                child: Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('dd').format(eventDataModel.dateTime),
                          style: CustomTextStyles.style18w700Black.copyWith(
                              color: AppColors.mainColor, fontSize: 20),
                        ),
                        Text(
                          DateFormat('MMM').format(eventDataModel.dateTime),
                          style: CustomTextStyles.style14w700Black
                              .copyWith(color: AppColors.mainColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: width * 0.7,
                          child: Text(
                            eventDataModel.title,
                            style: Theme.of(context).textTheme.titleSmall,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          )),
                      FavButton(eventDataModel: eventDataModel)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FavButton extends StatefulWidget {
  const FavButton({
    super.key,
    required this.eventDataModel,
  });

  final EventDataModel eventDataModel;

  @override
  State<FavButton> createState() => _FavButtonState();
}

class _FavButtonState extends State<FavButton> {
  late bool favValue = widget.eventDataModel.isFavourite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        favValue = !favValue;
        setState(() {});
        FirebaseServices.changeEventFav(widget.eventDataModel, favValue);
      },
      child: Icon(
        favValue ? Icons.favorite : Icons.favorite_border_outlined,
        color: AppColors.mainColor,
      ),
    );
  }
}
