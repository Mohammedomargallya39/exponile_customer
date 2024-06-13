import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/features/home/presentation/screens/categories/product_categories.dart';
import 'package:exponile_customer/features/home/presentation/screens/categories/store_categories.dart';
import 'package:flutter/material.dart';
import '../../../../../core/util/cubit/cubit.dart';
import '../../../../../core/util/resources/colors_manager.dart';
import '../../controller/cubit.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesState();
}

class _CategoriesState extends State<CategoriesScreen>  with SingleTickerProviderStateMixin{

  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc.get(context);
    return Directionality(
      textDirection: appBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: appBloc.translationModel!.storesCategories,),
              Tab(text: appBloc.translationModel!.productsCategory,),
            ],
            labelStyle: TextStyle(
                color: ColorsManager.black,
                fontSize: 12.rSp,
                fontWeight: FontWeight.bold
            ),
            labelColor: ColorsManager.mainColor,
            unselectedLabelColor: ColorsManager.black.withOpacity(0.6),
            indicatorColor: ColorsManager.mainColor,
            labelPadding: EdgeInsets.symmetric(horizontal: 2.w),
            isScrollable: false,
            padding: EdgeInsets.symmetric(horizontal: 0.w,vertical: 1.h),
          ),
          Expanded(
            child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: const [
                  StoreCategories(),
                  ProductCategories(),
                ]
            ),
          ),
        ],
      ),
    );
  }
}
