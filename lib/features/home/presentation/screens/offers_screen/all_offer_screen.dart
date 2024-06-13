import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/filter_offers_dialog.dart';
import 'package:exponile_customer/core/util/widgets/my_icon_button.dart';
import 'package:exponile_customer/features/home/presentation/controller/state.dart';
import 'package:exponile_customer/features/home/presentation/screens/home/widgets/store_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:number_pagination/number_pagination.dart';
import '../../../../../core/util/cubit/cubit.dart';
import '../../../../../core/util/loading_files/all_product_loading.dart';
import '../../../../../core/util/resources/colors_manager.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/default_text.dart';
import '../../../../../core/util/widgets/hideKeyboard.dart';
import '../../controller/cubit.dart';

class AllOffersScreen extends StatefulWidget {
  const AllOffersScreen({super.key});

  @override
  State<AllOffersScreen> createState() => _AllOffersScreenState();
}

class _AllOffersScreenState extends State<AllOffersScreen> {
  @override
  void initState() {
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.pageNumber =1;
    homeCubit.offers(
        productCategories: null,
        storeCategories: null
    );
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
              return Scaffold(
                floatingActionButton: DefaultIconButton(
                    icon: const Icon(Icons.filter_list,color: ColorsManager.mainColor,),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const FilterOfferDialog();
                          },
                      );
                    },
                ),
                body: HideKeyboardPage(
                    child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            verticalSpace(1.h),
                            if(homeCubit.offersEntity != null && homeCubit.offersEntity!.data.offers!.data.isEmpty)
                              Center(
                                child: DefaultText(
                                    title: appBloc.translationModel!.noData,
                                    style: Style.headLarge
                                ),
                              ),
                            if(homeCubit.offersEntity == null)
                              const AllProductsLoading(),
                            if(homeCubit.offersEntity != null)
                              RefreshIndicator(
                                onRefresh: () async{
                                  homeCubit.offers(
                                      productCategories: null,
                                      storeCategories: null
                                  );
                                  await Future.delayed(const Duration(seconds: 2));
                                },
                                backgroundColor: Colors.transparent,
                                child: AnimationLimiter(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 80.h,
                                        child: SingleChildScrollView(
                                          physics: const AlwaysScrollableScrollPhysics(),
                                          child: Column(
                                            children: [
                                              GridView.builder(
                                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 2,
                                                    childAspectRatio: 1.w,
                                                    crossAxisSpacing: 1.w,
                                                    mainAxisExtent: 30.h,
                                                    mainAxisSpacing: 2.h
                                                ),
                                                physics: const NeverScrollableScrollPhysics(),
                                                shrinkWrap: true,
                                                itemCount: homeCubit.offersEntity!.data.offers!.data.length,
                                                itemBuilder: (BuildContext context, int index) {
                                                  return AnimationConfiguration.staggeredGrid(
                                                    columnCount: 2,
                                                    position: index,
                                                    duration: const Duration(milliseconds: 1000),
                                                    child: ScaleAnimation(
                                                      duration: const Duration(milliseconds: 1000),
                                                      curve: Curves.fastLinearToSlowEaseIn,
                                                      scale: 1.5,
                                                      child: FadeInAnimation(
                                                        child: StoresCards(
                                                            storeLogo: homeCubit.offersEntity!.data.offers!.data[index].logoPath,
                                                            storeName: homeCubit.offersEntity!.data.offers!.data[index].shopName,
                                                            shopID: homeCubit.offersEntity!.data.offers!.data[index].id,
                                                            rates: homeCubit.offersEntity!.data.offers!.data[index].rate
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                              if(homeCubit.offersEntity!.data.offers!.lastPage >1)
                                                NumberPagination(
                                                  onPageChanged: (pageNumber){
                                                    homeCubit.changePageNumber(page: pageNumber);
                                                    homeCubit.offers(
                                                      storeCategories: homeCubit.selectedCategoriesStoresName != null ? [homeCubit.selectedCategoriesStoresName!] : null,
                                                      productCategories: homeCubit.selectedCategoriesProductsName != null ? [homeCubit.selectedCategoriesProductsName!] : null,
                                                    );
                                                  },
                                                  pageTotal: homeCubit.offersEntity!.data.offers!.lastPage,
                                                  colorPrimary: ColorsManager.mintGreen,
                                                  colorSub: ColorsManager.warning,
                                                  threshold: 4,
                                                  buttonSpacing: 5.rSp,
                                                  fontSize: 12.rSp,
                                                  buttonElevation: 5.rSp,
                                                  buttonRadius: 20.rSp,
                                                  groupSpacing: 10.rSp,
                                                  fontFamily: 'splash',
                                                  pageInit: homeCubit.pageNumber,

                                                ),
                                              verticalSpace(2.h),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        )
                    )
                ),
              );
            },
        )
    );
  }
}
