import 'package:evently/common/app_colors.dart';
import 'package:evently/common/custom_text_styles.dart';
import 'package:evently/common/services/firebase_services.dart';
import 'package:evently/common/widgets/categories_slider.dart';
import 'package:evently/common/widgets/custom_main_button.dart';
import 'package:evently/events/screens/pick_location_screen_for_edit_event.dart';
import 'package:evently/events/widgets/custom_text_field.dart';
import 'package:evently/home/screens/home_screen.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/event_data_model.dart';
import 'package:evently/providers/create_event_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

class EditEventScreen extends StatefulWidget {
  static const String routeName = '/EditEventScreen';

  const EditEventScreen({super.key});

  @override
  State<EditEventScreen> createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  bool isDataInitialized = false;

  TextEditingController? titleController;
  TextEditingController? descriptionController;

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  FocusNode titleFocusNode = FocusNode();
  FocusNode descriptionFocusNode = FocusNode();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String state = '';
  String error = '';

  @override
  void initState() {
    super.initState();
    titleFocusNode.addListener(
      () {
        setState(() {});
      },
    );
    descriptionFocusNode.addListener(
      () {
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    EventDataModel eventDataModel =
        ModalRoute.of(context)?.settings.arguments as EventDataModel;

    CreateEventScreenProvider provider =
        Provider.of<CreateEventScreenProvider>(context);

    provider.convertLatLngToAddress(LatLng(
        provider.eventLocation?.latitude ?? eventDataModel.latitude,
        provider.eventLocation?.longitude ?? eventDataModel.longitude));

    if (!isDataInitialized) {
      titleController = TextEditingController(text: eventDataModel.title);
      descriptionController =
          TextEditingController(text: eventDataModel.description);
      selectedDate = eventDataModel.dateTime;
      selectedTime = TimeOfDay(
          hour: eventDataModel.dateTime.hour,
          minute: eventDataModel.dateTime.minute);
      isDataInitialized = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.editEvent),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    eventDataModel.categoryValues.getImage(
                        context.watch<ThemeProvider>().themeMode ==
                            ThemeMode.dark),
                    height: height * 0.24,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              CategoriesSlider(
                isHomeTabCategory: false,
                categoryValues: eventDataModel.categoryValues,
                onSelect: (p0) {
                  eventDataModel.categoryValues = p0;
                  setState(() {});
                },
              ),
              CustomTextField(
                title: AppLocalizations.of(context)!.title,
                hintText: AppLocalizations.of(context)!.eventTitle,
                controller: titleController ?? TextEditingController(),
                prefixIcon: Icon(
                  Icons.edit_rounded,
                  color: titleFocusNode.hasFocus
                      ? AppColors.mainColor
                      : Theme.of(context).shadowColor,
                ),
                focusNode: titleFocusNode,
              ),
              CustomTextField(
                title: AppLocalizations.of(context)!.description,
                hintText: AppLocalizations.of(context)!.eventDescription,
                controller: descriptionController ?? TextEditingController(),
                maxLines: 3,
                focusNode: descriptionFocusNode,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.date_range_outlined,
                      color: Theme.of(context).textTheme.labelMedium!.color,
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    Text(
                      AppLocalizations.of(context)!.eventDate,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () async {
                        await selectDate();
                      },
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Text(
                        DateFormat('dd/MM/yyyy').format(selectedDate!),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: AppColors.mainColor),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.watch_later_outlined,
                    color: Theme.of(context).textTheme.labelMedium!.color,
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  Text(
                    AppLocalizations.of(context)!.eventTime,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: () async {
                      await selectTime();
                    },
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: Text(
                      '${selectedTime!.hour}:${selectedTime!.minute} ${selectedTime!.period.name}',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: AppColors.mainColor),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                AppLocalizations.of(context)!.location,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        PickLocationScreenForEditEvent.routeName,
                        arguments: {
                          'provider': provider,
                          'eventDataModel': eventDataModel
                        });
                  },
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.mainColor),
                        borderRadius: BorderRadius.circular(16)),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(8)),
                          padding: EdgeInsets.all(12),
                          child: Icon(
                            Icons.my_location,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.6,
                          child: Text(
                            '${provider.state}, ${provider.country}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: AppColors.mainColor),
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppColors.mainColor,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: state == 'loading'
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : state == 'error'
                        ? Center(
                            child: Text(error),
                          )
                        : CustomMainButton(
                            onPressed: () {
                              if (formKey.currentState!.validate() &&
                                  selectedDate != null &&
                                  selectedTime != null) {
                                state = 'loading';
                                setState(() {});
                                try {
                                  selectedDate = selectedDate!.copyWith(
                                      hour: selectedTime!.hour,
                                      minute: selectedTime!.minute);
                                  EventDataModel editedEventDataModel =
                                      EventDataModel(
                                    id: eventDataModel.id,
                                    title: titleController?.text.trim() ?? '',
                                    description:
                                        descriptionController?.text.trim() ??
                                            '',
                                    dateTime: selectedDate!,
                                    categoryValues:
                                        eventDataModel.categoryValues,
                                    latitude:
                                        provider.eventLocation?.latitude ??
                                            eventDataModel.latitude,
                                    longitude:
                                        provider.eventLocation?.longitude ??
                                            eventDataModel.longitude,
                                    state:
                                        provider.state ?? eventDataModel.state,
                                    country: provider.country ??
                                        eventDataModel.country,
                                  );
                                  FirebaseServices.editEvent(
                                      editedEventDataModel);
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(
                                      AppLocalizations.of(context)!
                                          .theEventIsEditedSuccessfully,
                                      style: CustomTextStyles.style18w500White,
                                    ),
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 5),
                                    showCloseIcon: true,
                                  ));
                                  state = 'done';
                                  setState(() {});
                                  Navigator.of(context).pushReplacementNamed(
                                      HomeScreen.routeName);
                                } catch (e) {
                                  error = e.toString();
                                  state = 'error';
                                  setState(() {});
                                }
                              } else if (selectedDate == null ||
                                  selectedTime == null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                    AppLocalizations.of(context)!
                                        .theDateOrTimeIsMissing,
                                    style: CustomTextStyles.style18w500White,
                                  ),
                                  backgroundColor: AppColors.red,
                                  duration: Duration(seconds: 5),
                                  showCloseIcon: true,
                                ));
                              }
                            },
                            buttonTitle:
                                AppLocalizations.of(context)!.updateEvent,
                          ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectDate() async {
    final DateTime? pickDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2030));
    if (pickDate != null) {
      selectedDate = pickDate;
    }
    setState(() {});
  }

  Future<void> selectTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      selectedTime = pickedTime;
    }
    setState(() {});
  }
}
