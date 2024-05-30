import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:flutter/material.dart';

import '../resources/constants_manager.dart';

Widget textField({
  required controller,
  required String label
}) {
  return Column(
    children: [
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: label,
          hintStyle: TextStyle(
            fontFamily: 'english',
            fontSize: 14.rSp,
            color: Colors.grey
          ),
        ),
      ),
      verticalSpace(1.h),
    ],
  );
}
