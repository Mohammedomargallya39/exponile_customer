import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/main_appbar.dart';
import 'package:exponile_customer/features/home/presentation/controller/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../../core/util/cubit/cubit.dart';
import '../../../../../core/util/loading_files/all_product_loading.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/default_text.dart';
import '../../../../../core/util/widgets/hideKeyboard.dart';
import '../../controller/cubit.dart';
import '../home/widgets/store_card.dart';

class StoreCategoryDetails extends StatefulWidget {
  const StoreCategoryDetails({super.key,required this.storeCategorySlug});
  final String storeCategorySlug;

  @override
  State<StoreCategoryDetails> createState() => _StoreCategoryDetailsState();
}

class _StoreCategoryDetailsState extends State<StoreCategoryDetails> {


  @override
  void initState() {
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.storeCategoryDetails(slug: widget.storeCategorySlug);
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
                appBar: MainAppBar(
                    title: appBloc.translationModel!.storesCategories,
                    isBack: true,
                    isLang: false
                ),
                body: HideKeyboardPage(
                    child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            verticalSpace(1.h),
                            if(homeCubit.storeCategoryDetailsEntity != null && homeCubit.storeCategoryDetailsEntity!.data.stores.data.isEmpty)
                              Center(
                                child: DefaultText(
                                    title: appBloc.translationModel!.noData,
                                    style: Style.headLarge
                                ),
                              ),
                            if(homeCubit.storeCategoryDetailsEntity == null)
                              const AllProductsLoading(),
                            if(homeCubit.storeCategoryDetailsEntity != null)
                              RefreshIndicator(
                                onRefresh: () async{
                                  homeCubit.storeCategoryDetails(
                                      slug: widget.storeCategorySlug
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
                                                itemCount: homeCubit.storeCategoryDetailsEntity!.data.stores.data.length,
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
                                                            storeLogo: homeCubit.storeCategoryDetailsEntity!.data.stores.data[index].logoPath!,
                                                            storeName: homeCubit.storeCategoryDetailsEntity!.data.stores.data[index].shopName!,
                                                            shopID: homeCubit.storeCategoryDetailsEntity!.data.stores.data[index].id!,
                                                            rates: homeCubit.storeCategoryDetailsEntity!.data.stores.data[index].rate!
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
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
