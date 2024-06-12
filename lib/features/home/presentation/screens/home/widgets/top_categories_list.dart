import 'dart:developer';
import 'package:card_loading/card_loading.dart';
import 'package:exponile_customer/core/util/resources/assets.gen.dart';
import 'package:exponile_customer/core/util/resources/constants_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/features/home/presentation/controller/cubit.dart';
import 'package:exponile_customer/features/home/presentation/controller/state.dart';
import 'package:exponile_customer/features/home/presentation/screens/home/widgets/store_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/util/resources/colors_manager.dart';

class TopCategoriesList extends StatefulWidget {
  const TopCategoriesList({super.key});

  @override
  TopCategoriesListState createState() => TopCategoriesListState();
}

class TopCategoriesListState extends State<TopCategoriesList> with SingleTickerProviderStateMixin {
  late TabController _topCategoriesShop;

  @override
  void initState() {
    HomeCubit homeCubit = HomeCubit.get(context);

    _topCategoriesShop = TabController(
      length: homeCubit.totalTopCategories,
      vsync: this,
    );
    _topCategoriesShop.addListener(_onTabControllerChanged);
    super.initState();
  }

  @override
  void dispose() {
    _topCategoriesShop.removeListener(_onTabControllerChanged);
    _topCategoriesShop.dispose();
    super.dispose();
  }

  void _onTabControllerChanged() {
    HomeCubit homeCubit = HomeCubit.get(context);
    if (_topCategoriesShop.index != homeCubit.topCategoriesCurrentIndex) {
      homeCubit.changeTopCurrentIndex(value: _topCategoriesShop.index);
      log(homeCubit.topCategoriesCurrentIndex.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    return BlocBuilder<HomeCubit,HomeState>(
      builder: (context, state) {
        return SizedBox(
          height: 35.h,
          child: homeCubit.topCategoriesEntity != null ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TabBar(
                controller: _topCategoriesShop,
                tabs: List<Widget>.generate(
                  _topCategoriesShop.length,
                      (index) => Tab(
                    text: homeCubit.topCategoriesEntity!.data[index].categoryName,
                  ),
                ),
                labelStyle: TextStyle(
                    color: ColorsManager.black,
                    fontSize: 12.rSp,
                    fontWeight: FontWeight.bold
                ),
                labelColor: ColorsManager.mainColor,
                unselectedLabelColor: ColorsManager.black.withOpacity(0.6),
                indicatorColor: ColorsManager.mainColor,
                labelPadding: EdgeInsets.symmetric(horizontal: 2.w),
                isScrollable: true,
                padding: EdgeInsets.symmetric(horizontal: 0.w,vertical: 1.h),
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _topCategoriesShop,
                  children: homeCubit.topCategoriesEntity!.data.map<Widget>((category) {
                    if (category.shop!.isNotEmpty) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return StoresCards(
                            storeLogo: category.shop![index].bannerPath!,
                            storeName: category.shop![index].shopName!,
                            shopID: category.shop![index].id!,
                            totalOffers: null,
                            rates: category.shop![index].rate!,
                          );
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: category.shop!.length,
                        shrinkWrap: true,
                      );
                    } else {
                      return svgImage(path: Assets.images.svg.noImage);
                    }
                  }).toList(),
                ),
              ),
            ],
          ) :
          CardLoading(
            height: 20.h,
            borderRadius: BorderRadius.all(Radius.circular(15.rSp)),
            width: 100.w,
            margin: EdgeInsets.only(bottom: 10.rSp),
          ),
        );
      },
    );
  }
}
