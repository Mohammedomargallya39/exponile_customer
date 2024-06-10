import 'package:exponile_customer/core/util/resources/constants_manager.dart';
import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/features/home/presentation/controller/state.dart';
import 'package:exponile_customer/features/home/presentation/screens/home/widgets/banars.dart';
import 'package:exponile_customer/features/home/presentation/screens/home/widgets/best_sellers_list.dart';
import 'package:exponile_customer/features/home/presentation/screens/home/widgets/categories_slider.dart';
import 'package:exponile_customer/features/home/presentation/screens/home/widgets/discover_list.dart';
import 'package:exponile_customer/features/home/presentation/screens/home/widgets/favourite_list.dart';
import 'package:exponile_customer/features/home/presentation/screens/home/widgets/offers_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/util/cubit/cubit.dart';
import '../../controller/cubit.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    AppBloc appBloc = AppBloc.get(context);
    return Directionality(
        textDirection: appBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: BlocBuilder<HomeCubit,HomeState>(
            builder: (context, state) {
              return Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Banners(),
                      verticalSpace(2.h),
                      const CategorySlider(),

                      const OffersList(),
                      verticalSpace(2.h),
                      const FavouriteList(),
                      verticalSpace(2.h),
                      const DiscoverList(),
                      verticalSpace(2.h),
                      const BestSellersList(),
                      verticalSpace(2.h),

                    ],
                  ),
                ),
              );
            },
        ),
    );
  }
}
