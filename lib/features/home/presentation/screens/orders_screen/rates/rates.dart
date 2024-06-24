import 'package:exponile_customer/features/home/presentation/screens/orders_screen/rates/rate_order_dialog.dart';
import 'package:exponile_customer/features/home/presentation/screens/orders_screen/rates/rate_type_dialog.dart';
import 'package:flutter/material.dart';

showRateTypeDialog(context,{int? orderId,int? productId,int? storeId}) => showDialog(
  context: context,
  //barrierDismissible: false,
  useSafeArea: true,
  builder: (context) => RateDialogWidget(orderId: orderId!,productId: productId!,storeId: storeId!),
);

showOrderRateDialog(context,{required int orderNumber,}) => showDialog(
  context: context,
  //barrierDismissible: false,
  useSafeArea: true,
  builder: (context) => RateOrderDialog(orderNumber: orderNumber),
);

showProductRateDialog(context,{required int orderNumber,required int productId,}) => showDialog(
  context: context,
  //barrierDismissible: false,
  useSafeArea: true,
  builder: (context) => RateOrderDialog(orderNumber: orderNumber,productId:productId),
);

showStoreRateDialog(context,{required int orderNumber,required int storeId}) => showDialog(
  context: context,
  //barrierDismissible: false,
  useSafeArea: true,
  builder: (context) => RateOrderDialog(orderNumber: orderNumber,storeId:storeId),
);