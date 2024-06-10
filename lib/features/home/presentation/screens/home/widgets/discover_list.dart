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

class DiscoverList extends StatelessWidget {
  const DiscoverList({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    AppBloc appBloc = AppBloc.get(context);
    return Directionality(
        textDirection: appBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: BlocBuilder<HomeCubit,HomeState>(
          builder: (context, state) {
            return homeCubit.discoverNewStoresEntity ==  null || homeCubit.discoverNewStoresEntity!.data.stores!.data!.isEmpty ?
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
                Row(
                  children: [
                    DefaultText(
                      title: appBloc.translationModel!.discover,
                      style: Style.headMedium,
                      color: ColorsManager.mainColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 14.rSp,
                    ),
                    // const Spacer(),
                    // DefaultText(
                    //   title: appBloc.translationModel!.seeAll,
                    //   style: Style.headMedium,
                    //   color: ColorsManager.mainColor,
                    //   fontWeight: FontWeight.w700,
                    //   fontSize: 14.rSp,
                    // ),
                  ],
                ),
                verticalSpace(1.h),
                SizedBox(
                  height: 30.h,
                  width: 100.w,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: homeCubit.discoverNewStoresEntity!.data.stores!.data!.length,
                    itemBuilder: (context, index) {
                      return StoresCards(
                        storeLogo: homeCubit.discoverNewStoresEntity!.data.stores!.data![index].bannerPath!,
                        storeName: homeCubit.discoverNewStoresEntity!.data.stores!.data![index].shopName!,
                        shopID: homeCubit.discoverNewStoresEntity!.data.stores!.data![index].id!,
                        rates: homeCubit.discoverNewStoresEntity!.data.stores!.data![index].rate!,
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
