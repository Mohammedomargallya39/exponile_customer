import 'package:exponile_customer/features/home/presentation/controller/state.dart';
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
                body: ListView.builder(
                    itemCount: homeCubit.homeWidgets.length,
                    itemBuilder: (context, index) {
                      return homeCubit.homeWidgets[index];
                    },
                ),
              );
            },
        ),
    );
  }
}
