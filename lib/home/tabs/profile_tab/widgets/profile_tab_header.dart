import 'package:evently/common/app_assets.dart';
import 'package:evently/common/app_colors.dart';
import 'package:evently/common/custom_text_styles.dart';
import 'package:evently/providers/user_auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTabHeader extends StatelessWidget {
  const ProfileTabHeader({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(64))),
      child: SafeArea(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(1000),
                      bottomLeft: Radius.circular(1000),
                      bottomRight: Radius.circular(1000)),
                  child:
                      FirebaseAuth.instance.currentUser?.photoURL?.isNotEmpty ??
                              false
                          ? Image.network(
                              FirebaseAuth.instance.currentUser?.photoURL ?? '')
                          : Image.asset(
                              AppImages.routeImage,
                              width: width * 0.31,
                              height: height * 0.14,
                            )),
            ),
            SizedBox(
              width: width * 0.60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.watch<UserAuthProvider>().userModel?.name ?? 'User',
                    style: CustomTextStyles.style18w700Black.copyWith(
                        color: Theme.of(context).splashColor, fontSize: 24),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    context.watch<UserAuthProvider>().userModel?.email ?? '',
                    style: CustomTextStyles.style16w500Black
                        .copyWith(color: Theme.of(context).splashColor),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
