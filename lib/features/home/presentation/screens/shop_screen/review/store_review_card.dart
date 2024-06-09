import 'package:cached_network_image/cached_network_image.dart';
import 'package:exponile_customer/core/util/cubit/cubit.dart';
import 'package:exponile_customer/core/util/resources/colors_manager.dart';
import 'package:exponile_customer/core/util/resources/constants_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../../../../core/util/widgets/default_text.dart';

class StoreReviewCard extends StatelessWidget {
  const StoreReviewCard(
      {super.key,
      required this.userImage,
      required this.userName,
      required this.userRate,
      required this.reviewDate,
      required this.review});
  final String userImage;
  final String userName;
  final String userRate;
  final String reviewDate;
  final String review;
  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc.get(context);
    return Directionality(
      textDirection: appBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.rSp, vertical: 5.rSp),
        child: Container(
          padding: EdgeInsets.all(10.rh),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.rSp)),
          boxShadow: [
          BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          offset: const Offset(0, 3), // changes position of shadow
                  ),
              ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50.rSp,
                height: 50.rSp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.rSp),
                  color: ColorsManager.mintGreen.withOpacity(0.5),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(userImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              horizontalSpace(2.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DefaultText(
                          title: userName,
                          style: Style.medium,
                          fontSize: 14.rSp,
                          fontWeight: FontWeight.w700,
                          color: ColorsManager.mainColor,
                          maxLines: 5,
                        ),
                        RatingBar.builder(
                          initialRating: double.parse(userRate),
                          minRating: 0,
                          ignoreGestures: true,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 14.rSp,
                          //   itemPadding: EdgeInsets.symmetric(horizontal: 4.0.rSp),
                          itemBuilder: (context, _) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                          },
                        ),
                      ],
                    ),
                    DefaultText(
                      title: DateTime.parse(reviewDate).dateAndTime,
                      style: Style.medium,
                      fontSize: 14.rSp,
                      fontWeight: FontWeight.w400,
                      color: ColorsManager.mintGreen.withOpacity(0.7),
                      maxLines: 5,
                    ),
                    if(review.isNotEmpty && !review.startsWith(' '))
                      verticalSpace(1.h),
                    if(review.isNotEmpty && !review.startsWith(' '))
                      DefaultText(
                        title: review,
                        style: Style.medium,
                        fontSize: 14.rSp,
                        fontWeight: FontWeight.w400,
                        color: ColorsManager.mainColor,
                        maxLines: 5,
                      )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
