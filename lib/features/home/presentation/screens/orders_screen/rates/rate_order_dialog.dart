import 'package:exponile_customer/core/util/cubit/cubit.dart';
import 'package:exponile_customer/core/util/resources/colors_manager.dart';
import 'package:exponile_customer/core/util/resources/constants_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/default_button.dart';
import 'package:exponile_customer/core/util/widgets/default_text.dart';
import 'package:exponile_customer/core/util/widgets/default_text_field.dart';
import 'package:exponile_customer/features/home/presentation/controller/cubit.dart';
import 'package:exponile_customer/features/home/presentation/controller/state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';
import '../../../../../../core/util/resources/assets.gen.dart';
import '../../../../../../core/util/widgets/progress.dart';

class RateOrderDialog extends StatefulWidget {
  const RateOrderDialog({super.key,required this.orderNumber,this.storeId,this.productId});
  final int orderNumber;
  final int?storeId;
  final int?productId;

  @override
  _RateOrderDialogState createState() => _RateOrderDialogState();
}

class _RateOrderDialogState extends State<RateOrderDialog> {

  @override
  void initState() {
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.isRateShop = false;
    super.initState();
  }

  TextEditingController addRate = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    AppBloc appBloc = AppBloc.get(context);
    String rateImage= Assets.images.lotti.rateNow;

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if(state is AddRateLoadingState){
            showDialog(
              context: context,
              builder: (context) {
                return ProgressDialog(message: appBloc.translationModel!.loading);
              },
            );
         }
        if(state is AddRateSuccessState){
          homeCubit.rating = 0.0;
          addRate.text = '';
          Navigator.pop(context);
          Navigator.pop(context);
          homeCubit.changeRatingType();
          designToastDialog(
              context: context,
              toast: TOAST.error,
              text: state.addRateEntity.message!
          );
        }
        if(state is AddRateErrorState){
          Navigator.pop(context);
          Navigator.pop(context);
          designToastDialog(
              context: context,
              toast: TOAST.error,
              text: state.failure
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Dialog(
            backgroundColor: ColorsManager.whiteColor,
            insetPadding: const EdgeInsets.all(1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0.rSp),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width / 1.2,
              height: MediaQuery.of(context).size.height / 1.7,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: DefaultText(
                            title: appBloc.translationModel!.rate,
                            fontSize: 14.rSp,
                            style: Style.small,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      verticalSpace(3.h),
                      Center(
                        child: Lottie.asset(
                          rateImage,
                          height: MediaQuery.of(context).size.width / 3,
                        ),
                      ),
                      verticalSpace(3.h),
                      Row(
                        children: [
                          DefaultText(
                              title: appBloc.translationModel!.rate,
                              fontSize: 14.rSp,
                              style: Style.small,
                              fontWeight: FontWeight.w700
                          ),
                          horizontalSpace(6.w),
                          Expanded(
                            child: RatingBar(
                              initialRating: homeCubit.rating,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 15.rSp,
                              itemPadding: EdgeInsets.symmetric(horizontal: 3.w),
                              ratingWidget: RatingWidget(
                                full: Image.asset(Assets.images.png.star),
                                half: Image.asset(Assets.images.png.starHalf),
                                empty: Image.asset(Assets.images.png.starBorder),
                              ),
                              onRatingUpdate: (rating) {
                                if (kDebugMode) {
                                  homeCubit.rating = rating;
                                  homeCubit.toggleRoleSelection();
                                }
                              },
                            ),
                          )
                        ],
                      ),
                      verticalSpace(3.h),

                      DefaultTextField(
                          controller: addRate,
                          hint: appBloc.translationModel!.rate,
                          maxLength: 300,
                          maxLines: 7,
                          type: TextInputType.text,
                          validate: (dynamic value) {
                            if (value.isEmpty) {
                              return appBloc.translationModel!.requiredField;
                            }
                            return null;
                          },
                      ),

                      if(widget.storeId == null && widget.productId == null)
                        DefaultButton(
                            onPressed: () async {
                              if(formKey.currentState!.validate()){
                                homeCubit.addRate(id: widget.orderNumber, type: 'Order', rating: homeCubit.rating, review: addRate.text, orderID: widget.orderNumber);
                              }
                            },
                            text: appBloc.translationModel!.submit
                        ),

                      if(widget.storeId != null)
                        DefaultButton(
                            onPressed: () async {
                              if(formKey.currentState!.validate()){
                                homeCubit.addRate( id: widget.storeId!, type: 'Shop', rating: homeCubit.rating, review: addRate.text, orderID: widget.orderNumber);
                              }
                            },
                            text: appBloc.translationModel!.submit
                        ),

                      if(widget.productId != null)
                        DefaultButton(
                            onPressed: () async {
                              if(formKey.currentState!.validate()){
                                homeCubit.addRate(id: widget.storeId!, type: 'Product', rating: homeCubit.rating, review: addRate.text, orderID: widget.orderNumber);
                              }
                            },
                            text: appBloc.translationModel!.submit
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}