import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/my_icon_button.dart';
import 'package:exponile_customer/features/home/presentation/controller/cubit.dart';
import 'package:exponile_customer/features/home/presentation/controller/state.dart';
import 'package:exponile_customer/features/home/presentation/screens/orders_screen/order_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:number_pagination/number_pagination.dart';
import '../../../../../core/util/cubit/cubit.dart';
import '../../../../../core/util/resources/colors_manager.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/default_text.dart';
import '../../../../../core/util/widgets/progress.dart';
import '../../../../../core/util/widgets/two_option_dialog.dart';
import '../cart/payment_screens/order_receipt_screen.dart';

class OrderList extends StatelessWidget {
  const OrderList({super.key});

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc.get(context);
    HomeCubit homeCubit = HomeCubit.get(context);
    return Directionality(
        textDirection: appBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: BlocConsumer<HomeCubit,HomeState>(
          listener: (context, state) {
            if (state is CancelOrderSuccessState && state.cancelOrderEntity.success ==1) {
              Navigator.pop(context);
              homeCubit.orders(status: homeCubit.selectedStatusKey);
              designToastDialog(
                  context: context,
                  toast: TOAST.success,
                  text: state.cancelOrderEntity.message!);
            }
            if (state is CancelOrderSuccessState && state.cancelOrderEntity.success == 0) {
              Navigator.pop(context);
              designToastDialog(
                  context: context,
                  toast: TOAST.error,
                  text: state.cancelOrderEntity.message!);
            }
            if (state is CancelOrderErrorState) {
              Navigator.pop(context);
              designToastDialog(
                  context: context,
                  toast: TOAST.error,
                  text: state.failure.toString());
            }
            if(state is CancelOrderLoadingState) {
              showDialog(
                context: context,
                builder: (context) {
                  return ProgressDialog(message: appBloc.translationModel!.loading);
                },
              );
            }


            if (state is PaymentOrderDataSuccessState && state.paymentOrderDataEntity.success ==1) {
              Navigator.pop(context);
              navigateTo(context, PayScreen(orderPage:true,getPaymentModel: state.paymentOrderDataEntity,));
              designToastDialog(
                  context: context,
                  toast: TOAST.success,
                  text: state.paymentOrderDataEntity.message!);
            }
            if (state is PaymentOrderDataSuccessState && state.paymentOrderDataEntity.success == 0) {
              Navigator.pop(context);
              designToastDialog(
                  context: context,
                  toast: TOAST.error,
                  text: state.paymentOrderDataEntity.message!);
            }
            if (state is PaymentOrderDataErrorState) {
              Navigator.pop(context);
              designToastDialog(
                  context: context,
                  toast: TOAST.error,
                  text: state.failure.toString());
            }
            if(state is PaymentOrderDataLoadingState) {
              showDialog(
                context: context,
                builder: (context) {
                  return ProgressDialog(message: appBloc.translationModel!.loading);
                },
              );
            }

          },
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: SizedBox(
                height: 85.h,
                child:
                RefreshIndicator(
                  onRefresh: () async{
                    homeCubit.orders(status: null);
                    await Future.delayed(const Duration(seconds: 2));
                  },
                  backgroundColor: Colors.transparent,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child:homeCubit.ordersEntity != null && homeCubit.ordersEntity!.data.orders!.data!.isNotEmpty ?
                    Column(
                      children: [
                        verticalSpace(2.h),
                        AnimationLimiter(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: homeCubit.ordersEntity!.data.orders!.data!.entries.length,
                            itemBuilder: (BuildContext context, int index) {
                              final entry = homeCubit.ordersEntity!.data.orders!.data!.entries.elementAt(index);
                              final indexKey = entry.key;
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 1000),
                                child: ScaleAnimation(
                                  duration: const Duration(milliseconds: 1000),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  scale: 1.5,
                                  child: FadeInAnimation(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5.rSp, vertical: 5.rSp),
                                      child: ExpansionTile(
                                        initiallyExpanded: true,
                                        title: DefaultText(
                                            title: indexKey.toString(),
                                            fontSize: 14.rSp,
                                            fontWeight: FontWeight.bold,
                                            style: Style.extraSmall,
                                        ),
                                        children: [
                                          // SizedBox(
                                          //   height: 40.h,
                                          //   child: ListView.builder(
                                          //     physics: const BouncingScrollPhysics(),
                                          //     scrollDirection: Axis.vertical,
                                          //     shrinkWrap: true,
                                          //     itemCount: cubit.myOrdersModel!.data!.orders!.data![indexKey]!.length,
                                          //     //orders.length,
                                          //       itemBuilder: (context, index) {
                                          //         return Padding(
                                          //           padding: EdgeInsets.all(10.rSp),
                                          //           child: Container(
                                          //             padding: EdgeInsets.all(10.rSp),
                                          //             decoration: BoxDecoration(
                                          //                 boxShadow: [
                                          //                   BoxShadow(
                                          //                     color: Colors.grey.withOpacity(0.1),
                                          //                     offset: const Offset(0, 3), // changes position of shadow
                                          //                   ),
                                          //                 ],
                                          //               borderRadius: BorderRadius.all(Radius.circular(10.rSp))
                                          //             ),
                                          //             child: Column(
                                          //               children: [
                                          //                 Column(
                                          //                   crossAxisAlignment: CrossAxisAlignment.start,
                                          //                   children: [
                                          //                     Row(
                                          //                       children: [
                                          //                         textUtils(
                                          //                             text:
                                          //                             '${localization.orderNo}: ',
                                          //                             fontSize: 14.rSp,
                                          //                             textColor: blackClr,
                                          //                             fontWeight: FontWeight.bold,
                                          //                             underLine: TextDecoration.none
                                          //                         ),
                                          //                         textUtils(
                                          //                             text:
                                          //                             '${cubit.myOrdersModel!.data!.orders!.data![indexKey]![index].orderNumber}',
                                          //                             fontSize: 12.rSp,
                                          //                             textColor: blackClr,
                                          //                             underLine: TextDecoration.none,
                                          //                             textOverflow: TextOverflow.ellipsis,
                                          //                             maxLines: 1
                                          //                         ),
                                          //                       ],
                                          //                     ),
                                          //                     space(height: 1.h),
                                          //                     Row(
                                          //                       children: [
                                          //                         textUtils(
                                          //                             text:
                                          //                             '${localization.status}: ',
                                          //                             fontSize: 14.rSp,
                                          //                             textColor: blackClr,
                                          //                             fontWeight: FontWeight.bold,
                                          //                             underLine: TextDecoration.none
                                          //                         ),
                                          //                         textUtils(
                                          //                             text: cubit.myOrdersModel!.data!.orders!.data![indexKey]![index].status!,                                                                  fontSize: 12.rSp,
                                          //                             textColor: blackClr,
                                          //                             underLine: TextDecoration.none
                                          //                         ),
                                          //                       ],
                                          //                     ),
                                          //                     space(height: 1.h),
                                          //                     Row(
                                          //                       children: [
                                          //                         textUtils(
                                          //                             text:
                                          //                             '${localization.expectedDeliveryTime}: ',
                                          //                             fontSize: 14.rSp,
                                          //                             textColor: blackClr,
                                          //                             fontWeight: FontWeight.bold,
                                          //                             underLine: TextDecoration.none
                                          //                         ),
                                          //                         textUtils(
                                          //                             text: cubit.myOrdersModel!.data!.orders!.data![indexKey]![index].expectedDeliveryTime ?? '1 Month',                                                                  fontSize: 12.rSp,
                                          //                             textColor: blackClr,
                                          //                             underLine: TextDecoration.none
                                          //                         ),
                                          //                       ],
                                          //                     ),
                                          //                     space(height: 1.h),
                                          //                     Row(
                                          //                       children: [
                                          //                         textUtils(
                                          //                             text:
                                          //                             '${localization.financialTransactions}: ',
                                          //                             fontSize: 14.rSp,
                                          //                             textColor: blackClr,
                                          //                             fontWeight: FontWeight.bold,
                                          //                             underLine: TextDecoration.none
                                          //                         ),
                                          //                         textUtils(
                                          //                             text: cubit.myOrdersModel!.data!.orders!.data![indexKey]![index].orderCurrentPaymentStatus!.status!,                                                                  fontSize: 12.rSp,
                                          //                             textColor: blackClr,
                                          //                             underLine: TextDecoration.none
                                          //                         ),
                                          //                       ],
                                          //                     ),
                                          //                     Row(
                                          //                       children: [
                                          //                         textUtils(
                                          //                             text:
                                          //                             '${localization.created_at}: ',
                                          //                             fontSize: 14.rSp,
                                          //                             textColor: blackClr,
                                          //                             fontWeight: FontWeight.bold,
                                          //                             underLine: TextDecoration.none
                                          //                         ),
                                          //                         textUtils(
                                          //                             text: DateFormat('yyyy-MM-dd').format(DateTime.parse(cubit.myOrdersModel!.data!.orders!.data![indexKey]![index].createdAt.toString())).toString(),
                                          //                             fontSize: 12.rSp,
                                          //                             textColor: blackClr,
                                          //                             underLine:
                                          //                             TextDecoration.none),
                                          //                       ],
                                          //                     ),
                                          //                     // space(height: 1.h),
                                          //                     space(height: 1.h),
                                          //                     Row(
                                          //                       children: [
                                          //                         textUtils(
                                          //                             text:
                                          //                             '${localization.total}: ',
                                          //                             fontSize: 14.rSp,
                                          //                             textColor: blackClr,
                                          //                             fontWeight: FontWeight.bold,
                                          //                             underLine: TextDecoration.none
                                          //                         ),
                                          //                         textUtils(
                                          //                             text: '${cubit.myOrdersModel!.data!.orders!.data![indexKey]![index].totalAmount} ${localization.egp}',                                                                  fontSize: 12.rSp,
                                          //                             textColor: blackClr,
                                          //                             underLine: TextDecoration.none
                                          //                         ),
                                          //                       ],
                                          //                     ),
                                          //                   ],
                                          //                 ),
                                          //                 space(
                                          //                     height: 1.h
                                          //                 ),
                                          //                 if(cubit.myOrdersModel!.data!.orders!.data![indexKey]![index].status != 'delivered')
                                          //                   space(height: 3.h),
                                          //                 if(cubit.myOrdersModel!.data!.orders!.data![indexKey]![index].status != 'cancelled')
                                          //                 Align(
                                          //                   alignment: Alignment.center,
                                          //                   child: Center(
                                          //                     child: Container(
                                          //                       padding: EdgeInsets.all(10.rSp),
                                          //                       decoration: BoxDecoration(
                                          //                         borderRadius: BorderRadius.all(Radius.circular(10.rSp)),
                                          //                         color: mainColor
                                          //                       ),
                                          //                       child:textUtils(
                                          //                           text: localization.see_more,
                                          //                           fontSize: 12.rSp,
                                          //                           underLine: TextDecoration.none,
                                          //                           textColor: whiteClr
                                          //                       ),
                                          //                     ),
                                          //                   ),
                                          //                 ),
                                          //                 // orders[index].status ==
                                          //                 //     'cancelled'
                                          //                 //     ? Container():Padding(
                                          //                 //   padding: EdgeInsets.symmetric(
                                          //                 //     horizontal: 5.rSp,
                                          //                 //     vertical: 10.rSp,
                                          //                 //   ),
                                          //                 //   child: Row(
                                          //                 //     mainAxisAlignment: orders[index].paymentMethod.id.toString() ==
                                          //                 //         cubit.myOrdersModel!.data!.fawryId
                                          //                 //         ? MainAxisAlignment
                                          //                 //         .spaceEvenly
                                          //                 //         : MainAxisAlignment
                                          //                 //         .center,
                                          //                 //     crossAxisAlignment:
                                          //                 //     CrossAxisAlignment.center,
                                          //                 //     children: [
                                          //                 //       IconsButton(
                                          //                 //         height: 40.rSp,
                                          //                 //         color: mainColor,
                                          //                 //         text: localization.orderDetails,
                                          //                 //         icon: Icons
                                          //                 //             .add_circle_outline,
                                          //                 //         iconColor: mainColor,
                                          //                 //         onPressed: () {
                                          //                 //           Navigator.push(
                                          //                 //               context,
                                          //                 //               MaterialPageRoute(
                                          //                 //                   builder:
                                          //                 //                       (context) =>
                                          //                 //                       OrderDetailsScreen(
                                          //                 //                         orderNumber:
                                          //                 //                         orders[index].orderNumber,
                                          //                 //                       )));
                                          //                 //         },
                                          //                 //       ),
                                          //                 //       if( orders[index].paymentMethod.id.toString() == cubit.myOrdersModel!.data!.fawryId
                                          //                 //           && orders[index].orderCurrentPaymentStatus.status == 'pending')
                                          //                 //         space(width: 5.rSp),
                                          //                 //       orders[index].paymentMethod.id.toString() == cubit.myOrdersModel!.data!.fawryId
                                          //                 //           && orders[index].orderCurrentPaymentStatus.status == 'pending'
                                          //                 //           ? IconsButton(
                                          //                 //         height: 40.rSp,
                                          //                 //         color:
                                          //                 //         statusBarColor,
                                          //                 //         text: localization.payNow,
                                          //                 //         icon: Icons.money,
                                          //                 //         iconColor:
                                          //                 //         statusBarColor,
                                          //                 //         onPressed: () {
                                          //                 //           Navigator.push(
                                          //                 //               context,
                                          //                 //               MaterialPageRoute(
                                          //                 //                   builder: (context) =>
                                          //                 //                       OrderReceiptScreen(
                                          //                 //                         purchaseNumber: orders[index].purchaseOrderNumber,
                                          //                 //                       )));
                                          //                 //         },
                                          //                 //       )
                                          //                 //           : Container(),
                                          //                 //     ],
                                          //                 //   ),
                                          //                 // )
                                          //                 if(cubit.myOrdersModel!.data!.orders!.data![indexKey]![index].status == 'delivered')
                                          //                 space(height: 3.h),
                                          //                 if(cubit.myOrdersModel!.data!.orders!.data![indexKey]![index].status == 'delivered')
                                          //                 InkWell(
                                          //                   onTap: () {
                                          //                     showOrderRateDialog(
                                          //                       context,
                                          //                       shopNumber: cubit.myOrdersModel!.data!.orders!.data![indexKey]![index].getShop.shop,
                                          //                       orderNumber: cubit.myOrdersModel!.data!.orders!.data![indexKey]![index].id!,
                                          //                     );
                                          //                   },
                                          //                   borderRadius: BorderRadius.all(
                                          //                       Radius.circular(10.rSp)
                                          //                   ),
                                          //                   child: textUtils(
                                          //                       text: localization.rateNow,
                                          //                       fontSize: 14.rSp,
                                          //                       underLine: TextDecoration.none,
                                          //                       fontWeight: FontWeight.bold,
                                          //                       letterSpacing: 5.rSp,
                                          //                       textColor: blackClr
                                          //                   ),
                                          //                 ),
                                          //                 space(height: 3.h),
                                          //                 if(cubit.myOrdersModel!.data!.orders!.data![indexKey]![index].status == 'pending')
                                          //                 InkWell(
                                          //                     onTap: () {
                                          //                       // showOrderRateDialog(
                                          //                       //   context,
                                          //                       //   shopNumber: cubit.myOrdersModel!.data!.orders!.data![indexKey]![index].getShop.shop,
                                          //                       //   orderNumber: cubit.myOrdersModel!.data!.orders!.data![indexKey]![index].id!,
                                          //                       // );
                                          //                       showDialog(
                                          //                           context: context,
                                          //                           builder: (context) {
                                          //                             return TwoOptionsDialog(
                                          //                                 height: 25.h,
                                          //                                 message: localization.sure,
                                          //                                 popButtonText: localization.no,
                                          //                                 colorEdit: errorClr,
                                          //                                 popButtonVoidCallback: ()
                                          //                                 {
                                          //                                     Navigator.pop(context);
                                          //                                 },
                                          //                                pushButtonText: localization.yes,
                                          //                                pushButtonVoidCallback: (){
                                          //                                  cubit.cancelOrder(
                                          //                                      orderNumber: cubit.myOrdersModel!.data!.orders!.data![indexKey]![index].orderNumber!,
                                          //                                      context: context
                                          //                                  );
                                          //                               },
                                          //
                                          //                             );
                                          //                           },
                                          //                       );
                                          //                     },
                                          //                     borderRadius: BorderRadius.all(
                                          //                         Radius.circular(10.rSp)
                                          //                     ),
                                          //                     child: textUtils(
                                          //                         text: localization.cancel,
                                          //                         fontSize: 14.rSp,
                                          //                         underLine: TextDecoration.none,
                                          //                         fontWeight: FontWeight.bold,
                                          //                         letterSpacing: 5.rSp,
                                          //                         textColor: errorClr
                                          //                     ),
                                          //                   ),
                                          //               //  space(height: 2.h),
                                          //               ],
                                          //             ),
                                          //           ),
                                          //         );
                                          //       },
                                          //   ),
                                          // ),
                                          SizedBox(
                                            height: 25.h,
                                            width: 90.w,
                                            child: ListView.builder(
                                              physics: const BouncingScrollPhysics(),
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              itemCount: homeCubit.ordersEntity!.data.orders!.data![indexKey]!.length,
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding:  EdgeInsets.symmetric(horizontal: 1.w),
                                                  child: SizedBox(
                                                    width: 85.w,
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          padding: EdgeInsets.all(10.rSp),
                                                          decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.all(
                                                                  Radius.circular(10.rSp)
                                                              ),
                                                              border: Border.all(
                                                                  width: 1.rSp,
                                                                  color: Colors.grey.withOpacity(0.5)
                                                              )
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              verticalSpace(2.h),
                                                              Container(
                                                                width: double.infinity,
                                                                height: 1.rSp,
                                                                color: Colors.grey.withOpacity(0.1),
                                                              ),
                                                              verticalSpace(2.h),
                                                              Row(
                                                                children: [
                                                                  DefaultText(
                                                                      title: appBloc.translationModel!.orderNumber,
                                                                      fontSize: 12.rSp,
                                                                      style: Style.small,
                                                                      fontWeight: FontWeight.bold
                                                                  ),
                                                                  const Spacer(),
                                                                  DefaultText(
                                                                      title: '${homeCubit.ordersEntity!.data.orders!.data![indexKey]![index].orderNumber}',
                                                                      fontSize: 12.rSp,
                                                                      style: Style.small,
                                                                      fontWeight: FontWeight.w500
                                                                  ),
                                                                ],
                                                              ),
                                                              verticalSpace(2.h),
                                                              Container(
                                                                width: double.infinity,
                                                                height: 1.rSp,
                                                                color: Colors.grey.withOpacity(0.1),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  DefaultText(
                                                                      title: '${appBloc.translationModel!.deliveryTime}: ',
                                                                      fontSize: 12.rSp,
                                                                      style: Style.small,
                                                                      fontWeight: FontWeight.bold
                                                                  ),
                                                                  const Spacer(),
                                                                  DefaultText(
                                                                      title: homeCubit.ordersEntity!.data.orders!.data![indexKey]![index].expectedDeliveryTime ?? '1 Month',
                                                                      fontSize: 12.rSp,
                                                                      style: Style.small,
                                                                      fontWeight: FontWeight.w500
                                                                  ),
                                                                ],
                                                              ),
                                                              verticalSpace(2.h),
                                                              Container(
                                                                width: double.infinity,
                                                                height: 1.rSp,
                                                                color: Colors.grey.withOpacity(0.1),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  DefaultText(
                                                                      title: '${appBloc.translationModel!.financialTransactions}: ',
                                                                      fontSize: 12.rSp,
                                                                      style: Style.small,
                                                                      fontWeight: FontWeight.bold
                                                                  ),
                                                                  const Spacer(),
                                                                  DefaultText(
                                                                      title: homeCubit.ordersEntity!.data.orders!.data![indexKey]![index].orderCurrentPaymentStatus!.status!,
                                                                      fontSize: 12.rSp,
                                                                      style: Style.small,
                                                                      fontWeight: FontWeight.w500
                                                                  ),
                                                                ],
                                                              ),
                                                              verticalSpace(2.h),
                                                              Container(
                                                                width: double.infinity,
                                                                height: 1.rSp,
                                                                color: Colors.grey.withOpacity(0.1),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  if(homeCubit.ordersEntity!.data.orders!.data![indexKey]![index].status == 'pending')
                                                                    Expanded(
                                                                        child: DefaultIconButton(
                                                                          icon: const Icon(
                                                                              Icons.cancel_outlined,
                                                                              color: ColorsManager.error
                                                                          ),
                                                                          onPressed: () {
                                                                            showDialog(
                                                                              context: context,
                                                                              builder: (context) {
                                                                                return TwoOptionsDialog(
                                                                                    message: appBloc.translationModel!.cancel,
                                                                                    popButtonText: appBloc.translationModel!.cancel,
                                                                                    pushButtonText: appBloc.translationModel!.yesOnly,
                                                                                    colorEdit: ColorsManager.error,
                                                                                    pushButtonVoidCallback: ()
                                                                                    {
                                                                                      homeCubit.cancelOrder(
                                                                                          orderNumber: homeCubit.ordersEntity!.data.orders!.data![indexKey]![index].orderNumber!,
                                                                                      );
                                                                                    },
                                                                                    popButtonVoidCallback: (){
                                                                                      Navigator.pop(context);
                                                                                    }
                                                                                );
                                                                              },
                                                                            );
                                                                          },
                                                                        )
                                                                    ),
                                                                  if(homeCubit.ordersEntity!.data.orders!.data![indexKey]![index].orderCurrentPaymentStatus!.status! == 'pending' && homeCubit.ordersEntity!.data.orders!.data![indexKey]![index].status == 'pending' && homeCubit.ordersEntity!.data.orders!.data![indexKey]![index].paymentMethod!.id != 1)
                                                                    Expanded(
                                                                        child: DefaultIconButton(
                                                                          icon: const Icon(
                                                                              Icons.payment_outlined,
                                                                              color: ColorsManager.warning
                                                                          ),
                                                                          onPressed: () {
                                                                            homeCubit.paymentOrderData(
                                                                                poNumber: homeCubit.ordersEntity!.data.orders!.data![indexKey]![index].purchaseOrderNumber!,
                                                                            );
                                                                          },
                                                                        )
                                                                    ),
                                                                  if(homeCubit.ordersEntity!.data.orders!.data![indexKey]![index].status == 'pending')
                                                                    verticalSpace(1.w),
                                                                  if(homeCubit.ordersEntity!.data.orders!.data![indexKey]![index].status != 'cancelled')
                                                                    Expanded(
                                                                        child: DefaultIconButton(
                                                                          icon: const Icon(
                                                                              Icons.remove_red_eye_outlined,
                                                                              color: ColorsManager.mainColor
                                                                          ),
                                                                          onPressed: (){
                                                                            navigateTo(context, OrderDetails(
                                                                                orderNumber: homeCubit.ordersEntity!.data.orders!.data![indexKey]![index].orderNumber!
                                                                            )
                                                                            );
                                                                          },

                                                                        )
                                                                    ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Positioned(
                                                          child: Row(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.symmetric(horizontal: 10.rSp),
                                                                child: DefaultText(
                                                                    title: homeCubit.ordersEntity!.data.orders!.data![indexKey]![index].createdAt.toString(),
                                                                    fontSize: 12.rSp,
                                                                    style: Style.extraSmall,
                                                                    fontWeight: FontWeight.w500
                                                                ),
                                                              ),
                                                              const Spacer(),
                                                              Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.all(Radius.circular(10.rSp)),
                                                                    color:
                                                                    homeCubit.ordersEntity!.data.orders!.data![indexKey]![index].status == 'cancelled'?  ColorsManager.error:
                                                                    homeCubit.ordersEntity!.data.orders!.data![indexKey]![index].status == 'delivered'?  ColorsManager.success:
                                                                    ColorsManager.mainColor.withOpacity(0.7)
                                                                ),
                                                                padding: EdgeInsets.all(5.rSp),
                                                                margin: EdgeInsets.all(5.rSp),
                                                                child: DefaultText(
                                                                    title: homeCubit.ordersEntity!.data.orders!.data![indexKey]![index].status!,
                                                                    fontSize: 12.rSp,
                                                                    style: Style.small,
                                                                    color: ColorsManager.whiteColor,
                                                                    fontWeight: FontWeight.bold
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          //  if(orders[index].status != 'delivered')
                                          //   InkWell(
                                          //     onTap: () {
                                          //       showRateTypeDialog(context);
                                          //     },
                                          //     child: textUtils(
                                          //         text: localization.rateNow,
                                          //         fontSize: 14.rSp,
                                          //         underLine: TextDecoration.none,
                                          //         fontWeight: FontWeight.bold,
                                          //         letterSpacing: 3
                                          //     ),
                                          //   ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        if(homeCubit.ordersEntity!.data.orders!.lastPage! >1)
                        NumberPagination(
                            onPageChanged: (pageNumber){
                              homeCubit.changePageNumber(page: pageNumber);
                              homeCubit.orders(
                                status: homeCubit.selectedStatusKey,
                              );
                            },
                            pageTotal: homeCubit.ordersEntity!.data.orders!.lastPage!,
                            colorPrimary: ColorsManager.mintGreen,
                            colorSub: ColorsManager.warning,
                            threshold: 4,
                            buttonSpacing: 5.rSp,
                            fontSize: 12.rSp,
                            buttonElevation: 5.rSp,
                            buttonRadius: 20.rSp,
                            groupSpacing: 10.rSp,
                            fontFamily: 'splash',
                            pageInit: homeCubit.pageNumber,

                          ),
                        verticalSpace(2.h),
                      ],
                    ) :
                    Center(
                      child: DefaultText(
                          title: appBloc.translationModel!.noData,
                          style: Style.headLarge
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        )
    );
  }
}
