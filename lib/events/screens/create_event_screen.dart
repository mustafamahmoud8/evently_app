import 'package:evently/common/app_colors.dart';
import 'package:evently/common/custom_text_styles.dart';
import 'package:evently/common/services/firebase_services.dart';
import 'package:evently/common/widgets/categories_slider.dart';
import 'package:evently/common/widgets/custom_main_button.dart';
import 'package:evently/events/screens/pick_location_screen.dart';
import 'package:evently/events/widgets/custom_text_field.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/category_slider_model.dart';
import 'package:evently/models/event_data_model.dart';
import 'package:evently/providers/create_event_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/theme_provider.dart';

class CreateEventScreen extends StatefulWidget {
  static const String routeName = '/CreateEventScreen';

  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  CategoryValues selectedId =
      CategorySliderModel.createEventScreenCategory.first.categoryValues;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

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
    CreateEventScreenProvider provider =
        Provider.of<CreateEventScreenProvider>(context);
    provider.convertLatLngToAddress(provider.eventLocation ??
        LatLng(provider.locationData?.latitude ?? 0,
            provider.locationData?.longitude ?? 0));
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.createEvent),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer<CreateEventScreenProvider>(
            builder: (context, provider, child) {
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        selectedId.getImage(
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
                    categoryValues: selectedId,
                    onSelect: (p0) {
                      selectedId = p0;
                      setState(() {});
                    },
                  ),
                  CustomTextField(
                    title: AppLocalizations.of(context)!.title,
                    hintText: AppLocalizations.of(context)!.eventTitle,
                    controller: titleController,
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
                    controller: descriptionController,
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
                          onPressed: () {
                            selectDate();
                          },
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                          child: Text(
                            selectedDate == null
                                ? AppLocalizations.of(context)!.chooseDate
                                : DateFormat('dd/MM/yyyy')
                                    .format(selectedDate!),
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
                        onPressed: () {
                          selectTime();
                        },
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        child: Text(
                          selectedTime == null
                              ? AppLocalizations.of(context)!.chooseTime
                              : '${selectedTime!.hour}:${selectedTime!.minute} ${selectedTime!.period.name}',
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
                            PickLocationScreen.routeName,
                            arguments: provider);
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
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Text(
                                provider.eventLocation == null
                                    ? AppLocalizations.of(context)!
                                        .chooseEventLocation
                                    : '${provider.state}, ${provider.country}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: AppColors.mainColor),
                              ),
                            ),
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
                                onPressed: () async {
                                  if (formKey.currentState!.validate() &&
                                      selectedDate != null &&
                                      selectedTime != null &&
                                      provider.eventLocation != null) {
                                    state = 'loading';
                                    setState(() {});
                                    try {
                                      selectedDate = selectedDate!.copyWith(
                                          hour: selectedTime!.hour,
                                          minute: selectedTime!.minute);
                                      EventDataModel eventDataModel =
                                          EventDataModel(
                                              title: titleController.text
                                                  .trim(),
                                              description: descriptionController
                                                  .text
                                                  .trim(),
                                              dateTime: selectedDate!,
                                              categoryValues: selectedId,
                                              latitude: provider.eventLocation
                                                      ?.latitude ??
                                                  0,
                                              longitude: provider.eventLocation
                                                      ?.longitude ??
                                                  0,
                                              state: provider.state ?? '',
                                              country: provider.country ?? '');
                                      await FirebaseServices.addNewEvent(
                                          eventDataModel);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text(
                                          AppLocalizations.of(context)!
                                              .theEventIsAddedSuccessfully,
                                          style:
                                              CustomTextStyles.style18w500White,
                                        ),
                                        backgroundColor: Colors.green,
                                        duration: Duration(seconds: 5),
                                        showCloseIcon: true,
                                      ));
                                      state = 'done';
                                      setState(() {});
                                      Navigator.of(context).pop();
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
                                        style:
                                            CustomTextStyles.style18w500White,
                                      ),
                                      backgroundColor: AppColors.red,
                                      duration: Duration(seconds: 5),
                                      showCloseIcon: true,
                                    ));
                                  }
                                  if (provider.eventLocation == null) {
                                    Fluttertoast.showToast(
                                      msg: 'Choose the location of the event',
                                      backgroundColor: AppColors.red,
                                      fontSize: 20,
                                      textColor: Colors.white,
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.TOP,
                                    );
                                  }
                                },
                                buttonTitle:
                                    AppLocalizations.of(context)!.addEvent,
                              ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> selectDate() async {
    final DateTime? pickDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
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
