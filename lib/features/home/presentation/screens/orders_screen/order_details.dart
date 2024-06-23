import 'package:exponile_customer/core/util/widgets/main_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/util/cubit/cubit.dart';
import '../../controller/cubit.dart';
import '../../controller/state.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key, required this.orderNumber});

  final String orderNumber;

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {

  @override
  void initState() {
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.orderDetails(
      orderNumber: widget.orderNumber
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc.get(context);
    HomeCubit homeCubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        },
      builder: (context, state) {
        return Scaffold(
          appBar: MainAppBar(
              title: appBloc.translationModel!.orderDetails,
              isBack: true,
              isLang: false
          ),
          body: Container(),
        );
      },
    );
  }
}
