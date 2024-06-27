import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:exponile_customer/core/util/cubit/cubit.dart';
import 'package:exponile_customer/core/util/resources/constants_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/features/home/domain/entities/payment_order_data_entity.dart';
import 'package:exponile_customer/features/home/presentation/controller/cubit.dart';
import 'package:fawry_sdk/fawry_sdk.dart';
import 'package:fawry_sdk/model/bill_item.dart';
import 'package:fawry_sdk/model/response.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
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
              purchaseNumber: widget.checkout == true? homeCubit.checkoutEntity!.data.paymentRequest!.chargeItems![0].itemId : homeCubit.paymentOrderDataEntity!.data!.paymentRequest!.chargeItems![0].itemId,
              expirationTime: fawryResponse.expirationTime!,
              fawryFees: fawryResponse.fawryFees!,
              orderAmount: fawryResponse.orderAmount!,
              orderStatus: fawryResponse.orderStatus!,
              paymentAmount: fawryResponse.paymentAmount!,
              paymentMethod: fawryResponse.paymentMethod!,
              referenceNumber: fawryResponse.referenceNumber!,
              shippingFees: fawryResponse.shippingFees!,
              taxes: fawryResponse.taxes!,
              context: context
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
    var localization = AppLocalizations.of(context)!;
    return BlocProvider(
        create: (BuildContext context) => CheckOutCubit()..getReceipt(purchaseOrderNumber:
        widget.checkout == true?
        widget.checkOutModel!.data!.paymentRequest!.chargeItems![0].itemId! :
        widget.getPaymentModel!.data!.paymentRequest!.chargeItems![0].itemId!,
        context: context
        ),
        child: BlocConsumer<CheckOutCubit, CheckOutState>(
        listener: (context, state) {
         var cubit = CheckOutCubit.get(context);
         if(state is SuccessReceiptState)
           {
             log('Receipt Response is ${cubit.receiptModel!.purchaseOrderNumber}');
           }
           if(widget.checkout == true)
          {
            BillItem item = BillItem(
              itemId: widget.checkOutModel!.data!.paymentRequest!.chargeItems![0].itemId!,
              description: widget.checkOutModel!.data!.paymentRequest!.chargeItems![0].description,
              quantity: widget.checkOutModel!.data!.paymentRequest!.chargeItems![0].quantity,
              price: double.parse(widget.checkOutModel!.data!.paymentRequest!.chargeItems![0].price!),
            );
            List<BillItem> chargeItems = [item];
            cubit.startPayment(
              customerProfileId: widget.checkOutModel!.data!.paymentRequest!.customerProfileId!,
              customerEmail: widget.checkOutModel!.data!.paymentRequest!.customerEmail!,
              customerMobile: widget.checkOutModel!.data!.paymentRequest!.customerMobile!,
              customerName: widget.checkOutModel!.data!.paymentRequest!.customerName!,
              merchantCode: widget.checkOutModel!.data!.paymentRequest!.merchantCode!,
              merchantRefNum: widget.checkOutModel!.data!.paymentRequest!.merchantRefNum!,
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
                cubit.startPayment(
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
          var cubit = CheckOutCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: whiteClr,
              leading: Container(),
              systemOverlayStyle: Platform.isIOS ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
              flexibleSpace: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(left: 20.rSp, right: 20.rSp, top: 10.rSp),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const MainLunchScreen()),);
                            cartNum = '0';
                            inCheckout = false;
                          },
                          child: BackButtonNative()),
                      Padding(
                        padding: EdgeInsets.only(left: 10.rSp),
                        child: Align(
                          child: textUtils(
                              text: localization.payment.toUpperCase(),
                              fontSize: 16.rSp,
                              fontWeight: FontWeight.bold,
                              textColor: mainColor,
                              underLine: TextDecoration.none),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: cubit.receiptModel != null ?
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 2.h),
                child: RepaintBoundary(
                  key: _globalKey,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        width: double.infinity,
                        height: 20.h,
                        fit: BoxFit.cover,
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            space(height: 2.h),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: formFieldClr.withOpacity(0.5),
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
                                            space(width: 1.w),
                                            const Icon(Icons.numbers,color: mainColor),
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                child: textUtils(
                                                    text: '${localization.referenceNumber} :',
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    textColor: statusBarColor,
                                                    underLine: TextDecoration.none
                                                ),
                                              ),
                                            ),
                                            const Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                              child: textUtils(
                                                  text: '$referenceNumber',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  textColor: statusBarColor,
                                                  underLine: TextDecoration.none),
                                            ),
                                          ],
                                        ),
                                        space(height: 1.h),
                                        Container(
                                          width: double.infinity,
                                          height: 0.5.rSp,
                                          color: blackClr.withOpacity(0.5),
                                        ),
                                        space(height: 1.h),
                                      ],
                                    ),


                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      space(width: 1.w),
                                      const Icon(Icons.numbers,color: mainColor),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: textUtils(
                                              text: '${localization.orderNo} :',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              textColor: statusBarColor,
                                              underLine: TextDecoration.none
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: textUtils(
                                            text: '${cubit.receiptModel!.purchaseOrderNumber}',
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            textColor: statusBarColor,
                                            underLine: TextDecoration.none),
                                      ),
                                    ],
                                  ),
                                  space(height: 1.h),
                                  Container(
                                    width: double.infinity,
                                    height: 0.5.rSp,
                                    color: blackClr.withOpacity(0.5),
                                  ),
                                  space(height: 1.h),


                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      space(width: 1.w),
                                      const Icon(Icons.date_range,color: mainColor),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: textUtils(
                                              text: '${localization.orderDate} :',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              textColor: statusBarColor,
                                              underLine: TextDecoration.none
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: textUtils(
                                            text: cubit.receiptModel!.date.toString().replaceAll('00:00:00.000', ''),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            textColor: statusBarColor,
                                            underLine: TextDecoration.none),
                                      ),
                                    ],
                                  ),
                                  space(height: 1.h),
                                  Container(
                                    width: double.infinity,
                                    height: 0.5.rSp,
                                    color: blackClr.withOpacity(0.5),
                                  ),
                                  space(height: 1.h),


                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      space(width: 1.w),
                                      const Icon(Icons.person,color: mainColor),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: textUtils(
                                              text: '${localization.customer} :',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              textColor: statusBarColor,
                                              underLine: TextDecoration.none
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: textUtils(
                                            text: cubit.receiptModel!.customer!.fullName!,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            textColor: statusBarColor,
                                            underLine: TextDecoration.none),
                                      ),
                                    ],
                                  ),
                                  space(height: 1.h),
                                  Container(
                                    width: double.infinity,
                                    height: 0.5.rSp,
                                    color: blackClr.withOpacity(0.5),
                                  ),
                                  space(height: 1.h),

                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      space(width: 1.w),
                                      const Icon(Icons.mobile_friendly,color: mainColor),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: textUtils(
                                              text: '${localization.mobile} :',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              textColor: statusBarColor,
                                              underLine: TextDecoration.none
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: textUtils(
                                            text: cubit.receiptModel!.customer!.mobile!,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            textColor: statusBarColor,
                                            underLine: TextDecoration.none),
                                      ),
                                    ],
                                  ),
                                  space(height: 1.h),
                                  Container(
                                    width: double.infinity,
                                    height: 0.5.rSp,
                                    color: blackClr.withOpacity(0.5),
                                  ),
                                  space(height: 1.h),


                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      space(width: 1.w),
                                      const Icon(Icons.location_on_outlined,color: mainColor),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: textUtils(
                                              text: '${localization.location} :',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              textColor: statusBarColor,
                                              underLine: TextDecoration.none
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: textUtils(
                                            text: '${cubit.receiptModel!.userAddress!.governorateName}, ${cubit.receiptModel!.userAddress!.areaName}, ${cubit.receiptModel!.userAddress!.streetName}, ${cubit.receiptModel!.userAddress!.landmark}, ${cubit.receiptModel!.userAddress!.buildingName}, ${cubit.receiptModel!.userAddress!.floorNo}, ${cubit.receiptModel!.userAddress!.aptNo} ',
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            textColor: statusBarColor,
                                            underLine: TextDecoration.none),
                                      ),
                                    ],
                                  ),
                                  space(height: 1.h),
                                  Container(
                                    width: double.infinity,
                                    height: 0.5.rSp,
                                    color: blackClr.withOpacity(0.5),
                                  ),
                                  space(height: 1.h),


                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      space(width: 1.w),
                                      const Icon(Icons.payment,color: mainColor),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: textUtils(
                                              text: '${localization.payment_method} :',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              textColor: statusBarColor,
                                              underLine: TextDecoration.none
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: textUtils(
                                            text: cubit.receiptModel!.paymentMethod!.name!,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            textColor: statusBarColor,
                                            underLine: TextDecoration.none),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            space(height: 1.h),
                            ListView.separated(
                              scrollDirection: Axis.vertical,
                              separatorBuilder: (context, detailsIndex) {
                                return space(width: 10.rSp);
                              },
                              itemCount: cubit.receiptModel!.orders![0].orderDetails!.length,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (context, detailsIndex) {
                                return Column(
                                  children: [
                                    cubit.receiptModel!.orders![0].orderDetails![detailsIndex].itemType == 'product'
                                        ? OrderDetailsCard(
                                      itemImage: cubit.receiptModel!.orders![0].orderDetails![detailsIndex].image ?? '',
                                      itemName: cubit.receiptModel!.orders![0].orderDetails![detailsIndex].name ?? '',
                                      description: '',
                                      itemQty: cubit.receiptModel!.orders![0].orderDetails![detailsIndex].quantity ?? 0,
                                      itemF1Name: cubit.receiptModel!.orders![0].orderDetails![detailsIndex].feature1Name ?? '',
                                      itemF2Name: cubit.receiptModel!.orders![0].orderDetails![detailsIndex].feature2Name ?? '',
                                      itemPrice: cubit.receiptModel!.orders![0].orderDetails![detailsIndex].price ?? '',
                                      createAt:  cubit.receiptModel!.date.toString(),
                                      rateOption: null,
                                    )
                                        : OrderDetailsOfferCard(
                                      offerProductsWidget: ListView.builder(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.vertical,
                                          itemCount: cubit.receiptModel!.orders![0].orderDetails![detailsIndex].orderOfferDetails!.length,
                                          itemBuilder: (BuildContext context, int offerDetailsIndex) {
                                            return Padding(
                                              padding: EdgeInsets.all(5.rSp),
                                              child: Card(
                                                elevation: 5,
                                                shape: RoundedRectangleBorder
                                                  (
                                                    borderRadius: BorderRadius.circular(15.rSp),
                                                    side: BorderSide(
                                                        color: mainColor.withOpacity(0.7),
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
                                                        imageUrl:  cubit.receiptModel!.orders![0].orderDetails![detailsIndex].orderOfferDetails![offerDetailsIndex].image! ,
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
                                                            child: Lottie.asset(Assets.lottieNoData,fit: BoxFit.cover)
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
                                                            textUtils(text: cubit.receiptModel!.orders![0].orderDetails![detailsIndex].orderOfferDetails![offerDetailsIndex].name ?? '', fontSize: 12, fontWeight: FontWeight.bold, textColor: statusBarColor, underLine: TextDecoration.none, textOverflow: TextOverflow.ellipsis, textAlign: TextAlign.left),
                                                            space(height: 10.rSp),
                                                            textUtils(text: '${cubit.receiptModel!.orders![0].orderDetails![detailsIndex].orderOfferDetails![offerDetailsIndex].price} ${localization.egp}', fontSize: 14, fontWeight: FontWeight.bold, textColor: mainColor, underLine: TextDecoration.none, textAlign: TextAlign.left),
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
                                      itemImage: cubit.receiptModel!.orders![0].orderDetails![detailsIndex].image ?? '',
                                      itemName: cubit.receiptModel!.orders![0].orderDetails![detailsIndex].name ?? '',
                                      itemQty: cubit.receiptModel!.orders![0].orderDetails![detailsIndex].quantity ?? 0,
                                      itemPrice: cubit.receiptModel!.orders![0].orderDetails![detailsIndex].price ?? '',
                                      status: '',
                                      createdAt: cubit.receiptModel!.date.toString(),
                                    ),
                                  ],
                                );
                              },
                            ),
                            space(height: 1.h),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: formFieldClr.withOpacity(0.5),
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
                                      space(width: 1.w),
                                      const Icon(Icons.monetization_on_outlined,color: mainColor),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: textUtils(
                                              text: '${localization.subtotal} :',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              textColor: statusBarColor,
                                              underLine: TextDecoration.none
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: textUtils(
                                            text: '${cubit.receiptModel!.orders![0].subTotal}',
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            textColor: statusBarColor,
                                            underLine: TextDecoration.none),
                                      ),
                                    ],
                                  ),
                                  space(height: 1.h),
                                  Container(
                                    width: double.infinity,
                                    height: 0.5.rSp,
                                    color: blackClr.withOpacity(0.5),
                                  ),
                                  space(height: 1.h),


                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      space(width: 1.w),
                                      const Icon(Icons.money_off,color: mainColor),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: textUtils(
                                              text: '${localization.discount} :',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              textColor: statusBarColor,
                                              underLine: TextDecoration.none
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: textUtils(
                                            text: '${cubit.receiptModel!.orders![0].discountValue ?? 0.0}',
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            textColor: statusBarColor,
                                            underLine: TextDecoration.none),
                                      ),
                                    ],
                                  ),
                                  space(height: 1.h),
                                  Container(
                                    width: double.infinity,
                                    height: 0.5.rSp,
                                    color: blackClr.withOpacity(0.5),
                                  ),
                                  space(height: 1.h),


                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      space(width: 1.w),
                                      const Icon(Icons.local_shipping_outlined,color: mainColor),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: textUtils(
                                              text: '${localization.totalShipping} :',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              textColor: statusBarColor,
                                              underLine: TextDecoration.none
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: textUtils(
                                            text: '${cubit.receiptModel!.orders![0].shippingAmount ?? 0.0}',
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            textColor: statusBarColor,
                                            underLine: TextDecoration.none),
                                      ),
                                    ],
                                  ),
                                  space(height: 1.h),
                                  Container(
                                    width: double.infinity,
                                    height: 0.5.rSp,
                                    color: blackClr.withOpacity(0.5),
                                  ),
                                  space(height: 1.h),


                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      space(width: 1.w),
                                      const Icon(Icons.money,color: mainColor),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          child: textUtils(
                                              text: '${localization.totalPayment} :',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              textColor: statusBarColor,
                                              underLine: TextDecoration.none
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: textUtils(
                                            text: '${cubit.receiptModel!.orders![0].totalAmount ?? 0.0}',
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            textColor: statusBarColor,
                                            underLine: TextDecoration.none),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ]
                      ),
                      space(height: 1.h),
                      if(!paid)
                        PrimaryButton(
                          text: localization.payNow,
                          border: 5.rSp,
                          txtColor: whiteClr,
                          color: mainColor,
                          onPressed: () {
                            if(widget.checkout == true) {
                              cubit.checkOrderPayment(
                                  context: context,
                                  purchaseOrderNumber: widget.checkOutModel!.data!.paymentRequest!.chargeItems![0].itemId ?? ''
                              );
                            }
                            if(widget.orderPage == true) {
                              cubit.checkOrderPayment(
                                  context: context,
                                  purchaseOrderNumber: widget.getPaymentModel!.data!.paymentRequest!.chargeItems![0].itemId ?? ''
                              );
                            }
                          },
                        ),
                      if(paid)
                      PrimaryButton(
                        text: localization.reciept,
                        border: 5.rSp,
                        txtColor: whiteClr,
                        color: mainColor,
                        onPressed: () async {
                          await _generatePDF();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ):
            Center(
                child: LoadingDialog(
                )
            ),
          );
        }));
  }

}
