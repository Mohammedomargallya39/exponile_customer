import 'package:exponile_customer/core/util/resources/constants_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/default_button.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../resources/colors_manager.dart';

photosCameraPermissionDialog(context) => showDialog(
    context: context,
    barrierDismissible: false,
    useSafeArea: true,
    builder: (context) {
      return Dialog(
        insetPadding: const EdgeInsets.all(0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width / 1.2,
          height: MediaQuery.of(context).size.height / 2.5,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Please, Open Permission',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                verticalSpace(2.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: DefaultButton(
                          onPressed: () {
                            openAppSettings();
                            Navigator.pop(context);
                          },
                          text: 'Go To Settings',
                      ),
                    ),
                    horizontalSpace(2.w),
                    Expanded(
                      child: DefaultButton(
                          color: ColorsManager.error,
                          onPressed: () => Navigator.pop(context),
                          text: 'Cancel'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
