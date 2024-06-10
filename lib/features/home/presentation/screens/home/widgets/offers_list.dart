import 'package:card_loading/card_loading.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/features/home/presentation/controller/cubit.dart';
import 'package:exponile_customer/features/home/presentation/controller/state.dart';
import 'package:exponile_customer/features/home/presentation/screens/home/widgets/store_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/util/cubit/cubit.dart';
import '../../../../../../core/util/resources/colors_manager.dart';
import '../../../../../../core/util/resources/constants_manager.dart';
import '../../../../../../core/util/widgets/default_text.dart';

class OffersList extends StatelessWidget {
  const OffersList({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    AppBloc appBloc = AppBloc.get(context);
    return Directionality(
        textDirection: appBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: BlocBuilder<HomeCubit,HomeState>(
            builder: (context, state) {
              return homeCubit.mostOffersEntity ==  null || homeCubit.mostOffersEntity!.storesWithMostOffers.isEmpty ?
              CardLoading(
                height: 20.h,
                borderRadius: BorderRadius.all(Radius.circular(15.rSp)),
                width: 100.w,
                margin: EdgeInsets.only(bottom: 10.rSp),
              ) :
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DefaultText(
                    title: appBloc.translationModel!.offers,
                    style: Style.headMedium,
                    color: ColorsManager.mainColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 14.rSp,
                  ),
                  verticalSpace(1.h),
                  SizedBox(
                    height: 30.h,
                    width: 100.w,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: homeCubit.mostOffersEntity!.storesWithMostOffers.length,
                        itemBuilder: (context, index) {
                          return StoresCards(
                            storeLogo: homeCubit.mostOffersEntity!.storesWithMostOffers[index].bannerPath,
                            storeName: homeCubit.mostOffersEntity!.storesWithMostOffers[index].shopName,
                            shopID: homeCubit.mostOffersEntity!.storesWithMostOffers[index].id,
                            totalOffers: homeCubit.mostOffersEntity!.storesWithMostOffers[index].totalOffers,
                            rates: homeCubit.mostOffersEntity!.storesWithMostOffers[index].rate,
                          );
                        },
                    ),
                  )
                ],
              );
            },
        )
    );
  }
}
