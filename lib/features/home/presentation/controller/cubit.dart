import 'package:exponile_customer/core/util/resources/assets.gen.dart';
import 'package:exponile_customer/features/home/presentation/controller/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/main_search_entity.dart';
import '../../domain/usecase/main_search_product_usecase.dart';

class HomeCubit extends Cubit<HomeState> {
   final MainSearchProductUseCase _mainSearchProductUseCase;
  HomeCubit(
      {
    required MainSearchProductUseCase mainSearchProductUseCase,
  }
  ) :
       _mainSearchProductUseCase = mainSearchProductUseCase,


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

  TextEditingController mainSearchController = TextEditingController();


  Map<String, String> filterMainSearch = {};
  String? selectedMainSearchName;
  String? selectedMainSearchType;

  void selectSearchType({
    required String? mainSearchName,
    required String? mainSearchType,
  }){
    emit(InitState());
    selectedMainSearchName = mainSearchName;
    selectedMainSearchType = mainSearchType;
    emit(ChangeState());
  }
  List<String> mainSearchImages=[
    Assets.images.svg.product,
    Assets.images.svg.shop,
  ];


   MainSearchProductEntity? mainSearchProductEntity;
   void mainSearchProduct({
     required String searchText,
   }) async {
     emit(MainSearchProductsLoadingState());
     final result = await _mainSearchProductUseCase(
         MainSearchProductParams(
             searchText: searchText,
         )
     );
     result.fold((failure) {
       emit(MainSearchProductsErrorState(
           failure: mapFailureToMessage(failure)
       ));
     }, (data) {
       mainSearchProductEntity = data;
       emit(MainSearchProductsSuccessState(
           mainSearchProductEntity: data
       ));
     });
   }




}