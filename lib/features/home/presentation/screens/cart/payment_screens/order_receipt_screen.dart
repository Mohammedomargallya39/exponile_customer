import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:exponile_customer/core/util/cubit/cubit.dart';
import 'package:exponile_customer/core/util/resources/assets.gen.dart';
import 'package:exponile_customer/core/util/resources/colors_manager.dart';
import 'package:exponile_customer/core/util/resources/constants_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/default_button.dart';
import 'package:exponile_customer/core/util/widgets/main_appbar.dart';
import 'package:exponile_customer/core/util/widgets/progress.dart';
import 'package:exponile_customer/features/home/domain/entities/payment_order_data_entity.dart';
import 'package:exponile_customer/features/home/presentation/controller/cubit.dart';
import 'package:exponile_customer/features/home/presentation/controller/state.dart';
import 'package:fawry_sdk/fawry_sdk.dart';
import 'package:fawry_sdk/model/bill_item.dart';
import 'package:fawry_sdk/model/response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../../../../../core/util/widgets/default_text.dart';
import '../../../../data/models/fawry_response.dart';
import '../../../../domain/entities/checkout_entity.dart';
import '../../main_layout/main_layout.dart';
import '../../orders_screen/order_base_details_card.dart';
import '../../orders_screen/order_offer_details_card.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({super.key, this.checkOutModel,this.checkout, this.orderPage, this.getPaymentModel});
  final CheckoutEntity? checkOutModel;
  final PaymentOrderDataEntity? getPaymentModel;
  final bool? checkout;
  final bool? orderPage;

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  late StreamSubscription? _fawryCallbackResultStream;
  dynamic fawryFees;
  dynamic orderStatus;
  dynamic paymentAmount;
  dynamic paymentMethod;
  dynamic referenceNumber;
  bool paid = false;
  @override
  void initState() {
    super.initState();
    initSDKCallback();
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.getReceipt(
      purchaseOrderNumber: widget.checkout == true?
      widget.checkOutModel!.data.paymentRequest!.chargeItems![0].itemId! :
      widget.getPaymentModel!.data!.paymentRequest!.chargeItems![0].itemId!,
    );
  }

  @override
  void dispose() {
    _fawryCallbackResultStream?.cancel();
    super.dispose();
  }

  Future<void> initSDKCallback() async {
    try {
      _fawryCallbackResultStream =
          FawrySDK.instance.callbackResultStream().listen((event) {
            setState(() {
              ResponseStatus response = ResponseStatus.fromJson(jsonDecode(event));
              handleResponse(response);
            });
          });
    } catch (ex) {
      debugPrint(ex.toString());
    }
  }

  void handleResponse(ResponseStatus response) {
    switch (response.status) {
      case FawrySDK.RESPONSE_SUCCESS:
        {
          debugPrint('Message: ${response.message}');
          debugPrint('Json Response: ${response.data}');
        }
        break;
      case FawrySDK.RESPONSE_ERROR:
        {
          debugPrint('Error: ${response.message}');
        }
        break;
      case FawrySDK.RESPONSE_PAYMENT_COMPLETED:
        {
          AppBloc appBloc = AppBloc.get(context);

          if(response.message == 'Success'){
            paid = true;
            designToastDialog(
                context: context,
                toast: TOAST.success,
                text: appBloc.translationModel!.success
            );
          }else{
            designToastDialog(
                context: context,
                toast: TOAST.error,
                text: appBloc.translationModel!.error
            );
            paid = false;
          }
          debugPrint(
              'Payment Completed: ${response.message}, ${response.data}' '${response.status}'
          );
          Map<String, dynamic> jsonDataMap = json.decode(response.data!);
          FawryResponse fawryResponse = FawryResponse.fromJson(jsonDataMap);

           fawryFees = fawryResponse.fawryFees;
           orderStatus = fawryResponse.orderStatus;
           paymentAmount = fawryResponse.paymentAmount;
           paymentMethod = fawryResponse.paymentMethod;
           referenceNumber = fawryResponse.referenceNumber;

          HomeCubit homeCubit = HomeCubit.get(context);
          homeCubit.fawryPayment(
              purchaseNumber: widget.checkout == true? homeCubit.checkoutEntity!.data.paymentRequest!.chargeItems![0].itemId! : homeCubit.paymentOrderDataEntity!.data!.paymentRequest!.chargeItems![0].itemId!,
              expirationTime: fawryResponse.expirationTime!,
              fawryFees: fawryResponse.fawryFees!,
              orderAmount: fawryResponse.orderAmount!,
              orderStatus: fawryResponse.orderStatus!,
              paymentAmount: fawryResponse.paymentAmount!,
              paymentMethod: fawryResponse.paymentMethod!,
              referenceNumber: fawryResponse.referenceNumber!,
              shippingFees: fawryResponse.shippingFees!,
              taxes: fawryResponse.taxes!,
          );

        }
        break;
    }
  }
  final GlobalKey _globalKey = GlobalKey();
  Future<void> _generatePDF() async {
    try {
      RenderRepaintBoundary? boundary = _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) {
        return;
      }
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        return;
      }

      Uint8List pngBytes = byteData.buffer.asUint8List();
      final pdf = pw.Document();
      final pdfImage = pw.MemoryImage(pngBytes);
      pdf.addPage(pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Image(pdfImage),
          );
        },
      ));
      final output = await getExternalStorageDirectory();
      if (output == null) {
        return;
      }
      if(widget.checkout == true){
        final pdfFile = File('/storage/emulated/0/Documents/${widget.checkOutModel!.data.paymentRequest!.chargeItems![0].itemId}.pdf');
        await pdfFile.writeAsBytes(await pdf.save());
      }else{
        final pdfFile = File('/storage/emulated/0/Documents/${widget.getPaymentModel!.data!.paymentRequest!.chargeItems![0].itemId}.pdf');
        await pdfFile.writeAsBytes(await pdf.save());
      }
      HomeCubit homeCubit = HomeCubit.get(context);
      homeCubit.currentNavIndex = 0;
      navigateTo(context, const MainLayout());
      designToastDialog(
          context: context,
          toast: TOAST.success,
          text: 'receipt downloaded on your phone successfully in phone Storage'
      );
    } catch (e) {
    }
  }


  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc.get(context);
    HomeCubit homeCubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeState>(
    listener: (context, state) {
       if(widget.checkout == true)
      {
        BillItem item = BillItem(
          itemId: widget.checkOutModel!.data.paymentRequest!.chargeItems![0].itemId!,
          description: widget.checkOutModel!.data.paymentRequest!.chargeItems![0].description,
          quantity: widget.checkOutModel!.data.paymentRequest!.chargeItems![0].quantity,
          price: double.parse(widget.checkOutModel!.data.paymentRequest!.chargeItems![0].price!),
        );
        List<BillItem> chargeItems = [item];
        homeCubit.startPayment(
          customerProfileId: widget.checkOutModel!.data.paymentRequest!.customerProfileId!,
          customerEmail: widget.checkOutModel!.data.paymentRequest!.customerEmail!,
          customerMobile: widget.checkOutModel!.data.paymentRequest!.customerMobile!,
          customerName: widget.checkOutModel!.data.paymentRequest!.customerName!,
          merchantCode: widget.checkOutModel!.data.paymentRequest!.merchantCode!,
          merchantRefNum: widget.checkOutModel!.data.paymentRequest!.merchantRefNum!,
          billItems: chargeItems,
        );
      }
      if(widget.orderPage == true)
     {
            BillItem item = BillItem(
              itemId: widget.getPaymentModel!.data!.paymentRequest!.chargeItems![0].itemId!,
              description: widget.getPaymentModel!.data!.paymentRequest!.chargeItems![0].description,
              quantity: widget.getPaymentModel!.data!.paymentRequest!.chargeItems![0].quantity,
              price: double.parse(widget.getPaymentModel!.data!.paymentRequest!.chargeItems![0].price!),
            );
            List<BillItem> chargeItems = [item];
            homeCubit.startPayment(
              customerProfileId: widget.getPaymentModel!.data!.paymentRequest!.customerProfileId!,
              customerEmail: widget.getPaymentModel!.data!.paymentRequest!.customerEmail!,
              customerMobile: widget.getPaymentModel!.data!.paymentRequest!.customerMobile!,
              customerName: widget.getPaymentModel!.data!.paymentRequest!.customerName!,
              merchantCode: widget.getPaymentModel!.data!.paymentRequest!.merchantCode!,
              merchantRefNum: widget.getPaymentModel!.data!.paymentRequest!.merchantRefNum!,
              billItems: chargeItems,
            );
          }
    }, builder: (context, state) {
      return Scaffold(
        appBar: MainAppBar(
            title: appBloc.translationModel!.payment,
            isBack: true,
            isLang: false,
            isBackPress: (){
              navigateTo(context, const MainLayout());
              homeCubit.cartNum = '0';
            },
        ),
        body: homeCubit.receiptEntity != null ?
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 2.h),
            child: RepaintBoundary(
              key: _globalKey,
              child: Column(
                children: [
                  Image.asset(
                    Assets.images.png.logo,
                    width: double.infinity,
                    height: 20.h,
                    fit: BoxFit.cover,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace(2.h),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: ColorsManager.darkGrey.withOpacity(0.5),
                                  width: 1.rSp
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10.rSp))
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10.rw),
                          margin: EdgeInsets.symmetric(vertical: 10.rSp),
                          child: Column(
                            children: [
                              if(referenceNumber != null)
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        horizontalSpace(2.w),
                                        const Icon(Icons.numbers,color: ColorsManager.mainColor),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                            child: DefaultText(
                                                title: '${appBloc.translationModel!.referenceNumber} :',
                                                fontSize: 14.rSp,
                                                fontWeight: FontWeight.bold,
                                                color: ColorsManager.mainColor,
                                                style: Style.small
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: DefaultText(
                                              title: '$referenceNumber',
                                              fontSize: 14.rSp,
                                              fontWeight: FontWeight.bold,
                                              color: ColorsManager.mainColor,
                                              style: Style.small
                                          ),
                                        ),
                                      ],
                                    ),
                                    verticalSpace(1.h),
                                    Container(
                                      width: double.infinity,
                                      height: 0.5.rSp,
                                      color: ColorsManager.black.withOpacity(0.5),
                                    ),
                                    verticalSpace(1.h),
                                  ],
                                ),


                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  horizontalSpace(2.w),
                                  const Icon(Icons.numbers,color: ColorsManager.mainColor),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: DefaultText(
                                          title: '${appBloc.translationModel!.orderNumber} :',
                                          fontSize: 14.rSp,
                                          fontWeight: FontWeight.bold,
                                          color: ColorsManager.mainColor,
                                          style: Style.small
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: DefaultText(
                                        title: '${homeCubit.receiptEntity!.purchaseOrderNumber}',
                                        fontSize: 14.rSp,
                                        fontWeight: FontWeight.bold,
                                        color: ColorsManager.mainColor,
                                        style: Style.small
                                    ),
                                  ),
                                ],
                              ),
                              verticalSpace(1.h),
                              Container(
                                width: double.infinity,
                                height: 0.5.rSp,
                                color: ColorsManager.black.withOpacity(0.5),
                              ),
                              verticalSpace(1.h),


                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  horizontalSpace(2.w),
                                  const Icon(Icons.date_range,color: ColorsManager.mainColor),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: DefaultText(
                                          title: '${appBloc.translationModel!.orderDate} :',
                                          fontSize: 14.rSp,
                                          fontWeight: FontWeight.bold,
                                          color: ColorsManager.mainColor,
                                          style: Style.small
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: DefaultText(
                                        title: homeCubit.receiptEntity!.date.toString().replaceAll('00:00:00.000', ''),
                                        fontSize: 14.rSp,
                                        fontWeight: FontWeight.bold,
                                        color: ColorsManager.mainColor,
                                        style: Style.small
                                    ),
                                  ),
                                ],
                              ),
                              verticalSpace(1.h),
                              Container(
                                width: double.infinity,
                                height: 0.5.rSp,
                                color: ColorsManager.black.withOpacity(0.5),
                              ),
                              verticalSpace(1.h),


                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  horizontalSpace(2.w),
                                  const Icon(Icons.person,color: ColorsManager.mainColor),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: DefaultText(
                                          title: '${appBloc.translationModel!.customerName} :',
                                          fontSize: 14.rSp,
                                          fontWeight: FontWeight.bold,
                                          color: ColorsManager.mainColor,
                                          style: Style.small
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: DefaultText(
                                        title: homeCubit.receiptEntity!.customer!.fullName!,
                                        fontSize: 14.rSp,
                                        fontWeight: FontWeight.bold,
                                        color: ColorsManager.mainColor,
                                        style: Style.small
                                    ),
                                  ),
                                ],
                              ),
                              verticalSpace(1.h),
                              Container(
                                width: double.infinity,
                                height: 0.5.rSp,
                                color: ColorsManager.black.withOpacity(0.5),
                              ),
                              verticalSpace(1.h),

                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  horizontalSpace(2.w),
                                  const Icon(Icons.mobile_friendly,color: ColorsManager.mainColor),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: DefaultText(
                                          title: '${appBloc.translationModel!.mobile} :',
                                          fontSize: 14.rSp,
                                          fontWeight: FontWeight.bold,
                                          color: ColorsManager.mainColor,
                                          style: Style.small
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: DefaultText(
                                        title: homeCubit.receiptEntity!.customer!.mobile!,
                                        fontSize: 14.rSp,
                                        fontWeight: FontWeight.bold,
                                        color: ColorsManager.mainColor,
                                        style: Style.small),
                                  ),
                                ],
                              ),
                              verticalSpace(1.h),
                              Container(
                                width: double.infinity,
                                height: 0.5.rSp,
                                color: ColorsManager.black.withOpacity(0.5),
                              ),
                              verticalSpace(1.h),


                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  horizontalSpace(2.w),
                                  const Icon(Icons.location_on_outlined,color: ColorsManager.mainColor),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: DefaultText(
                                          title: '${appBloc.translationModel!.location} :',
                                          fontSize: 14.rSp,
                                          fontWeight: FontWeight.bold,
                                          color: ColorsManager.mainColor,
                                          style: Style.small
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: DefaultText(
                                        title: '${homeCubit.receiptEntity!.userAddress!.governorateName}, ${homeCubit.receiptEntity!.userAddress!.areaName}, ${homeCubit.receiptEntity!.userAddress!.streetName}, ${homeCubit.receiptEntity!.userAddress!.landmark}, ${homeCubit.receiptEntity!.userAddress!.buildingName}, ${homeCubit.receiptEntity!.userAddress!.floorNo}, ${homeCubit.receiptEntity!.userAddress!.aptNo} ',
                                        fontSize: 14.rSp,
                                        fontWeight: FontWeight.bold,
                                        color: ColorsManager.mainColor,
                                        style: Style.small),
                                  ),
                                ],
                              ),
                              verticalSpace(1.h),
                              Container(
                                width: double.infinity,
                                height: 0.5.rSp,
                                color: ColorsManager.black.withOpacity(0.5),
                              ),
                              verticalSpace(1.h),


                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  horizontalSpace(2.w),
                                  const Icon(Icons.payment,color: ColorsManager.mainColor),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: DefaultText(
                                          title: '${appBloc.translationModel!.paymentMethod} :',
                                          fontSize: 14.rSp,
                                          fontWeight: FontWeight.bold,
                                          color: ColorsManager.mainColor,
                                          style: Style.small
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: DefaultText(
                                        title: homeCubit.receiptEntity!.paymentMethod!.name!,
                                        fontSize: 14.rSp,
                                        fontWeight: FontWeight.bold,
                                        color: ColorsManager.mainColor,
                                        style: Style.small),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        verticalSpace(1.h),
                        ListView.separated(
                          scrollDirection: Axis.vertical,
                          separatorBuilder: (context, detailsIndex) {
                            return horizontalSpace(2.w);
                          },
                          itemCount: homeCubit.receiptEntity!.orders![0].orderDetails!.length,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, detailsIndex) {
                            return Column(
                              children: [
                                homeCubit.receiptEntity!.orders![0].orderDetails![detailsIndex].itemType == 'product'
                                    ? OrderDetailsCard(
                                  itemImage: homeCubit.receiptEntity!.orders![0].orderDetails![detailsIndex].image ?? '',
                                  itemName: homeCubit.receiptEntity!.orders![0].orderDetails![detailsIndex].name ?? '',
                                  description: '',
                                  itemQty: homeCubit.receiptEntity!.orders![0].orderDetails![detailsIndex].quantity ?? 0,
                                  itemF1Name: homeCubit.receiptEntity!.orders![0].orderDetails![detailsIndex].feature1Name ?? '',
                                  itemF2Name: homeCubit.receiptEntity!.orders![0].orderDetails![detailsIndex].feature2Name ?? '',
                                  itemPrice: homeCubit.receiptEntity!.orders![0].orderDetails![detailsIndex].price ?? '',
                                  createAt:  homeCubit.receiptEntity!.date.toString(),
                                  rateOption: null,
                                )
                                    : OrderDetailsOfferCard(
                                  offerProductsWidget: ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount: homeCubit.receiptEntity!.orders![0].orderDetails![detailsIndex].orderOfferDetails!.length,
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
                                                    imageUrl:  homeCubit.receiptEntity!.orders![0].orderDetails![detailsIndex].orderOfferDetails![offerDetailsIndex].image! ,
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
                                                            title: homeCubit.receiptEntity!.orders![0].orderDetails![detailsIndex].orderOfferDetails![offerDetailsIndex].name ?? '',
                                                            fontSize: 14.rSp,
                                                            fontWeight: FontWeight.bold,
                                                            color: ColorsManager.mainColor,
                                                            style: Style.small
                                                        ),
                                                        verticalSpace(1.h),
                                                        DefaultText(
                                                            title: '${homeCubit.receiptEntity!.orders![0].orderDetails![detailsIndex].orderOfferDetails![offerDetailsIndex].price} ${appBloc.translationModel!.currency}',
                                                            fontSize: 14.rSp,
                                                            fontWeight: FontWeight.bold,
                                                            color: ColorsManager.mainColor,
                                                            style: Style.small
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                  rateOption: null,
                                  description: '',
                                  itemImage: homeCubit.receiptEntity!.orders![0].orderDetails![detailsIndex].image ?? '',
                                  itemName: homeCubit.receiptEntity!.orders![0].orderDetails![detailsIndex].name ?? '',
                                  itemQty: homeCubit.receiptEntity!.orders![0].orderDetails![detailsIndex].quantity ?? 0,
                                  itemPrice: homeCubit.receiptEntity!.orders![0].orderDetails![detailsIndex].price ?? '',
                                  status: '',
                                  createdAt: homeCubit.receiptEntity!.date.toString(),
                                ),
                              ],
                            );
                          },
                        ),
                        verticalSpace(1.h),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: ColorsManager.darkGrey.withOpacity(0.5),
                                  width: 1.rSp
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10.rSp))
                          ),
                          padding: EdgeInsets.symmetric(vertical: 10.rw),
                          margin: EdgeInsets.symmetric(vertical: 10.rSp),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  horizontalSpace(2.w),
                                  const Icon(Icons.monetization_on_outlined,color: ColorsManager.mainColor),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: DefaultText(
                                          title: '${appBloc.translationModel!.total} :',
                                          fontSize: 14.rSp,
                                          fontWeight: FontWeight.bold,
                                          color: ColorsManager.mainColor,
                                          style: Style.small
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: DefaultText(
                                        title: '${homeCubit.receiptEntity!.orders![0].subTotal}',
                                        fontSize: 14.rSp,
                                        fontWeight: FontWeight.bold,
                                        color: ColorsManager.mainColor,
                                        style: Style.small),
                                  ),
                                ],
                              ),
                              verticalSpace(1.h),
                              Container(
                                width: double.infinity,
                                height: 0.5.rSp,
                                color: ColorsManager.black.withOpacity(0.5),
                              ),
                              verticalSpace(1.h),


                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  horizontalSpace(2.w),
                                  const Icon(Icons.money_off,color: ColorsManager.mainColor),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: DefaultText(
                                          title: '${appBloc.translationModel!.discountValue} :',
                                          fontSize: 14.rSp,
                                          fontWeight: FontWeight.bold,
                                          color: ColorsManager.mainColor,
                                          style: Style.small
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: DefaultText(
                                        title: '${homeCubit.receiptEntity!.orders![0].discountValue ?? 0.0}',
                                        fontSize: 14.rSp,
                                        fontWeight: FontWeight.bold,
                                        color: ColorsManager.mainColor,
                                        style: Style.small),
                                  ),
                                ],
                              ),
                              verticalSpace(1.h),
                              Container(
                                width: double.infinity,
                                height: 0.5.rSp,
                                color: ColorsManager.black.withOpacity(0.5),
                              ),
                              verticalSpace(1.h),


                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  horizontalSpace(2.w),
                                  const Icon(Icons.local_shipping_outlined,color: ColorsManager.mainColor),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: DefaultText(
                                          title: '${appBloc.translationModel!.fees} :',
                                          fontSize: 14.rSp,
                                          fontWeight: FontWeight.bold,
                                          color: ColorsManager.mainColor,
                                          style: Style.small
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: DefaultText(
                                        title: '${homeCubit.receiptEntity!.orders![0].shippingAmount ?? 0.0}',
                                        fontSize: 14.rSp,
                                        fontWeight: FontWeight.bold,
                                        color: ColorsManager.mainColor,
                                        style: Style.small),
                                  ),
                                ],
                              ),
                              verticalSpace(1.h),
                              Container(
                                width: double.infinity,
                                height: 0.5.rSp,
                                color: ColorsManager.black.withOpacity(0.5),
                              ),
                              verticalSpace(1.h),


                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  horizontalSpace(2.w),
                                  const Icon(Icons.money,color: ColorsManager.mainColor),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: DefaultText(
                                          title: '${appBloc.translationModel!.totalPayment} :',
                                          fontSize: 14.rSp,
                                          fontWeight: FontWeight.bold,
                                          color: ColorsManager.mainColor,
                                          style: Style.small
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: DefaultText(
                                        title: '${homeCubit.receiptEntity!.orders![0].totalAmount ?? 0.0}',
                                        fontSize: 14.rSp,
                                        fontWeight: FontWeight.bold,
                                        color: ColorsManager.mainColor,
                                        style: Style.small),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]
                  ),
                  verticalSpace(1.h),
                  if(!paid)
                    DefaultButton(
                    text: appBloc.translationModel!.payNow,
                    onPressed: () {
                      if(widget.checkout == true) {
                        homeCubit.checkOrderReceipt(
                            purchaseOrderNumber: widget.checkOutModel!.data.paymentRequest!.chargeItems![0].itemId ?? ''
                        );
                      }
                      if(widget.orderPage == true) {
                        homeCubit.checkOrderReceipt(
                            purchaseOrderNumber: widget.getPaymentModel!.data!.paymentRequest!.chargeItems![0].itemId ?? ''
                        );
                      }
                    },
                    ),
                  if(paid)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
                    child: DefaultButton(
                        text: appBloc.translationModel!.receipt,
                        onPressed: () async{
                          await _generatePDF();
                        },
                    ),
                  )  ,
                ],
              ),
            ),
          ),
        ):
        Center(
            child: ProgressDialog(message: appBloc.translationModel!.loading)
        ),
      );
    });
  }

}
