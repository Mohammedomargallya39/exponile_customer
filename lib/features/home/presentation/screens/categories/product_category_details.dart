import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/features/home/presentation/controller/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../../core/util/cubit/cubit.dart';
import '../../../../../core/util/loading_files/all_product_loading.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/default_text.dart';
import '../../../../../core/util/widgets/hideKeyboard.dart';
import '../../../../../core/util/widgets/main_appbar.dart';
import '../../controller/cubit.dart';
import '../product_screen/product_card.dart';
import '../product_screen/show_product_details.dart';

class ProductCategoryDetails extends StatefulWidget {
  const ProductCategoryDetails({super.key,required this.productCategorySlug});
  final String productCategorySlug;

  @override
  State<ProductCategoryDetails> createState() => _ProductCategoryDetailsState();
}

class _ProductCategoryDetailsState extends State<ProductCategoryDetails> {


  @override
  void initState() {
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.productCategoryDetails(slug: widget.productCategorySlug);
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
                  title: appBloc.translationModel!.productsCategory,
                  isBack: true,
                  isLang: false
              ),
              body: HideKeyboardPage(
                  child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          verticalSpace(1.h),
                          if(homeCubit.productCategoryDetailsEntity != null && homeCubit.productCategoryDetailsEntity!.data.isEmpty)
                            Center(
                              child: DefaultText(
                                  title: appBloc.translationModel!.noData,
                                  style: Style.headLarge
                              ),
                            ),
                          if(homeCubit.productCategoryDetailsEntity == null)
                            const AllProductsLoading(),
                          if(homeCubit.productCategoryDetailsEntity != null)
                            RefreshIndicator(
                              onRefresh: () async{
                                homeCubit.productCategoryDetails(
                                    slug: widget.productCategorySlug
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
                                              physics: const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemCount: homeCubit.productCategoryDetailsEntity!.data.length,
                                              gridDelegate:
                                              SliverGridDelegateWithMaxCrossAxisExtent(
                                                childAspectRatio:
                                                (MediaQuery.of(context).size.width) / (MediaQuery.of(context).size.height / 1.4),
                                                mainAxisSpacing: 5,
                                                crossAxisSpacing: 5,
                                                maxCrossAxisExtent: MediaQuery.of(context).size.width / 2,
                                              ),
                                              itemBuilder: (context, index) {
                                                return Padding(
                                                  padding: EdgeInsets.symmetric(horizontal: 1.w),
                                                  child: ProductCard(
                                                    category: homeCubit.productCategoryDetailsEntity!.data[index].getCategory.name!,
                                                    name: homeCubit.productCategoryDetailsEntity!.data[index].name ?? '',
                                                    newPrice: '${homeCubit.productCategoryDetailsEntity!.data[index].basicPrice}',
                                                    rate: homeCubit.productCategoryDetailsEntity!.data[index].rate!,
                                                    imagePath: homeCubit.productCategoryDetailsEntity!.data[index].images,
                                                    isFavourite:false,
                                                    onProductTap: () {
                                                      navigateTo(context, ShowProductDetails(
                                                          productID: homeCubit.productCategoryDetailsEntity!.data[index].id!
                                                      ));
                                                    },
                                                    onFavoriteTap: () {
                                                      homeCubit.addFavourite(
                                                        itemType: 'product',
                                                        itemID: homeCubit.productCategoryDetailsEntity!.data[index].id!,
                                                      );
                                                    },
                                                    imagesCount: homeCubit.productCategoryDetailsEntity!.data[index].images.length,
                                                    ratingCount: homeCubit.productCategoryDetailsEntity!.data[index].ratingsCount!,
                                                    offer: homeCubit.productCategoryDetailsEntity!.data[index].offers.isNotEmpty && homeCubit.productCategoryDetailsEntity!.data[index].offers[0].setupType == '1' ? '-${homeCubit.productCategoryDetailsEntity!.data[index].offers[0].value} %':null,
                                                    offerType: homeCubit.productCategoryDetailsEntity!.data[index].offers.isNotEmpty? int.parse(homeCubit.productCategoryDetailsEntity!.data[index].offers[0].value!) : null,
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
