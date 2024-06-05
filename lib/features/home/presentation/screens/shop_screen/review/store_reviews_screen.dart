import 'package:exponile_customer/core/util/cubit/cubit.dart';
import 'package:exponile_customer/core/util/resources/colors_manager.dart';
import 'package:exponile_customer/core/util/resources/constants_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/default_text.dart';
import 'package:exponile_customer/core/util/widgets/main_appbar.dart';
import 'package:exponile_customer/features/home/presentation/controller/cubit.dart';
import 'package:exponile_customer/features/home/presentation/screens/shop_screen/shop_view_card.dart';
import 'package:exponile_customer/features/home/presentation/screens/shop_screen/review/store_review_card.dart';
import 'package:flutter/material.dart';
import '../../../../../../core/util/resources/assets.gen.dart';

class StoreReviewsScreen extends StatefulWidget {
  const StoreReviewsScreen({
    super.key,
    required this.reviews,
    required this.logoPath,
    required this.categories,
    required this.storeName,
    required this.rate,
    required this.isFavourite,  
    required this.shopID  
  });
  final dynamic reviews;
  final String logoPath;
  final String storeName;
  final String rate;
  final dynamic categories;
  final bool isFavourite;
  final int shopID;

  @override
  State<StoreReviewsScreen> createState() => _StoreReviewsScreenState();
}

class _StoreReviewsScreenState extends State<StoreReviewsScreen> {

  @override
  void initState() {
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.isChangedFavouriteIcon = widget.isFavourite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    AppBloc appBloc = AppBloc.get(context);
    HomeCubit homeCubit = HomeCubit.get(context);

    return Directionality(
      textDirection: appBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: MainAppBar(
            title: appBloc.translationModel!.reviews,
            isBack: true,
            isLang: false
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              vertical: 1.h, horizontal: 2.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(widget.categories.isNotEmpty)
                StoreViewCard(
                  storeImagePath: widget.logoPath,
                  storeName: widget.storeName,
                  storeCategories: widget.categories[0].name,
                  storeRate: widget.rate,
                  isFavorite: widget.isFavourite,
                  onStoreFavoriteTap: () {
                    homeCubit.addFavourite(
                      itemType: 'store',
                      itemID: widget.shopID,
                    );
                    homeCubit.changedFavouriteIcon();
                  },
                ),
              verticalSpace(1.h),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 15.rSp, vertical: 5.rSp),
                child: DefaultText(
                    title: appBloc.translationModel!.reviews,
                    style: Style.medium,
                    fontSize: 14.rSp,
                    fontWeight: FontWeight.w700,
                    color: ColorsManager.mainColor,
                ),
              ),
              widget.reviews.isEmpty
                  ? Center(
                child: svgImage(path: Assets.images.svg.noImage),
              )
                  : Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics:
                    const BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: widget.reviews.length,
                    itemBuilder: (BuildContext context, int index) {
                      return StoreReviewCard(
                        userImage: 'image path',
                        userName: 'user name',
                        userRate: widget.reviews[index]['rate'].toString(),
                        reviewDate: widget.reviews[index]['created_at'] ?? '',
                        review: widget.reviews[index]['review'] ?? '',
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
