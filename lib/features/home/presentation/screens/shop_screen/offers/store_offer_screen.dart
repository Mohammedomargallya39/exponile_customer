import 'dart:developer';
import 'package:exponile_customer/core/util/cubit/cubit.dart';
import 'package:exponile_customer/core/util/loading_files/all_offers_loading.dart';
import 'package:exponile_customer/core/util/resources/assets.gen.dart';
import 'package:exponile_customer/core/util/resources/constants_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/main_appbar.dart';
import 'package:exponile_customer/features/home/presentation/controller/cubit.dart';
import 'package:exponile_customer/features/home/presentation/controller/state.dart';
import 'package:exponile_customer/features/home/presentation/screens/shop_screen/offers/store_offer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../offer_details_screen.dart';

class StoreOffersScreen extends StatefulWidget {
  const StoreOffersScreen({super.key, this.storeId,required this.category});
  final dynamic storeId;
  final String category;

  @override
  State<StoreOffersScreen> createState() => _StoreOffersScreenState();
}

class _StoreOffersScreenState extends State<StoreOffersScreen> {
  var id = 0;

  @override
  void initState() {
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.storeOffers(storeID: widget.storeId);
    //..getStoreOffersData(widget.storeId,context: context);
    log('Store Id : $id');
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc.get(context);
    HomeCubit homeCubit = HomeCubit.get(context);
    return Directionality(
        textDirection: appBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: BlocBuilder<HomeCubit,HomeState>(
          builder: (context, state) {
            return  Scaffold(
              appBar: MainAppBar(
                  title: appBloc.translationModel!.offers,
                  isBack: true,
                  isLang: false
              ),
              body: homeCubit.storeOffersEntity == null ?
              const AllOffersLoading():
              homeCubit.storeOffersEntity!.data!.offers.isEmpty?
              Center(
                  child: svgImage(
                      path: Assets.images.svg.noImage
                  )
              ):
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 5.rSp, horizontal: 5.rSp),
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: homeCubit.storeOffersEntity!.data!.offers.length,
                        gridDelegate:
                        SliverGridDelegateWithMaxCrossAxisExtent(
                          childAspectRatio:
                          (MediaQuery.of(context).size.width) / (MediaQuery.of(context).size.height / 1.5),
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          maxCrossAxisExtent:
                          MediaQuery.of(context)
                              .size
                              .width /
                              2,
                        ),
                        itemBuilder: (context, index) {
                          return StoreOffersCard(
                            offerBannerPath: homeCubit.storeOffersEntity!.data!.offers[index].bannerPath ?? '',
                            offerTitle: homeCubit.storeOffersEntity!.data!.offers[index].name ?? '',
                            onSeeMoreTap: () {
                              navigateTo(
                                context,
                                OfferDetailsScreen(
                                offerId: homeCubit.storeOffersEntity!.data!.offers[index].id!,
                                storeCategories: [
                                  widget.category
                                ],
                              )
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        )
    );
  }
}
