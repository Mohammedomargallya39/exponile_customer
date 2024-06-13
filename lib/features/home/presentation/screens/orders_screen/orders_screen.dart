import 'package:exponile_customer/core/util/loading_files/all_product_loading.dart';
import 'package:exponile_customer/core/util/resources/colors_manager.dart';
import 'package:exponile_customer/features/home/presentation/controller/cubit.dart';
import 'package:exponile_customer/features/home/presentation/controller/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/util/cubit/cubit.dart';
import '../categories/product_categories.dart';
import 'order_list.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {

  @override
  void initState() {
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.pageNumber =1;
    homeCubit.orders(
     status: null
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
            floatingActionButton: IconButton(
                icon: const Icon(Icons.filter_list,color: ColorsManager.mainColor,),
                onPressed: (){

                },
            ),
            body: homeCubit.ordersEntity != null ?const OrderList(): const AllProductsLoading(),
          );
        },
      ),
    );
  }
}
