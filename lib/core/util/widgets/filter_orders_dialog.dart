import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../features/home/presentation/controller/cubit.dart';
import '../../../features/home/presentation/controller/state.dart';
import '../cubit/cubit.dart';
import '../resources/colors_manager.dart';
import '../resources/constants_manager.dart';
import 'default_button.dart';
import 'default_text.dart';
import 'default_text_field.dart';
import 'hideKeyboard.dart';
import 'my_icon_button.dart';

class FilterOrdersDialog extends Dialog {
  
   const FilterOrdersDialog({super.key,});


  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = AppBloc.get(context);
    HomeCubit homeCubit = HomeCubit.get(context);
    return BlocBuilder<HomeCubit,HomeState>(
      builder: (context, state) {
        return Dialog(
          backgroundColor: ColorsManager.whiteColor,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          //this right here
          child: HideKeyboardPage(
            child: SizedBox(
              height: 30.h,
              width: double.infinity,
              child: Padding(
                padding:  EdgeInsets.all(20.rSp),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DefaultText(
                        title: appBloc.translationModel!.filter,
                        style: Style.small,
                        letterSpacing: 2.rSp,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.rSp,
                        color: ColorsManager.mainColor,
                      ),
                      verticalSpace(2.h),
                      ///Status Method
                      GestureDetector(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 1.h),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18.rSp),
                              border: Border.all(color: Colors.grey.withOpacity(.6)
                                //color: Colors.red,  // red as border color
                              )),
                          child: Padding(
                            padding: EdgeInsets.all(15.0.rSp),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.pending_outlined,
                                  color: ColorsManager.black.withOpacity(0.7),

                                ),
                                horizontalSpace(3.w),
                                DefaultText(
                                  title: homeCubit.selectedStatusValue ?? appBloc.translationModel!.status,
                                  style: Style.large,
                                  fontSize: 14.rSp,
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.arrow_drop_down_sharp,
                                  color: ColorsManager.mainColor,
                                )
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              enableDrag: true,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(25.0.rSp))),
                              builder: (context)
                              {
                                return  BlocBuilder<HomeCubit,HomeState>(
                                  builder: (context, state) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          right: 20.0.rSp,
                                          top: 20.rSp,
                                          left: 20.0.rSp
                                      ),
                                      child: SizedBox(
                                        height: 40.h,
                                        child: Column(
                                            children: [
                                              if(homeCubit.ordersEntity != null)
                                                Expanded(
                                                  child: Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 10.0.rSp),
                                                      child:ListView.builder(
                                                          itemCount: homeCubit.filteredStatus.keys.length,
                                                          itemBuilder: (context, i) {
                                                            return DropdownMenuItem(
                                                              child: InkWell(
                                                                onTap: () {
                                                                  homeCubit.changeStatue(
                                                                    statusKey: homeCubit.filteredStatus.keys.toList()[i],
                                                                    statusValue: homeCubit.filteredStatus.values.toList()[i],
                                                                  );
                                                                  Navigator.pop(context);
                                                                },
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    verticalSpace(2.h),
                                                                    SizedBox(
                                                                      width: 100.w,
                                                                      child: Theme(
                                                                        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                                                                        child: DefaultText(
                                                                          title: homeCubit.filteredStatus.values.toList()[i],
                                                                          style: Style.small,
                                                                          fontWeight: FontWeight.w700,
                                                                          fontSize: 12.rSp,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    verticalSpace(2.h),
                                                                    Divider(
                                                                      thickness: 1.rSp,
                                                                      color: ColorsManager.darkGrey.withOpacity(0.5),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          })
                                                  ),
                                                ),
                                              if(homeCubit.ordersEntity == null)
                                                Expanded(
                                                  child: Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 10.0.rSp),
                                                      child: DropdownMenuItem(
                                                        child: Center(
                                                          child: DefaultText(
                                                            title: appBloc.translationModel!.noData,
                                                            style: Style.headMedium,
                                                            fontWeight: FontWeight.w700,
                                                          ),
                                                        ),
                                                      )
                                                  ),
                                                ),


                                            ]),
                                      ),
                                    );
                                  },
                                );
                              });
                        },
                      ),
                      verticalSpace(2.h),
                      DefaultButton(
                        text: appBloc.translationModel!.filter,
                        onPressed: (){
                          homeCubit.pageNumber =1;
                          homeCubit.orders(
                              status: homeCubit.selectedStatusKey,
                          );
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
