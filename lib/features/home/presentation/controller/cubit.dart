import 'package:exponile_customer/features/home/presentation/controller/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
   // final WarehousesUseCase _warehousesUseCase;
  HomeCubit(
  //     {
  //   // required WarehousesUseCase warehousesUseCase,
  // }
  ) :
       // _warehousesUseCase = warehousesUseCase,


      super(Empty());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentNavIndex = 0;

  void changeNavBottomScreens(int index) {
    emit(InitState());
    currentNavIndex = index;
    emit(HomeChangeNavBottomScreensState());
  }

  List<Widget> customer = [
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
    Container(),
  ];

}