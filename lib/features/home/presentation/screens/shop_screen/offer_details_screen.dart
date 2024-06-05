import "package:cached_network_image/cached_network_image.dart";
import "package:exponile_customer/core/util/cubit/cubit.dart";
import "package:exponile_customer/core/util/loading_files/all_product_loading.dart";
import "package:exponile_customer/core/util/loading_files/offer_loading.dart";
import "package:exponile_customer/core/util/resources/colors_manager.dart";
import "package:exponile_customer/core/util/resources/extensions_manager.dart";
import "package:exponile_customer/core/util/widgets/default_text.dart";
import "package:exponile_customer/core/util/widgets/main_appbar.dart";
import "package:exponile_customer/core/util/widgets/my_icon_button.dart";
import "package:exponile_customer/features/home/presentation/controller/state.dart";
import "package:exponile_customer/features/home/presentation/screens/product_screen/show_product_details.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";
import "../../../../../core/di/injection.dart";
import "../../../../../core/util/resources/assets.gen.dart";
import "../../../../../core/util/resources/constants_manager.dart";
import "../../../../../core/util/widgets/progress.dart";
import "../../controller/cubit.dart";
import "offers/buy_get_product_card.dart";
import "offers/offer_products_card.dart";
import "offers/offer_store_details_card.dart";

class OfferDetailsScreen extends StatefulWidget {
  const OfferDetailsScreen({super.key, required this.offerId, this.storeCategories});
  final int offerId;
  final dynamic storeCategories;
  @override
  State<OfferDetailsScreen> createState() => _OfferDetailsScreenState();
}

class _OfferDetailsScreenState extends State<OfferDetailsScreen> {
  var id = 0;
  var productId = 0;
  var feature1Index = 0;
  var feature2Index = 0;
  var productQty=1;
  List<String> storeCategoryList = [];
  String storeCategories = "";
 
  List<Map<String, dynamic>> allList = [];
  List<Map<String, dynamic>> buyList = [];
  List<Map<String, dynamic>> getList = [];
  @override
  void initState() {
    id = widget.offerId;
    storeCategoryList = widget.storeCategories;
    storeCategories = [for (var data in (storeCategoryList)) data].join(",");
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.storeOfferDetails(offerID: widget.offerId);
    homeCubit.isChangedFavouriteIcon = false;

    super.initState();
  }


  var imgIndex = 0;

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc.get(context);
    HomeCubit homeCubit = HomeCubit.get(context);

    return Directionality(
      textDirection: appBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: BlocConsumer<HomeCubit,HomeState>(
        listener: (context, state) {
          if(state is  AddOfferToCartLoadingState){
            showDialog(
              context: context,
              builder: (context) {
                return ProgressDialog(message: appBloc.translationModel!.loading);
              },
            );
          }
          if (state is AddOfferToCartErrorState) {
            Navigator.pop(context);
            designToastDialog(
                context: context,
                toast: TOAST.error,
                text: state.failure.toString());
          }
          if (state is AddOfferToCartSuccessState && state.addOfferToCartEntity.success == 0) {
            Navigator.pop(context);
            designToastDialog(
                context: context,
                toast: TOAST.error,
                text: state.addOfferToCartEntity.message!
            );
          }
          if (state is AddOfferToCartSuccessState && state.addOfferToCartEntity.success == 1) {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
            designToastDialog(
                context: context,
                toast: TOAST.success,
                text: state.addOfferToCartEntity.message!
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
              appBar: MainAppBar(
                  title: appBloc.translationModel!.offerDetails,
                  isBack: true,
                  isLang: false
              ),
              body:  homeCubit.storeOfferDetailsEntity == null ?
              const OfferDetailsLoading() :
              homeCubit.storeOffersEntity!.data!.offers.isEmpty ?
              Center(
                  child: svgImage(
                      path: Assets.images.svg.noImage
                  )
              ):
              SingleChildScrollView(
                child: homeCubit.storeOfferDetailsEntity!.data!.offer!.type == 3
                    ? Column(
                  children: [
                    OfferStoreDetailsCard(
                      storeCategories: storeCategories,
                      storeName: homeCubit.storeOfferDetailsEntity!.data!.offer!.getShop!.shopName ?? "",
                      storeRate: homeCubit.storeOfferDetailsEntity!.data!.offer!.getShop!.rate ?? "",
                      storeLogo: homeCubit.storeOfferDetailsEntity!.data!.offer!.getShop!.logoPath ?? "",
                      offerPath: homeCubit.storeOfferDetailsEntity!.data!.offer!.bannerPath ?? "",
                      isFavorite: homeCubit.storeOfferDetailsEntity!.data!.offer!.getShop!.favorites!.isNotEmpty ? true : false,
                      storeAddToFav:   () async {
                        homeCubit.addFavourite(
                          itemType: 'store',
                          itemID: homeCubit.storeOfferDetailsEntity!.data!.offer!.getShop!.id!,
                        );
                        homeCubit.changedFavouriteIcon();
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.rSp),
                      child: Row(
                        children: [
                          Icon(Icons.card_giftcard,
                              color: ColorsManager.mainColor, size: 30.rSp),
                          DefaultText(
                              title: homeCubit.storeOfferDetailsEntity!.data!.offer!.name!.toUpperCase(),
                              style: Style.medium,
                              fontSize: 16.rSp,
                              fontWeight: FontWeight.bold,
                              color: ColorsManager.mainColor,
                          ),
                        ],
                      ),
                    ),
                    verticalSpace(3.h),
                    Center(
                      child: svgImage(path: Assets.images.svg.free),
                    ),
                  ],
                )
                    : Column(
                  children: [
                    OfferStoreDetailsCard(
                      storeCategories: storeCategories,
                      storeName: homeCubit.storeOfferDetailsEntity!.data!.offer!.getShop!.shopName ?? "",
                      storeRate: homeCubit.storeOfferDetailsEntity!.data!.offer!.getShop!.rate ?? "",
                      storeLogo: homeCubit.storeOfferDetailsEntity!.data!.offer!.getShop!.logoPath ?? "",
                      offerPath: homeCubit.storeOfferDetailsEntity!.data!.offer!.bannerPath ?? "",
                      isFavorite: homeCubit.storeOfferDetailsEntity!.data!.offer!.getShop!.favorites!.isNotEmpty ? true : false,
                      storeAddToFav:   () async {
                        homeCubit.addFavourite(
                          itemType: 'store',
                          itemID: homeCubit.storeOfferDetailsEntity!.data!.offer!.getShop!.id!,
                        );
                        homeCubit.changedFavouriteIcon();
                      },

                    ),
                    Padding(
                      padding: EdgeInsets.all(5.rSp),
                      child: Row(
                        children: [
                          Icon(Icons.card_giftcard,
                              color: ColorsManager.mainColor, size: 30.rSp),
                              if(homeCubit.storeOfferDetailsEntity!.data!.offer!.type == 2)
                              Row(
                            children: [
                              DefaultText(
                                title: " ${appBloc.translationModel!.buy}  ${homeCubit.storeOfferDetailsEntity!.data!.offer!.buyAmount} ${appBloc.translationModel!.get} ${homeCubit.storeOfferDetailsEntity!.data!.offer!.getAmount} ",
                                style: Style.medium,
                                fontSize: 16.rSp,
                                fontWeight: FontWeight.bold,
                                color: ColorsManager.mainColor,
                              ),
                              horizontalSpace(2.w),
                              DefaultText(
                                title: " *${appBloc.translationModel!.total}  ${homeCubit.storeOfferDetailsEntity!.data!.offer!.buyAmount! + homeCubit.storeOfferDetailsEntity!.data!.offer!.getAmount!}*",
                                style: Style.medium,
                                fontSize: 16.rSp,
                                fontWeight: FontWeight.bold,
                                color: ColorsManager.mainColor,
                              ),
                            ],
                          )

                        ],
                      ),
                    ),
                   if(homeCubit.storeOfferDetailsEntity!.data!.offer!.type == 2)
                   Card(
                      elevation: 2,
                      shadowColor: ColorsManager.darkGrey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if(buyList.isNotEmpty)
                          Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(5.rSp),
                                  child: DefaultText(
                                    title: "${appBloc.translationModel!.buy} ${appBloc.translationModel!.products}".toUpperCase(),
                                    style: Style.medium,
                                    fontSize: 16.rSp,
                                    fontWeight: FontWeight.bold,
                                    color: ColorsManager.mainColor,
                                  ),
                                ),
                                SizedBox(
                                  height: 320.rSp,
                                  width: double.infinity,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                      const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: homeCubit.storeOfferDetailsEntity!.data!.offer!.buyAmount,
                                      itemBuilder: (BuildContext context, int index) {
                                        return index > buyList.length - 1
                                            ? const AllProductsLoading()
                                            : BuyGetProductCard(
                                          isGet: false,
                                          productName: buyList[index]["name"] ?? "",
                                          getProductPrice: '0.00 ${appBloc.translationModel!.currency}',
                                          productPrice: "${buyList[index]["price"]} EGP",
                                          productImagePath: buyList[index]["image"] ?? " http://jinjamart.com/app/current/public/storage/jinja/categories/104/NaJQOaZfT1Kg03sy4KdDRYtV4pspw16PWgyrXGy7.jpg",
                                          onDeleteTap: () {
                                            setState(() {
                                              buyList.removeAt(index);
                                              allList =
                                                  buyList + getList;
                                              allList.sort((buyList,
                                                  getList) =>
                                                  (double.parse(getList[
                                                  "price"]!))
                                                      .compareTo(double
                                                      .parse(buyList[
                                                  "price"]!)));
                                              buyList.clear();
                                              getList.clear();
                                              for (var element in allList) {
                                                if (buyList.length ==
                                                    homeCubit.storeOfferDetailsEntity!
                                                        .data
                                                    !.offer
                                                    !.buyAmount) {
                                                  if (getList
                                                      .length ==
                                                      homeCubit.storeOfferDetailsEntity!
                                                          .data
                                                      !.offer
                                                      !.getAmount) {
                                                  } else {
                                                    element['isGet']='true';
                                                    element['price']=element['old_price'];
                                                    getList.add(element);
                                                  }
                                                } else {
                                                  element['isGet']='false';
                                                  element['price']=element['old_price'];
                                                  buyList.add(element);
                                                }
                                              }
                                            });
                                          },
                                        );
                                      }),
                                ),
                              ],
                            ),

                          if(getList.isNotEmpty)
                          Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(5.rSp),
                                  child:
                                  DefaultText(
                                    title: "${appBloc.translationModel!.get} ${appBloc.translationModel!.products}".toUpperCase(),
                                    style: Style.medium,
                                    fontSize: 16.rSp,
                                    fontWeight: FontWeight.bold,
                                    color: ColorsManager.mainColor,
                                  ),
                                ) ,
                                SizedBox(
                                  height: 320.rSp,
                                  width: double.infinity,
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                      const BouncingScrollPhysics(),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: homeCubit.storeOfferDetailsEntity!.data!.offer!.getAmount,
                                      itemBuilder: (BuildContext context, int index) {
                                        return index > getList.length - 1
                                            ? const AllProductsLoading()
                                            : BuyGetProductCard(
                                          isGet: true,
                                          productName: getList[index]["name"] ?? "",
                                          getProductPrice:
                                          double.parse(getList[index]["price"] ?? "").toStringAsFixed(2),
                                          productPrice: "${getList[index]["old_price"]} EGP",
                                          productImagePath: getList[index]["image"] ?? " http://jinjamart.com/app/current/public/storage/jinja/categories/104/NaJQOaZfT1Kg03sy4KdDRYtV4pspw16PWgyrXGy7.jpg",
                                          onDeleteTap: () {
                                            setState(() {
                                              getList.removeAt(index);
                                              allList =
                                                  buyList + getList;

                                              allList.sort((buyList,
                                                  getList) =>
                                                  (double.parse(getList[
                                                  "price"]!))
                                                      .compareTo(double
                                                      .parse(buyList[
                                                  "price"]!)));
                                              buyList.clear();
                                              getList.clear();
                                              for (var element in allList) {
                                                if (buyList.length ==
                                                    homeCubit.storeOfferDetailsEntity!
                                                        .data
                                                    !.offer
                                                    !.buyAmount) {
                                                  if (getList
                                                      .length ==
                                                      homeCubit.storeOfferDetailsEntity!
                                                          .data
                                                      ! .offer
                                                      !.getAmount) {
                                                  } else {
                                                    getList
                                                        .add(element);
                                                  }
                                                } else {
                                                  buyList
                                                      .add(element);
                                                }
                                              }
                                            });
                                          },
                                        );
                                      }),
                                ) ,
                                verticalSpace(1.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (productQty == 1) {
                                            productQty= 1;
                                          } else {
                                            productQty--;
                                          }
                                        });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(horizontal: 5.rSp),
                                        width: 35.rSp,
                                        height: 35.rSp,
                                        decoration: BoxDecoration(
                                            color: ColorsManager.darkColor, borderRadius: BorderRadius.circular(40.rSp)),
                                        child: Center(
                                          child: Text(
                                            "-",
                                            style: TextStyle(
                                                color: ColorsManager.black,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 26.rSp),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 5.rSp),
                                      width: 35.rSp,
                                      height: 35.rSp,
                                      decoration: BoxDecoration(
                                          border: Border.all(color: ColorsManager.darkGrey),
                                          borderRadius: BorderRadius.circular(0)),
                                      child: Center(
                                        child: Text(
                                          productQty.toString(),
                                          style: TextStyle(
                                              color: ColorsManager.black,
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16.rSp),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          productQty++;
                                        });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(horizontal: 5.rSp),
                                        width: 35.rSp,
                                        height: 35.rSp,
                                        decoration: BoxDecoration(
                                            color: ColorsManager.darkGrey, borderRadius: BorderRadius.circular(40.rSp)),
                                        child: Center(
                                          child: Text(
                                            "+",
                                            style: TextStyle(
                                                color: ColorsManager.black,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 26.rSp),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                verticalSpace(1.h),
                                DefaultIconButton(
                                    icon: const Icon(Icons.add_shopping_cart),
                                    onPressed: (){
                                      homeCubit.addOfferToCart(
                                          qty: productQty,
                                          offerSlug: homeCubit.storeOfferDetailsEntity!.data!.offer!.slug??"",
                                          offerProducts: allList);
                                    }
                                ),
                              ],
                            )
                        ],
                      ),
                    ),

                    verticalSpace(1.h),
                    GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: homeCubit.storeOfferDetailsEntity!.data!.products!.length,
                        gridDelegate:
                        SliverGridDelegateWithMaxCrossAxisExtent(
                          childAspectRatio: (MediaQuery.of(context).size.width) / (MediaQuery.of(context).size.height / 1.25),
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          maxCrossAxisExtent:
                          MediaQuery.of(context).size.width / 2,
                        ),
                        itemBuilder: (context, index) {
                          return OfferProductsCard(
                            productCategory: homeCubit.storeOfferDetailsEntity!.data!.products![index].getCategory!.name ?? "",
                            productName: homeCubit.storeOfferDetailsEntity!.data!.products![index].name ?? "",
                            offerType: homeCubit.storeOfferDetailsEntity!.data!.offer!.type ?? 0,
                            offers: homeCubit.storeOfferDetailsEntity!.data!.products![index].offers!,
                            value: homeCubit.storeOfferDetailsEntity!.data!.products![index].offers!.isNotEmpty ? homeCubit.storeOfferDetailsEntity!.data!.products![index].offers![0].value! : 0,
                            oldPrice: homeCubit.storeOfferDetailsEntity!.data!.products![index].basicPrice ?? "",
                            productImage: homeCubit.storeOfferDetailsEntity!.data!.products![index].images![0].imagePath ?? "",
                            productRate: homeCubit.storeOfferDetailsEntity!.data!.products![index].rate ?? "",
                            productRateNumber: homeCubit.storeOfferDetailsEntity!.data!.products![index].ratings!.length,
                            percentageValue: homeCubit.storeOfferDetailsEntity!.data!.offer!.type == 1 ? "-${homeCubit.storeOfferDetailsEntity!.data!.products![index].offers![0].value.toString()}%" : "",
                            isFavorite: homeCubit.storeOfferDetailsEntity!.data!.products![index].favorites!.isNotEmpty ? true : false,
                            onProductTap: homeCubit.storeOfferDetailsEntity!.data!.offer!.type == 1? () {
                              navigateTo(context, ShowProductDetails(
                                  productID: homeCubit.storeOfferDetailsEntity!.data!.products![index].id!)
                              );
                            }:
                                () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(builder: (BuildContext
                                  context, StateSetter setState /*You can rename this!*/) {
                                    return BlocProvider(
                                      create: (BuildContext context) => sl<HomeCubit>()..productDetails(
                                        productID: homeCubit.storeOfferDetailsEntity!.data!.products![index].id!,
                                      ),
                                      child: BlocBuilder<HomeCubit, HomeState>(
                                          builder: (context, state) {
                                            HomeCubit cubit = HomeCubit.get(context);
                                            if (state is ProductDetailsLoadingState) {
                                              return SizedBox(
                                                height: MediaQuery.of(context).size.height,
                                                child: Center(
                                                  child: Scaffold(
                                                    backgroundColor: ColorsManager.whiteColor,
                                                    body: Center(
                                                      child: svgImage(path: Assets.images.svg.noImage),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return SizedBox(
                                                height: MediaQuery.of(context).size.height,
                                                child: SingleChildScrollView(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Container(),
                                                          Padding(
                                                            padding: EdgeInsets.all(5.rSp),
                                                            child: CircleAvatar(
                                                              backgroundColor:
                                                              ColorsManager.error,
                                                              child: InkWell(
                                                                  onTap: () {
                                                                    Navigator.pop(context, true);
                                                                  },
                                                                  child:
                                                                  Icon(
                                                                    Icons.close,
                                                                    color: ColorsManager.whiteColor,
                                                                    size: 25.rSp,
                                                                  )),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: MediaQuery.of(context).size.height / 2.1,
                                                        width: MediaQuery.of(context).size.width,
                                                        child: ListView.builder(
                                                          //     controller: _scrollController,
                                                          shrinkWrap: true,
                                                          scrollDirection: Axis.horizontal,
                                                          itemCount: cubit.images[cubit.selectedImages]!.length,
                                                          //stocksProvider!.response!.data.product.images.length,
                                                          itemBuilder:(context, index) {
                                                            return Stack(
                                                              children: [
                                                                SizedBox(
                                                                  height: MediaQuery.of(context).size.height / 1.5,
                                                                  width: MediaQuery.of(context).size.width,
                                                                  child: CachedNetworkImage(
                                                                    imageUrl: cubit.images[cubit.selectedImages]![index] ,
                                                                    imageBuilder: (context, imageProvider) => Container(
                                                                      decoration: BoxDecoration(
                                                                        image: DecorationImage(
                                                                            image: imageProvider, fit: BoxFit.contain),
                                                                      ),
                                                                    ),
                                                                    errorWidget: (context, url, error) => Container(
                                                                        height: MediaQuery.of(context).size.height / 1.5,
                                                                        width: MediaQuery.of(context).size.width,
                                                                        decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.only(
                                                                              topLeft: Radius.circular(20.rSp),
                                                                              topRight: Radius.circular(20.rSp)),
                                                                        ),
                                                                        child: svgImage(path: Assets.images.svg.noImage)
                                                                    ),
                                                                    placeholder: (context, url) => Container(
                                                                      color: Colors.black.withOpacity(0.5),
                                                                    ),
                                                                    fit: BoxFit.contain,
                                                                  ),
                                                                ),
                                                                Positioned(
                                                                  left: 0,
                                                                  bottom: 0,
                                                                  child: Container(
                                                                    height: 4.h,
                                                                    width:15.w,
                                                                    padding:EdgeInsets.all(5.rSp),
                                                                    margin:EdgeInsets.all(10.rSp),
                                                                    decoration: BoxDecoration(
                                                                        color: ColorsManager.mintGreen.withOpacity(0.5),
                                                                        borderRadius: BorderRadius.all(Radius.circular(10.rSp)),
                                                                        border: Border.all(color: ColorsManager.black.withOpacity(0.2),width: 1.rSp)
                                                                    ),
                                                                    child: Center(
                                                                      child: DefaultText(
                                                                        title: '${index+1}/${cubit.images[cubit.selectedImages]!.length}',
                                                                        style: Style.small,
                                                                        fontWeight: FontWeight.w700,
                                                                        fontSize: 12.rSp,
                                                                        color: ColorsManager.whiteColor
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      verticalSpace(1.h),
                                                      Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.h),
                                                        child: Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                DefaultText(
                                                                    title: cubit.productDetailsEntity!.data!.product!.name!,
                                                                    style: Style.small,
                                                                    fontWeight: FontWeight.w700,
                                                                    fontSize: 12.rSp,
                                                                    color: ColorsManager.whiteColor
                                                                ),
                                                                const Spacer(),
                                                                DefaultText(
                                                                    title: cubit.productDetailsEntity!.data!.product!.getCategory!.name!,
                                                                    style: Style.small,
                                                                    fontWeight: FontWeight.w700,
                                                                    fontSize: 12.rSp,
                                                                    color: ColorsManager.whiteColor
                                                                ),
                                                              ],
                                                            ),
                                                            verticalSpace(1.h),
                                                            DefaultText(
                                                                title: cubit.productDetailsEntity!.data!.product!.description!,
                                                                style: Style.small,
                                                                fontWeight: FontWeight.w700,
                                                                fontSize: 12.rSp,
                                                                color: ColorsManager.whiteColor
                                                            ),
                                                            verticalSpace(1.h),
                                                            RatingBar.builder(
                                                              initialRating: double.parse(cubit.productDetailsEntity!.data!.product!.rate!),
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
                                                            verticalSpace(1.h),
                                                            // Row(
                                                            //   mainAxisAlignment: MainAxisAlignment.center,
                                                            //   children: [
                                                            //     Align(
                                                            //       alignment: lang == 'en' ? Alignment.centerLeft:Alignment.centerRight,
                                                            //       child: textUtils(
                                                            //           text: '${cubit.productDetailsModel!.data.product.offers.isEmpty ?
                                                            //           cubit.productModel!.data!.featuresDetails![cubit.featureIndex].price :
                                                            //           cubit.productDetailsModel!.data.product.offers[0].setupType != 'percentage' ? cubit.productModel!.data!.featuresDetails![cubit.featureIndex].price:
                                                            //           double.parse(cubit.productModel!.data!.featuresDetails![cubit.featureIndex].price!) / (100/cubit.productDetailsModel!.data.product.offers[0].value!)
                                                            //           } ${localization.egp}',
                                                            //           fontSize: 12.rSp,
                                                            //           underLine: TextDecoration.none,
                                                            //           fontWeight: FontWeight.bold,
                                                            //           textColor: blackClr
                                                            //       ),
                                                            //     ),
                                                            //     space(width: 2.w,),
                                                            //     Container(
                                                            //       width: 1.rSp,
                                                            //       height: 2.h,
                                                            //       color: Colors.grey,
                                                            //     ),
                                                            //     space(width: 2.w,),
                                                            //     Align(
                                                            //       alignment: lang == 'en' ? Alignment.centerLeft:Alignment.centerRight,
                                                            //       child: textUtils(
                                                            //           text: '${cubit.productModel!.data!.featuresDetails![cubit.featureIndex].quantity} ',
                                                            //           fontSize: 12.rSp,
                                                            //           underLine: TextDecoration.none,
                                                            //           fontWeight: FontWeight.bold,
                                                            //           textColor: blackClr
                                                            //       ),
                                                            //     ),
                                                            //     const Icon(Icons.production_quantity_limits),
                                                            //   ],
                                                            // ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 1.h),
                                                        child: Column(
                                                          children: [
                                                            if(homeCubit.productDetailsEntity!.data!.featuresDetails!.isNotEmpty && homeCubit.productDetailsEntity!.data!.featuresDetails![0].getSubfeature1!.getFeature != null && homeCubit.productDetailsEntity!.data!.featuresDetails![0].getSubfeature1!.getFeature!.feature != 4)
                                                              Column(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      DefaultText(
                                                                          title: cubit.productDetailsEntity!.data!.featuresDetails![0].getSubfeature1!.getFeature!.feature == 2 ?
                                                                            appBloc.translationModel!.color : cubit.productDetailsEntity!.data!.featuresDetails![0].getSubfeature1!.getFeature!.feature == 3 ?
                                                                            appBloc.translationModel!.size : appBloc.translationModel!.other,
                                                                          fontSize: 13.rSp,
                                                                          style: Style.small
                                                                      ),
                                                                      horizontalSpace(2.w),
                                                                      Expanded(
                                                                        child: SizedBox(
                                                                          // width: 20,
                                                                          height: 3.h,
                                                                          child: ListView.builder(
                                                                            itemCount: cubit.featuresMap.keys.length,
                                                                            shrinkWrap: true,
                                                                            scrollDirection: Axis.horizontal,
                                                                            itemBuilder: (context, index) {
                                                                              return InkWell(
                                                                                onTap: () {
                                                                                  cubit.selectedIndex = index;
                                                                                  cubit.selectedImages = cubit.images.keys.toList()[index];
                                                                                  cubit.currentIndex = 0;

                                                                                  for (var featureDetail in cubit.productDetailsEntity!.data!.featuresDetails!) {
                                                                                    int itemIndex = cubit.productDetailsEntity!.data!.featuresDetails!.indexOf(featureDetail);


                                                                                    if(
                                                                                    cubit.featuresMap.keys.toList()[index] == featureDetail.getSubfeature1!.name && cubit.featuresMap.values.toList()[index][cubit.currentIndex] == featureDetail.getSubfeature2!.name
                                                                                    ){
                                                                                      cubit.featureIndex = itemIndex;

                                                                                    }

                                                                                  }


                                                                                  setState(() {});
                                                                                },
                                                                                child: Container(
                                                                                    margin: EdgeInsets.symmetric(
                                                                                        horizontal: 2.w
                                                                                    ),
                                                                                    width: 16.w,
                                                                                    height: 6.h,
                                                                                    decoration: BoxDecoration(
                                                                                        borderRadius: BorderRadius.all(Radius.circular(10.rSp)),
                                                                                        border: Border.all(
                                                                                          width: 2.rSp,
                                                                                          color: cubit.selectedIndex == index? ColorsManager.darkGrey: ColorsManager.black.withOpacity(0.6),
                                                                                        ),
                                                                                        color: cubit.productDetailsEntity!.data!.featuresDetails![0].getSubfeature1!.getFeature!.feature == 2 ?
                                                                                        Color(int.parse('0xff${cubit.featuresMap.keys.toList()[index].replaceAll('#', '')}')) : Colors.transparent
                                                                                    ),
                                                                                    child: cubit.productDetailsEntity!.data!.featuresDetails![0].getSubfeature1!.getFeature!.feature == 2 ?
                                                                                    DefaultText(
                                                                                      title: '',
                                                                                      style: Style.small,
                                                                                      fontSize: 10.rSp,
                                                                                      fontWeight: FontWeight.w700,
                                                                                    ):
                                                                                    Center(
                                                                                      child:
                                                                                      DefaultText(
                                                                                        title: cubit.featuresMap.keys.toList()[index],
                                                                                        style: Style.small,
                                                                                        fontSize: 10.rSp,
                                                                                        fontWeight: FontWeight.w700,
                                                                                      ),
                                                                                    )
                                                                                ),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  verticalSpace(1.h),
                                                                ],
                                                              ),
                                                            if(homeCubit.productDetailsEntity!.data!.featuresDetails!.isNotEmpty && homeCubit.productDetailsEntity!.data!.featuresDetails![0].getSubfeature2!.getFeature != null && homeCubit.productDetailsEntity!.data!.featuresDetails![0].getSubfeature2!.getFeature!.feature != 4)
                                                              Column(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      DefaultText(
                                                                        title: cubit.productDetailsEntity!.data!.featuresDetails![0].getSubfeature2!.getFeature!.feature == 2 ?
                                                                        appBloc.translationModel!.color : cubit.productDetailsEntity!.data!.featuresDetails![0].getSubfeature2!.getFeature!.feature == 3 ?
                                                                        appBloc.translationModel!.size : appBloc.translationModel!.other,                                                                        style: Style.small,
                                                                        fontSize: 10.rSp,
                                                                        fontWeight: FontWeight.w700,
                                                                      ),
                                                                      horizontalSpace(4.w),
                                                                      Expanded(
                                                                        child: SizedBox(
                                                                          // width: 20,
                                                                          height: 3.h,
                                                                          child: ListView.builder(
                                                                            itemCount: cubit.featuresMap.values.toList()[cubit.selectedIndex].length,
                                                                            shrinkWrap: true,
                                                                            scrollDirection: Axis.horizontal,
                                                                            itemBuilder: (context, index) {
                                                                              return InkWell(
                                                                                onTap: () {
                                                                                  cubit.currentIndex = index;
                                                                                  cubit.selectedImages = cubit.images.keys.toList()[index];
                                                                                  for (var featureDetail in cubit.productDetailsEntity!.data!.featuresDetails!) {
                                                                                    int itemIndex = cubit.productDetailsEntity!.data!.featuresDetails!.indexOf(featureDetail);
                                                                                    if(
                                                                                    cubit.featuresMap.keys.toList()[cubit.selectedIndex] == featureDetail.getSubfeature1!.name
                                                                                        &&
                                                                                        cubit.featuresMap.values.toList()[cubit.selectedIndex][index] == featureDetail.getSubfeature2!.name
                                                                                    ){
                                                                                      cubit.featureIndex = itemIndex;
                                                                                    }

                                                                                  }

                                                                                  setState(() {});
                                                                                },
                                                                                child: Container(
                                                                                    margin: EdgeInsets.symmetric(
                                                                                        horizontal: 2.w
                                                                                    ),
                                                                                    width: 20.w,
                                                                                    height: 6.h,
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.all(Radius.circular(10.rSp)),
                                                                                      border: Border.all(
                                                                                        width: 1.rSp,
                                                                                        color: cubit.currentIndex == index? ColorsManager.darkGrey: ColorsManager.black.withOpacity(0.6),
                                                                                      ),
                                                                                      color: cubit.productDetailsEntity!.data!.featuresDetails![0].getSubfeature2!.getFeature!.feature == 2 ?
                                                                                      Color(int.parse('0xff${cubit.featuresMap.keys.toList()[index].replaceAll('#', '')}')) : Colors.transparent,
                                                                                    ),
                                                                                    child: cubit.productDetailsEntity!.data!.featuresDetails![0].getSubfeature2!.getFeature!.feature == 2 ?
                                                                                    DefaultText(
                                                                                      title: '',
                                                                                      style: Style.small,
                                                                                      fontSize: 10.rSp,
                                                                                      fontWeight: FontWeight.w700,
                                                                                    ):
                                                                                    Center(
                                                                                      child:
                                                                                      DefaultText(
                                                                                        title: cubit.featuresMap.values.toList()[cubit.selectedIndex][index],
                                                                                        style: Style.small,
                                                                                        fontSize: 10.rSp,
                                                                                        fontWeight: FontWeight.w700,
                                                                                      ),
                                                                                    )
                                                                                ),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  verticalSpace(1.h),
                                                                ],
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding: EdgeInsets.all(20.rw),
                                                        child: Container(
                                                          padding: EdgeInsets.symmetric(vertical: 2.h),
                                                          decoration:
                                                          BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10.rSp), color: ColorsManager.mainColor,
                                                          ),
                                                          child: InkWell(
                                                            onTap: () {
                                                              if (allList.length == homeCubit.storeOfferDetailsEntity!.data! .offer! .buyAmount! + homeCubit.storeOfferDetailsEntity!.data! .offer! .getAmount!.toInt()) {
                                                              } else {
                                                                if (homeCubit.storeOfferDetailsEntity!.data!.products![index].basicQuantity == 0) {
                                                                } else {
                                                                  homeCubit
                                                                      .storeOfferDetailsEntity!.data!.products![index].feature=="special"&&homeCubit
                                                                      .storeOfferDetailsEntity!.data!.offer!.setupType=='percentage'?
                                                                  allList.add({
                                                                    "product_slug": cubit.productDetailsEntity!.data!.product!.slug,
                                                                    "feature": cubit.productDetailsEntity!.data!.featuresDetails![cubit.featureIndex].id,
                                                                    "image": cubit.images[cubit.selectedImages]![0],
                                                                    "price": cubit.productDetailsEntity!.data!.featuresDetails![cubit.featureIndex].price,
                                                                    "old_price": cubit.productDetailsEntity!.data!.featuresDetails![cubit.featureIndex].price,
                                                                    "isGet":"",
                                                                  })
                                                                      :homeCubit.storeOfferDetailsEntity!.data!.products![index].feature=="special" &&
                                                                      homeCubit.storeOfferDetailsEntity!.data!.offer!.setupType=='product'?
                                                                  allList.add({
                                                                    "product_slug": cubit.productDetailsEntity!.data!.product!.slug,
                                                                    "feature": cubit.productDetailsEntity!.data!.featuresDetails![cubit.featureIndex].id,
                                                                    "image": cubit.images[cubit.selectedImages]![0],
                                                                    "price": cubit.productDetailsEntity!.data!.featuresDetails![cubit.featureIndex].price,
                                                                    "old_price": cubit.productDetailsEntity!.data!.featuresDetails![cubit.featureIndex].price,
                                                                    "isGet":"",
                                                                  })
                                                                      : homeCubit.storeOfferDetailsEntity!.data!.products![index].feature=="basic"&& homeCubit.storeOfferDetailsEntity!.data!.offer!.setupType=='percentage'
                                                                      ?
                                                                  allList.add({
                                                                    "product_slug": cubit.productDetailsEntity!.data!.product!.slug,
                                                                    "feature": cubit.productDetailsEntity!.data!.featuresDetails![cubit.featureIndex].id,
                                                                    "image": cubit.images[cubit.selectedImages]![0],
                                                                    "price": cubit.productDetailsEntity!.data!.featuresDetails![cubit.featureIndex].price,
                                                                    "old_price": cubit.productDetailsEntity!.data!.featuresDetails![cubit.featureIndex].price,
                                                                    "isGet":"",
                                                                  })
                                                                      :
                                                                  allList.add({
                                                                    "product_slug": cubit.productDetailsEntity!.data!.product!.slug,
                                                                    "feature": cubit.productDetailsEntity!.data!.featuresDetails![cubit.featureIndex].id,
                                                                    "image": cubit.images[cubit.selectedImages]![0],
                                                                    "price": cubit.productDetailsEntity!.data!.featuresDetails![cubit.featureIndex].price,
                                                                    "old_price": cubit.productDetailsEntity!.data!.featuresDetails![cubit.featureIndex].price,
                                                                    "isGet":"",
                                                                  });
                                                                  allList.sort((buyList, getList) => (double.parse(getList["price"]!)).compareTo(double.parse(buyList["price"]!)));
                                                                  buyList.clear();
                                                                  for (var element in allList) {
                                                                    if (buyList.length ==
                                                                        homeCubit.storeOfferDetailsEntity!
                                                                            .data
                                                                        ! .offer
                                                                        !.buyAmount) {
                                                                      if (getList.length == homeCubit.storeOfferDetailsEntity!.data!.offer!.getAmount) {
                                                                      } else {
                                                                        element['isGet']='true';
                                                                        getList.add(element);
                                                                      }
                                                                    } else {
                                                                      element['isGet']='false';
                                                                      element['price']=element['old_price'];
                                                                      buyList.add(element);
                                                                    }
                                                                  }

                                                                }
                                                              }
                                                              setState(() {
                                                                Navigator.pop(
                                                                    context,
                                                                    true);
                                                              });
                                                            },
                                                            child: Center(
                                                              child:
                                                                  DefaultText(
                                                                      title: appBloc.translationModel!.select,
                                                                      style: Style.small,
                                                                    fontSize: 16.rSp,
                                                                    fontWeight: FontWeight.w700,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            }
                                          }),
                                    );
                                  });
                                },
                              ).then((value) {
                                setState(() {});
                              });
                            },
                            onFavoriteTap: () {
                              homeCubit.addFavourite(
                                itemType: 'product',
                                itemID: homeCubit.storeOfferDetailsEntity!.data
                                !.products![index].id!,
                              );
                            },
                          );
                        })
                  ],
                ),
              ),
          );
        },
      ),
    );
  }
}
