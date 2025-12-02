import 'package:evently/common/app_colors.dart';
import 'package:evently/common/custom_text_styles.dart';
import 'package:evently/models/category_slider_model.dart';
import 'package:evently/providers/localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesSlider extends StatelessWidget {
  final bool isHomeTabCategory;
  final CategoryValues? categoryValues;
  final void Function(CategoryValues) onSelect;

  const CategoriesSlider(
      {super.key,
      required this.categoryValues,
      required this.onSelect,
      required this.isHomeTabCategory});

  @override
  Widget build(BuildContext context) {
    bool isEnglish =
        context.watch<LocalizationProvider>().appLocalization == 'en';
    return SizedBox(
      height: 50,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            CategorySliderModel currentCategoryModel = isHomeTabCategory
                ? CategorySliderModel.homeTabCategory[index]
                : CategorySliderModel.createEventScreenCategory[index];
            return GestureDetector(
              onTap: () {
                onSelect(currentCategoryModel.categoryValues);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                    color:
                        currentCategoryModel.categoryValues == categoryValues &&
                                isHomeTabCategory
                            ? Theme.of(context).disabledColor
                            : currentCategoryModel.categoryValues ==
                                        categoryValues &&
                                    isHomeTabCategory == false
                                ? AppColors.mainColor
                                : null,
                    borderRadius: BorderRadius.circular(46),
                    border: Border.all(
                        color: isHomeTabCategory
                            ? Theme.of(context).disabledColor
                            : AppColors.mainColor)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      currentCategoryModel.icon,
                      color: currentCategoryModel.categoryValues ==
                                  categoryValues &&
                              isHomeTabCategory
                          ? Theme.of(context).primaryColor
                          : currentCategoryModel.categoryValues ==
                                      categoryValues &&
                                  isHomeTabCategory == false
                              ? Theme.of(context).scaffoldBackgroundColor
                              : isHomeTabCategory
                                  ? Theme.of(context).splashColor
                                  : AppColors.mainColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      currentCategoryModel.title == CategoryValues.all.name
                          ? CategoryValues.all.getName(isEnglish)
                          : currentCategoryModel.title ==
                                  CategoryValues.birthday.name
                              ? CategoryValues.birthday.getName(isEnglish)
                              : currentCategoryModel.title ==
                                      CategoryValues.sport.name
                                  ? CategoryValues.sport.getName(isEnglish)
                                  : currentCategoryModel.title ==
                                          CategoryValues.bookClub.name
                                      ? CategoryValues.bookClub
                                          .getName(isEnglish)
                                      : currentCategoryModel.title ==
                                              CategoryValues.meeting.name
                                          ? CategoryValues.meeting
                                              .getName(isEnglish)
                                          : currentCategoryModel.title ==
                                                  CategoryValues.gaming.name
                                              ? CategoryValues.gaming
                                                  .getName(isEnglish)
                                              : currentCategoryModel.title ==
                                                      CategoryValues.eating.name
                                                  ? CategoryValues.eating
                                                      .getName(isEnglish)
                                                  : currentCategoryModel
                                                              .title ==
                                                          CategoryValues
                                                              .holiday.name
                                                      ? CategoryValues.holiday
                                                          .getName(isEnglish)
                                                      : currentCategoryModel
                                                                  .title ==
                                                              CategoryValues
                                                                  .exhibition
                                                                  .name
                                                          ? CategoryValues
                                                              .exhibition
                                                              .getName(
                                                                  isEnglish)
                                                          : CategoryValues
                                                              .workshop
                                                              .getName(
                                                                  isEnglish),
                      style: CustomTextStyles.style16w500Black.copyWith(
                        color: currentCategoryModel.categoryValues ==
                                    categoryValues &&
                                isHomeTabCategory
                            ? Theme.of(context).primaryColor
                            : currentCategoryModel.categoryValues ==
                                        categoryValues &&
                                    isHomeTabCategory == false
                                ? Theme.of(context).scaffoldBackgroundColor
                                : isHomeTabCategory
                                    ? Theme.of(context).splashColor
                                    : AppColors.mainColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(
                width: 10,
              ),
          itemCount: isHomeTabCategory
              ? CategorySliderModel.homeTabCategory.length
              : CategorySliderModel.createEventScreenCategory.length),
    );
  }
}
