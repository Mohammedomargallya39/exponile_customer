import 'package:cached_network_image/cached_network_image.dart';
import 'package:exponile_customer/core/util/loading_files/map_loading.dart';
import 'package:exponile_customer/core/util/resources/assets.gen.dart';
import 'package:exponile_customer/core/util/resources/colors_manager.dart';
import 'package:exponile_customer/core/util/resources/constants_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/main_appbar.dart';
import 'package:exponile_customer/core/util/widgets/my_icon_button.dart';
import 'package:exponile_customer/features/home/presentation/screens/orders_screen/rates/rates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import '../../../../../core/util/cubit/cubit.dart';
import '../../../../../core/util/widgets/default_text.dart';
import '../../controller/cubit.dart';
import '../../controller/state.dart';
import 'order_base_details_card.dart';
import 'order_offer_details_card.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key, required this.orderNumber});

  final String orderNumber;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {

  @override
  void initState() {
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.orderDetails(
      orderNumber: widget.orderNumber
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc.get(context);
    HomeCubit homeCubit = HomeCubit.get(context);
    return Directionality(
      textDirection: appBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Scaffold(
            appBar: MainAppBar(
                title: appBloc.translationModel!.orderDetails,
                isBack: true,
                isLang: false
            ),
            body: homeCubit.orderDetailsEntity == null ?
            const MapDetailsLoading():
            SingleChildScrollView(
              child: Column(
                children: [
                  verticalSpace(1.h),
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.rSp, vertical: 5.rSp),
                            child: ExpansionTileCard(
                              baseColor: ColorsManager.lightGrey,
                              expandedColor: ColorsManager.whiteColor,
                              elevation: 2,
                              initiallyExpanded: true,
                              title: DefaultText(
                                  title: homeCubit.orderDetailsEntity!.data!.order!.orderNumber??'',
                                  fontSize: 12.rSp,
                                  fontWeight: FontWeight.bold,
                                  maxLines: 1,
                                  style: Style.extraSmall,
                                  color: ColorsManager.mainColor,
                              ),
                              subtitle: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      DefaultText(
                                          title: homeCubit.orderDetailsEntity!.data!.order!.updatedAt.toString(),
                                          fontSize: 12.rSp,
                                          style: Style.small,
                                          fontWeight: FontWeight.w700,
                                      ),
                                      DefaultText(
                                          title: homeCubit.orderDetailsEntity!.data!.order!.orderCurrentStatus!.status![0].toUpperCase() +
                                              homeCubit.orderDetailsEntity!.data!.order!.orderCurrentStatus!.status!.substring(1),
                                          fontSize: 12.rSp,
                                          fontWeight: FontWeight.bold,
                                          color: homeCubit.orderDetailsEntity!.data!.order!.orderCurrentStatus!.status == 'delivered' ? ColorsManager.success
                                              : homeCubit.orderDetailsEntity!.data!.order!.orderCurrentStatus!.status == 'packing' ||
                                              homeCubit.orderDetailsEntity!.data!.order!.orderCurrentStatus!.status == 'preparing'
                                              ? ColorsManager.warning : homeCubit.orderDetailsEntity!.data!.order!.orderCurrentStatus!.status == 'cancelled' ? ColorsManager.error : ColorsManager.mintGreen,
                                          style: Style.small
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              children:
                              homeCubit.orderDetailsEntity!.data!.order!.orderCurrentStatus!.status == 'cancelled'
                                  ? []
                                  : <Widget>[
                                Divider(
                                  thickness: 1.0.rSp,
                                  height: 1.0.rSp,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 5.rSp, vertical: 10.rSp,),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          verticalSpace(1.h),
                                          ListView.separated(
                                            scrollDirection: Axis.vertical,
                                            separatorBuilder: (context, detailsIndex) {
                                              return verticalSpace(1.h);
                                            },
                                            itemCount: homeCubit.orderDetailsEntity!.data!.order!.orderDetails!.length,
                                            shrinkWrap: true,
                                            physics: const BouncingScrollPhysics(),
                                            itemBuilder: (context,
                                                detailsIndex) {
                                              return Column(
                                                children: [
                                                  homeCubit.orderDetailsEntity!.data!.order!.orderDetails![detailsIndex].itemType == 'product'
                                                      ? OrderDetailsCard(
                                                    itemImage: homeCubit.orderDetailsEntity!.data!.order!.orderDetails![detailsIndex].image ?? '',
                                                    itemName: homeCubit.orderDetailsEntity!.data!.order!.orderDetails![detailsIndex].name ?? '',
                                                    description: homeCubit.orderDetailsEntity!.data!.order!.orderDetails![detailsIndex].getItemProduct != null?
                                                    homeCubit.orderDetailsEntity!.data!.order!.orderDetails![detailsIndex].getItemProduct!.description ?? '' :'',
                                                    itemQty: homeCubit.orderDetailsEntity!.data!.order!.orderDetails![detailsIndex].quantity ?? 0,
                                                    itemF1Name: homeCubit.orderDetailsEntity!.data!.order!.orderDetails![detailsIndex].feature1Name ?? '',
                                                    itemF2Name: homeCubit.orderDetailsEntity!.data!.order!.orderDetails![detailsIndex].feature2Name ?? '',
                                                    itemPrice: homeCubit.orderDetailsEntity!.data!.order!.orderDetails![detailsIndex].price ?? '',
                                                    createAt: homeCubit.orderDetailsEntity!.data!.order!.createdAt.toString(),
                                                    rateOption: homeCubit.orderDetailsEntity!.data!.order!.orderCurrentStatus!.status! == 'delivered'
                                                        ? DefaultIconButton(
                                                      icon: const Icon(Icons.rate_review,color: ColorsManager.mainColor),
                                                      onPressed: (){
                                                        showRateTypeDialog(
                                                            context,
                                                            storeId: int.parse(homeCubit.orderDetailsEntity!.data!.order!.orderDetails![detailsIndex].shop!),
                                                            productId: homeCubit.orderDetailsEntity!.data!.order!.orderDetails![detailsIndex].itemId,
                                                            orderId: homeCubit.orderDetailsEntity!.data!.order!.id!
                                                        );
                                                        //showRateTypeDialog(context);
                                                      },
                                                    )
                                                        :null,
                                                    // returnDays:3,
                                                    // cubit.orderDetailsModel!.data!.order!.orderDetails![detailsIndex].getItemProduct!.getCategory!.returnDays ?? 0,
                                                    // ratingOnTap: () {
                                                    //   showModalBottomSheet(
                                                    //       isScrollControlled: true,
                                                    //       context: context,
                                                    //       builder: (context) {
                                                    //         return StatefulBuilder(builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
                                                    //           return SingleChildScrollView(
                                                    //             child: Padding(
                                                    //               padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                    //               child: Column(
                                                    //                 crossAxisAlignment: CrossAxisAlignment.center,
                                                    //                 children: [
                                                    //                   Container(
                                                    //                     width: double.infinity,
                                                    //                     height: 50.rSp,
                                                    //                     color: mainColor,
                                                    //                     padding: EdgeInsets.symmetric(horizontal: 5.rSp),
                                                    //                     child: Row(
                                                    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    //                       children: [
                                                    //                         textUtils(text: localization.rateOrder, fontSize: 16.rSp, textColor: whiteClr, fontWeight: FontWeight.bold, letterSpacing: 2, underLine: TextDecoration.none),
                                                    //                         GestureDetector(
                                                    //                           onTap: () => Navigator.pop(context),
                                                    //                           child: const Icon(
                                                    //                             Icons.close,
                                                    //                             color: whiteClr,
                                                    //                           ),
                                                    //                         )
                                                    //                       ],
                                                    //                     ),
                                                    //                   ),
                                                    //                   Padding(
                                                    //                     padding: EdgeInsets.symmetric(horizontal: 5.rSp, vertical: 15.rSp),
                                                    //                     child: RatingBar(
                                                    //                       initialRating: 1,
                                                    //                       minRating: 1,
                                                    //                       direction: Axis.horizontal,
                                                    //                       allowHalfRating: true,
                                                    //                       itemCount: 5,
                                                    //                       itemSize: 20.rSp,
                                                    //                       itemPadding: EdgeInsets.symmetric(horizontal: 2.rSp),
                                                    //                       ratingWidget: RatingWidget(
                                                    //                         full: Image.asset('assets/images/ratingbar/star.png'),
                                                    //                         half: Image.asset('assets/images/ratingbar/star_half.png'),
                                                    //                         empty: Image.asset('assets/images/ratingbar/star_border.png'),
                                                    //                       ),
                                                    //                       onRatingUpdate: (rating) {
                                                    //                         if (kDebugMode) {
                                                    //                           print(rating);
                                                    //                         }
                                                    //                         rate = rating.toInt();
                                                    //                         if (kDebugMode) {
                                                    //                           print(rate);
                                                    //                         }
                                                    //                       },
                                                    //                     ),
                                                    //                   ),
                                                    //                   Padding(
                                                    //                     padding: EdgeInsets.symmetric(horizontal: 10.rSp, vertical: 5.rSp),
                                                    //                     child: Container(
                                                    //                       margin: EdgeInsets.symmetric(horizontal: 3.rSp, vertical: 2.rSp),
                                                    //                       width: double.infinity,
                                                    //                       padding: EdgeInsets.symmetric(horizontal: 5.rSp),
                                                    //                       decoration: BoxDecoration(
                                                    //                         border: Border.all(
                                                    //                           color: Colors.black45,
                                                    //                           style: BorderStyle.solid,
                                                    //                           width: 1.0.rSp,
                                                    //                         ),
                                                    //                         borderRadius: BorderRadius.circular(5.rSp),
                                                    //                       ),
                                                    //                       child: DropdownButton(
                                                    //                         hint: Text(localization.select_one),
                                                    //                         // Initial Value
                                                    //                         value: initSelect,
                                                    //                         isExpanded: true,
                                                    //                         underline: Container(),
                                                    //                         // Down Arrow Icon
                                                    //                         icon: const Icon(Icons.keyboard_arrow_down),
                                                    //                         // Array list of items
                                                    //                         items: selects!.map((selected) {
                                                    //                           return DropdownMenuItem(
                                                    //                             value: selected,
                                                    //                             child: Text(selected.substring(2, selected.length)),
                                                    //                           );
                                                    //                         }).toList(),
                                                    //                         // After selecting the desired option,it will
                                                    //                         // change button value to selected value
                                                    //                         onChanged: (newValue) {
                                                    //                           initSelect = newValue.toString();
                                                    //                           selectedId = int.parse(newValue.toString().substring(0, 1));
                                                    //                           log('%%% selected value :  $selectedId %%%%');
                                                    //                           setState(() {});
                                                    //                         },
                                                    //                       ),
                                                    //                     ),
                                                    //                   ),
                                                    //                   Padding(
                                                    //                     padding: EdgeInsets.symmetric(horizontal: 10.rSp, vertical: 5.rSp),
                                                    //                     child: formField(
                                                    //                       controller: reviewController,
                                                    //                       type: TextInputType.text,
                                                    //                       lines: 5,
                                                    //                       validate: (dynamic value) {
                                                    //                         if (value.isEmpty) {
                                                    //                           return localization.rateMinimumLength;
                                                    //                         }
                                                    //                         return null;
                                                    //                       },
                                                    //                       label: localization.putReview,
                                                    //                     ),
                                                    //                   ),
                                                    //                   Padding(
                                                    //                     padding: EdgeInsets.all(5.rSp),
                                                    //                     child: button(
                                                    //                         text: localization.submit_review,
                                                    //                         onPress: () {
                                                    //                           selects!.clear();
                                                    //                           Navigator.pop(context);
                                                    //                           cubit.rateOrder(type: 'product', slug: cubit.orderDetailsModel!.data!.order!.orderDetails![detailsIndex].slug ?? '', rate: rate, orderNumber: int.parse(cubit.orderDetailsModel!.data!.order!.orderNumber ?? ''), quickComment: selectedId, comment: reviewController.text,context: context);
                                                    //                         },
                                                    //                         radius: 5.rSp,
                                                    //                         width: 220.rSp,
                                                    //                         background: mainColor,
                                                    //                         isUpperCase: false),
                                                    //                   ),
                                                    //                 ],
                                                    //               ),
                                                    //             ),
                                                    //           );
                                                    //         });
                                                    //       });
                                                    // },
                                                    // claimOnTap: () {showModalBottomSheet(
                                                    //       isScrollControlled: true,
                                                    //       context: context,
                                                    //       builder: (context) {
                                                    //         return StatefulBuilder(builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
                                                    //           return SingleChildScrollView(
                                                    //             child: Padding(
                                                    //               padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                    //               child: Column(
                                                    //                 crossAxisAlignment: CrossAxisAlignment.center,
                                                    //                 children: [
                                                    //                   Container(
                                                    //                     width: double.infinity,
                                                    //                     height: 50.rSp,
                                                    //                     color: statusBarColor,
                                                    //                     padding: EdgeInsets.symmetric(horizontal: 5.rSp),
                                                    //                     child: Row(
                                                    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    //                       children: [
                                                    //                         textUtils(text: localization.reason, fontSize: 16.rSp, textColor: whiteClr, fontWeight: FontWeight.bold, letterSpacing: 2, underLine: TextDecoration.none),
                                                    //                         GestureDetector(
                                                    //                           onTap: () {
                                                    //                             Navigator.pop(context);
                                                    //                           },
                                                    //                           child: const Icon(
                                                    //                             Icons.close,
                                                    //                             color: whiteClr,
                                                    //                           ),
                                                    //                         )
                                                    //                       ],
                                                    //                     ),
                                                    //                   ),
                                                    //                   Padding(
                                                    //                     padding: EdgeInsets.symmetric(horizontal: 10.rSp, vertical: 10.rSp),
                                                    //                     child: formField(
                                                    //                       controller: claimController,
                                                    //                       type: TextInputType.text,
                                                    //                       lines: 5,
                                                    //                       validate: (dynamic value) {
                                                    //                         if (value.isEmpty) {
                                                    //                           return localization.rateMinimumLength;
                                                    //                         }
                                                    //                         return null;
                                                    //                       },
                                                    //                       label: localization.reasonOfClaim,
                                                    //                     ),
                                                    //                   ),
                                                    //                   Row(
                                                    //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                    //                     children: [
                                                    //                       Padding(
                                                    //                         padding: EdgeInsets.all(5.rSp),
                                                    //                         child: button(
                                                    //                             text: localization.chooseFile,
                                                    //                             onPress: () async {
                                                    //                               FilePickerResult? result = await FilePicker.platform.pickFiles();
                                                    //
                                                    //                               if (result != null) {
                                                    //                                 setState(() {
                                                    //                                   file = File(result.files.single.path!);
                                                    //                                 });
                                                    //                               } else {
                                                    //                                 // User canceled the picker
                                                    //                               }
                                                    //                             },
                                                    //                             radius: 5.rSp,
                                                    //                             width: 180.rSp,
                                                    //                             background: mainColor,
                                                    //                             isUpperCase: false),
                                                    //                       ),
                                                    //                       file == null
                                                    //                           ? textUtils(text: localization.noFileChosen, fontSize: 11, underLine: TextDecoration.underline, textColor: blackClr, fontWeight: FontWeight.normal)
                                                    //                           : textUtils(
                                                    //                               text: file!.path.substring(file!.path.length - 20, file!.path.length),
                                                    //                               fontSize: 11.rSp,
                                                    //                               underLine: TextDecoration.underline,
                                                    //                               textColor: blackClr,
                                                    //                               fontWeight: FontWeight.normal,
                                                    //                             ),
                                                    //                     ],
                                                    //                   ),
                                                    //                   Padding(
                                                    //                     padding: EdgeInsets.all(5.rSp),
                                                    //                     child: button(
                                                    //                         text: localization.send,
                                                    //                         onPress: () {
                                                    //                           Navigator.pop(context);
                                                    //                           cubit.claimOrder(
                                                    //                             context: context,
                                                    //                             type: cubit.orderDetailsModel!.data!.order!.orderDetails![detailsIndex].itemType == 'product' ? 'product' : 'offer',
                                                    //                             itemId: cubit.orderDetailsModel!.data!.order!.orderDetails![detailsIndex].id ?? 0,
                                                    //                             claimReason: claimController.text,
                                                    //                             attachment: file,
                                                    //                           );
                                                    //                         },
                                                    //                         radius: 5.rSp,
                                                    //                         width: 220.rSp,
                                                    //                         background: mainColor,
                                                    //                         isUpperCase: false),
                                                    //                   ),
                                                    //                 ],
                                                    //               ),
                                                    //             ),
                                                    //           );
                                                    //         });
                                                    //       });
                                                    // },
                                                    // removeOnTap: () {
                                                    //   cubit.removeItemOrder(
                                                    //     context: context,
                                                    //     orderNumber: cubit.orderDetailsModel!.data!.order!.orderNumber ?? '',
                                                    //     item: cubit.orderDetailsModel!.data!.order!.orderDetails![detailsIndex].id ?? 0,
                                                    //   );
                                                    // },
                                                  )
                                                      : OrderDetailsOfferCard(
                                                    offerProductsWidget: ListView.builder(
                                                        shrinkWrap: true,
                                                        physics: const NeverScrollableScrollPhysics(),
                                                        scrollDirection: Axis.vertical,
                                                        itemCount: homeCubit.orderDetailsEntity!.data!.order!.orderDetails![detailsIndex].orderOfferDetails!.length,
                                                        itemBuilder: (BuildContext context, int offerDetailsIndex) {
                                                          return Padding(
                                                            padding: EdgeInsets.all(5.rSp),
                                                            child: Card(
                                                              elevation: 5,
                                                              shape: RoundedRectangleBorder
                                                                (
                                                                  borderRadius: BorderRadius.circular(15.rSp),
                                                                  side: BorderSide(
                                                                      color: ColorsManager.mainColor.withOpacity(0.7),
                                                                      width: 1.rSp
                                                                  )
                                                              ),
                                                              child: Row(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  SizedBox(
                                                                    height: MediaQuery.of(context).size.height / 12,
                                                                    width: MediaQuery.of(context).size.width / 6,
                                                                    child: CachedNetworkImage(
                                                                      imageUrl:  homeCubit.orderDetailsEntity!.data!.order!.orderDetails![detailsIndex].orderOfferDetails![offerDetailsIndex].image! ,
                                                                      imageBuilder: (context, imageProvider) => Container(
                                                                        decoration: BoxDecoration(
                                                                          image: DecorationImage(
                                                                              image: imageProvider, fit: BoxFit.contain),
                                                                        ),
                                                                      ),
                                                                      errorWidget: (context, url, error) => Container(
                                                                          height: MediaQuery.of(context).size.height / 12,
                                                                          width: MediaQuery.of(context).size.width / 6,
                                                                          decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.only(
                                                                                topLeft: Radius.circular(20.rSp),
                                                                                topRight: Radius.circular(20.rSp)),
                                                                          ),
                                                                          child: svgImage(path: Assets.images.svg.noImage)
                                                                      ),
                                                                      placeholder: (context, url) => Container(
                                                                        color: Colors.black.withOpacity(0.5),
                                                                      ),
                                                                      fit: BoxFit.contain,
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child: Padding(
                                                                      padding: EdgeInsets.only(left: 10.rSp, top: 10.rSp, bottom: 10.rSp),
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          DefaultText(
                                                                              title: homeCubit.orderDetailsEntity!.data!.order!.orderDetails![detailsIndex].orderOfferDetails![offerDetailsIndex].name ?? '',
                                                                              fontSize: 12.rSp,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: ColorsManager.success,
                                                                              style: Style.small,
                                                                          ),
                                                                          verticalSpace(1.h),
                                                                          DefaultText(
                                                                              title: '${homeCubit.orderDetailsEntity!.data!.order!.orderDetails![detailsIndex].orderOfferDetails![offerDetailsIndex].price} ${appBloc.translationModel!.currency}',
                                                                              fontSize: 14.rSp,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: ColorsManager.mainColor,
                                                                              style: Style.small,
                                                                          ),
                                                                          // space(height: 10.rSp),
                                                                          // Row(
                                                                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                          //   children: [
                                                                          //     cubit.orderDetailsModel!.data!.order!.orderCurrentStatus!.status == 'delivered'
                                                                          //         //&& cubit.orderDetailsModel!.data.order.orderDetails[detailsIndex]!.rateBefore == false
                                                                          //         ? button(
                                                                          //             text: localization.rating,
                                                                          //             onPress: () {
                                                                          //               showModalBottomSheet(
                                                                          //                   isScrollControlled: true,
                                                                          //                   context: context,
                                                                          //                   builder: (context) {
                                                                          //                     return StatefulBuilder(builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
                                                                          //                       return SingleChildScrollView(
                                                                          //                         child: Padding(
                                                                          //                           padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                          //                           child: Column(
                                                                          //                             crossAxisAlignment: CrossAxisAlignment.center,
                                                                          //                             children: [
                                                                          //                               Container(
                                                                          //                                 width: double.infinity,
                                                                          //                                 height: 50.rSp,
                                                                          //                                 color: mainColor,
                                                                          //                                 padding: EdgeInsets.symmetric(horizontal: 5.rSp),
                                                                          //                                 child: Row(
                                                                          //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          //                                   children: [
                                                                          //                                     textUtils(text: localization.rateProduct, fontSize: 16.rSp, textColor: whiteClr, fontWeight: FontWeight.bold, letterSpacing: 2, underLine: TextDecoration.none),
                                                                          //                                     GestureDetector(
                                                                          //                                       onTap: () => Navigator.pop(context),
                                                                          //                                       child: const Icon(
                                                                          //                                         Icons.close,
                                                                          //                                         color: whiteClr,
                                                                          //                                       ),
                                                                          //                                     )
                                                                          //                                   ],
                                                                          //                                 ),
                                                                          //                               ),
                                                                          //                               Padding(
                                                                          //                                 padding: EdgeInsets.symmetric(horizontal: 5.rSp, vertical: 15.rSp),
                                                                          //                                 child: RatingBar(
                                                                          //                                   initialRating: 1,
                                                                          //                                   minRating: 1,
                                                                          //                                   direction: Axis.horizontal,
                                                                          //                                   allowHalfRating: true,
                                                                          //                                   itemCount: 5,
                                                                          //                                   itemSize: 20.rSp,
                                                                          //                                   itemPadding: EdgeInsets.symmetric(horizontal: 2.rSp),
                                                                          //                                   ratingWidget: RatingWidget(
                                                                          //                                     full: Image.asset('assets/images/ratingbar/star.png'),
                                                                          //                                     half: Image.asset('assets/images/ratingbar/star_half.png'),
                                                                          //                                     empty: Image.asset('assets/images/ratingbar/star_border.png'),
                                                                          //                                   ),
                                                                          //                                   onRatingUpdate: (rating) {
                                                                          //                                     if (kDebugMode) {
                                                                          //                                       print(rating);
                                                                          //                                     }
                                                                          //                                     rate = rating.toInt();
                                                                          //                                     if (kDebugMode) {
                                                                          //                                       print(rate);
                                                                          //                                     }
                                                                          //                                   },
                                                                          //                                 ),
                                                                          //                               ),
                                                                          //                               Padding(
                                                                          //                                 padding: EdgeInsets.symmetric(horizontal: 10.rSp, vertical: 5.rSp),
                                                                          //                                 child: Container(
                                                                          //                                   margin: EdgeInsets.symmetric(horizontal: 3.rSp, vertical: 2.rSp),
                                                                          //                                   width: double.infinity,
                                                                          //                                   padding: EdgeInsets.symmetric(horizontal: 5.rSp),
                                                                          //                                   decoration: BoxDecoration(
                                                                          //                                     border: Border.all(
                                                                          //                                       color: Colors.black45,
                                                                          //                                       style: BorderStyle.solid,
                                                                          //                                       width: 1.0.rSp,
                                                                          //                                     ),
                                                                          //                                     borderRadius: BorderRadius.circular(5.rSp),
                                                                          //                                   ),
                                                                          //                                   child: DropdownButton(
                                                                          //                                     hint: Text(localization.selectItem),
                                                                          //                                     // Initial Value
                                                                          //                                     value: initSelect,
                                                                          //                                     isExpanded: true,
                                                                          //                                     underline: Container(),
                                                                          //                                     // Down Arrow Icon
                                                                          //                                     icon: const Icon(Icons.keyboard_arrow_down),
                                                                          //                                     // Array list of items
                                                                          //                                     items: selects!.map((selected) {
                                                                          //                                       return DropdownMenuItem(
                                                                          //                                         value: selected,
                                                                          //                                         child: Text(selected.substring(2, selected.length)),
                                                                          //                                       );
                                                                          //                                     }).toList(),
                                                                          //                                     // After selecting the desired option,it will
                                                                          //                                     // change button value to selected value
                                                                          //                                     onChanged: (newValue) {
                                                                          //                                       initSelect = newValue.toString();
                                                                          //                                       selectedId = int.parse(newValue.toString().substring(0, 1));
                                                                          //                                       log('%%% selected value :  $selectedId %%%%');
                                                                          //                                       setState(() {});
                                                                          //                                     },
                                                                          //                                   ),
                                                                          //                                 ),
                                                                          //                               ),
                                                                          //                               Padding(
                                                                          //                                 padding: EdgeInsets.symmetric(horizontal: 10.rSp, vertical: 5.rSp),
                                                                          //                                 child: formField(
                                                                          //                                   controller: reviewController,
                                                                          //                                   type: TextInputType.text,
                                                                          //                                   lines: 5,
                                                                          //                                   validate: (dynamic value) {
                                                                          //                                     if (value.isEmpty) {
                                                                          //                                       return localization.rateMinimumLength;
                                                                          //                                     }
                                                                          //                                     return null;
                                                                          //                                   },
                                                                          //                                   label: localization.putReview,
                                                                          //                                 ),
                                                                          //                               ),
                                                                          //                               Padding(
                                                                          //                                 padding: EdgeInsets.all(5.rSp),
                                                                          //                                 child: button(
                                                                          //                                     text: localization.submit_review,
                                                                          //                                     onPress: () {
                                                                          //                                       selects!.clear();
                                                                          //                                       Navigator.pop(context);
                                                                          //                                       cubit.rateOrder(
                                                                          //                                         context: context,
                                                                          //                                         type: localization.product,
                                                                          //                                         slug: cubit.orderDetailsModel!.data!.order!.orderDetails![detailsIndex].orderOfferDetails![offerDetailsIndex].getProduct!.slug ?? '',
                                                                          //                                         rate: rate,
                                                                          //                                         orderNumber: int.parse(cubit.orderDetailsModel!.data!.order!.orderNumber ?? ''),
                                                                          //                                         quickComment: selectedId,
                                                                          //                                         comment: reviewController.text,
                                                                          //                                       );
                                                                          //                                     },
                                                                          //                                     radius: 5.rSp,
                                                                          //                                     width: 220.rSp,
                                                                          //                                     background: mainColor,
                                                                          //                                     isUpperCase: false),
                                                                          //                               ),
                                                                          //                             ],
                                                                          //                           ),
                                                                          //                         ),
                                                                          //                       );
                                                                          //                     });
                                                                          //                   });
                                                                          //             },
                                                                          //             radius: 5.rSp,
                                                                          //             width: 100.rSp,
                                                                          //             isUpperCase: false,
                                                                          //           )
                                                                          //         : Container(),
                                                                          //     cubit.orderDetailsModel!.data!.order!.orderCurrentStatus!.status == 'pending'
                                                                          //         ? button(
                                                                          //             text: localization.remove,
                                                                          //             onPress: () {
                                                                          //               cubit.removeItemOrder(
                                                                          //                 context: context,
                                                                          //                 orderNumber: cubit.orderDetailsModel!.data!.order!.orderNumber ?? '',
                                                                          //                 item: cubit.orderDetailsModel!.data!.order!.orderDetails![detailsIndex].orderOfferDetails![offerDetailsIndex].id ?? 0,
                                                                          //               );
                                                                          //             },
                                                                          //             radius: 5.rSp,
                                                                          //             width: 100.rSp,
                                                                          //             isUpperCase: false,
                                                                          //           )
                                                                          //         : Container(),
                                                                          //     space(height: 10.rSp),
                                                                          //   ],
                                                                          // ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        }),
                                                    rateOption: homeCubit.orderDetailsEntity!.data!.order!.orderCurrentStatus!.status! == 'delivered'
                                                        ? DefaultIconButton(
                                                      icon: const Icon(Icons.rate_review,color: ColorsManager.mainColor),
                                                      onPressed: (){
                                                        showRateTypeDialog(
                                                            context,
                                                            storeId: int.parse(homeCubit.orderDetailsEntity!.data!.order!.orderDetails![detailsIndex].shop!),
                                                            productId: homeCubit.orderDetailsEntity!.data!.order!.orderDetails![detailsIndex].itemId,
                                                            orderId: homeCubit.orderDetailsEntity!.data!.order!.id!
                                                        );
                                                      },
                                                    )
                                                        :null,
                                                    description: homeCubit.orderDetailsEntity!.data!.order!.orderDetails![detailsIndex].orderOfferDetails![0].getProduct!.description ?? '',
                                                    itemImage: homeCubit.orderDetailsEntity!.data!.order!.orderDetails![detailsIndex].image ?? '',
                                                    itemName: homeCubit.orderDetailsEntity!.data!.order!.orderDetails![detailsIndex].name ?? '',
                                                    itemQty: homeCubit.orderDetailsEntity!.data!.order!.orderDetails![detailsIndex].quantity ?? 0,
                                                    itemPrice: homeCubit.orderDetailsEntity!.data!.order!.orderDetails![detailsIndex].price ?? '',
                                                    status: homeCubit.orderDetailsEntity!.data!.order!.orderCurrentStatus!.status ?? '',
                                                    createdAt: homeCubit.orderDetailsEntity!.data!.order!.createdAt.toString(),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                          verticalSpace(1.h),
                                          Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                verticalSpace(1.h),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: ColorsManager.darkColor,
                                                          width: 1.rSp
                                                      ),
                                                      borderRadius: BorderRadius.all(Radius.circular(10.rSp))
                                                  ),
                                                  padding: EdgeInsets.all(10.rw),
                                                  margin: EdgeInsets.all(10.rSp),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          //   space(width: 1.w),
                                                          const Icon(Icons.my_location,color: ColorsManager.mainColor),
                                                          Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                                              child: DefaultText(
                                                                  title: '${appBloc.translationModel!.location} :',
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.bold,
                                                                  color: ColorsManager.success,
                                                                  style: Style.extraSmall
                                                              ),
                                                            ),
                                                          ),

                                                          //  space(width: 1.w),
                                                          Expanded(
                                                            flex: 2,
                                                            child: Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                                              child: DefaultText(
                                                                title: '${homeCubit.orderDetailsEntity!.data!.order!.userAddress!.governorateName}, ${homeCubit.orderDetailsEntity!.data!.order!.userAddress!.areaName}, ${homeCubit.orderDetailsEntity!.data!.order!.userAddress!.streetName}, ${homeCubit.orderDetailsEntity!.data!.order!.userAddress!.buildingName}',
                                                                fontSize: 14.rSp,
                                                                fontWeight: FontWeight.bold,
                                                                color: ColorsManager.success,
                                                                style: Style.small,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      verticalSpace(2.h),
                                                      Container(
                                                        height: 1.rSp,
                                                        width: double.infinity,
                                                        color: ColorsManager.black.withOpacity(0.1),
                                                      ),
                                                      verticalSpace(2.h),
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          //space(width: 1.w),
                                                          const Icon(Icons.payment,color: ColorsManager.mainColor),
                                                          Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                                              child: DefaultText(
                                                                  title: '${appBloc.translationModel!.paymentMethod} :',
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.bold,
                                                                  color: ColorsManager.success,
                                                                  style: Style.extraSmall
                                                              ),
                                                            ),
                                                          ),
                                                          //space(width: 1.w),
                                                          Expanded(
                                                            //flex: 2,
                                                            child: Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                                              child: DefaultText(
                                                                  title: '${homeCubit.orderDetailsEntity!.data!.order!.paymentMethod!.name} ',
                                                                  fontSize: 14,
                                                                  fontWeight: FontWeight.bold,
                                                                  color: ColorsManager.success,
                                                                  style: Style.small
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                verticalSpace(1.h),
                                              ]),
                                          Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                verticalSpace(0.5.h),
                                                Container(
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: ColorsManager.darkGrey,
                                                          width: 1.rSp
                                                      ),
                                                      borderRadius: BorderRadius.all(Radius.circular(10.rSp))
                                                  ),
                                                  padding: EdgeInsets.all(10.rw),
                                                  margin: EdgeInsets.all(10.rSp),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                                            child: DefaultText(
                                                                title: appBloc.translationModel!.total,
                                                                fontSize: 14.rSp,
                                                                fontWeight: FontWeight.bold,
                                                                color: ColorsManager.success,
                                                                style: Style.small
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                                            child: DefaultText(
                                                                title: '${homeCubit.orderDetailsEntity!.data!.order!.subTotal ?? 0.0} ${appBloc.translationModel!.currency}',
                                                                fontSize: 14.rSp,
                                                                fontWeight: FontWeight.bold,
                                                                color: ColorsManager.success,
                                                                style: Style.small
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                                            child: DefaultText(
                                                                title: appBloc.translationModel!.discountValue,
                                                                fontSize: 14.rSp,
                                                                fontWeight: FontWeight.bold,
                                                                color: ColorsManager.success,
                                                                style: Style.small
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                                            child: DefaultText(
                                                                title: '${homeCubit.orderDetailsEntity!.data!.order!.discountValue ?? 0.0} ${appBloc.translationModel!.currency}',
                                                                fontSize: 14.rSp,
                                                                fontWeight: FontWeight.bold,
                                                                color: ColorsManager.success,
                                                                style: Style.small
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                                            child: DefaultText(
                                                                title: appBloc.translationModel!.promoCode,
                                                                fontSize: 14.rSp,
                                                                fontWeight: FontWeight.bold,
                                                                color: ColorsManager.success,
                                                                style: Style.small
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                                            child: DefaultText(
                                                                title: '${homeCubit.orderDetailsEntity!.data!.order!.promoAmount ?? 0.0} ${appBloc.translationModel!.currency}',
                                                                fontSize: 14.rSp,
                                                                fontWeight: FontWeight.bold,
                                                                color: ColorsManager.success,
                                                                style: Style.small
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                                            child: DefaultText(
                                                                title: appBloc.translationModel!.deliveryFees,
                                                                fontSize: 14.rSp,
                                                                fontWeight: FontWeight.bold,
                                                                color: ColorsManager.success,
                                                                style: Style.small
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                                            child: DefaultText(
                                                                title: '${homeCubit.orderDetailsEntity!.data!.order!.shippingAmount ?? 0.0} ${appBloc.translationModel!.currency}',
                                                                fontSize: 14.rSp,
                                                                fontWeight: FontWeight.bold,
                                                                color: ColorsManager.success,
                                                                style: Style.small
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      verticalSpace(1.h),
                                                      Container(
                                                        width: double.infinity,
                                                        height: 0.02.h,
                                                        color: ColorsManager.black,
                                                      ),
                                                      verticalSpace(1.h),
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(
                                                                horizontal: 10),
                                                            child: DefaultText(
                                                                title: appBloc.translationModel!.totalPayment,
                                                                fontSize: 14.rSp,
                                                                fontWeight: FontWeight.bold,
                                                                color: ColorsManager.success,
                                                                style: Style.small
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.symmetric(
                                                                horizontal: 10),
                                                            child: DefaultText(
                                                                title: '${homeCubit.orderDetailsEntity!.data!.order!.totalAmount ?? 0.0} ${appBloc.translationModel!.currency}',
                                                                fontSize: 14.rSp,
                                                                fontWeight: FontWeight.bold,
                                                                color: ColorsManager.success,
                                                                style: Style.small
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                verticalSpace(2.h),
                                              ]),
                                          if(homeCubit.orderDetailsEntity!.data!.order!.orderCurrentStatus!.status! == 'delivered')
                                            DefaultIconButton(
                                              icon: const Icon(Icons.rate_review,color: ColorsManager.mainColor),
                                              onPressed: (){
                                                showOrderRateDialog(
                                                  context,
                                                  orderNumber: homeCubit.orderDetailsEntity!.data!.order!.id!,
                                                );
                                                //showRateTypeDialog(context);
                                              },
                                            ),
                                        ],
                                      )),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),

          );
        },
      ),
    );
  }
}
