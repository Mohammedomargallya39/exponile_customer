import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../../core/util/cubit/cubit.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/colors_manager.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/default_button.dart';
import '../../../../../core/util/widgets/default_text.dart';
import '../../../../../core/util/widgets/default_text_field.dart';
import '../../../../../core/util/widgets/hideKeyboard.dart';
import '../../../../../core/util/widgets/my_icon_button.dart';
import '../../controller/cubit.dart';
import '../../controller/state.dart';


class FilterOfferDialog extends Dialog {

  const FilterOfferDialog({super.key,required this.shopId});
  final int shopId;


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
              height: 55.h,
              width: double.infinity,
              child: Padding(
                padding:  EdgeInsets.all(20.rSp),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          DefaultText(
                            title: appBloc.translationModel!.filter,
                            style: Style.small,
                            letterSpacing: 2.rSp,
                            fontWeight: FontWeight.w700,
                            fontSize: 14.rSp,
                            color: ColorsManager.mainColor,
                          ),
                          const Spacer(),
                          DefaultIconButton(
                              icon: Icon(
                                  Icons.filter_alt_off_outlined,
                                  size: 18.rSp,
                                  color: ColorsManager.error
                              ),
                              onPressed: (){
                                homeCubit.startFilterShopDateController.text.isEmpty;
                                homeCubit.endFilterShopDateController.text.isEmpty;
                                homeCubit.selectedFilterShopCategoryName= null;
                                homeCubit.selectedFilterShopCategoryID= null;
                                homeCubit.toggleRoleSelection();
                              }
                          )
                        ],
                      ),
                      verticalSpace(2.h),
                      Row(
                        children: [
                          ///Start Date
                          Expanded(
                            child: DefaultTextField(
                              controller: homeCubit.startFilterShopDateController,
                              hint: appBloc.translationModel!.from,
                              isPassword: false,
                              disabled: true,
                              svgImg: Assets.images.svg.time,
                              onTap: () async{
                                DateTime? pickedDate = await   showDatePicker(
                                  context: context,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now(),
                                  initialDate: DateTime.now(),
                                  barrierDismissible: false,
                                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                                  builder: (BuildContext context, Widget? child) {
                                    return Theme(
                                      data: ThemeData.light().copyWith(
                                        inputDecorationTheme: const InputDecorationTheme(
                                          border: InputBorder.none,
                                          filled: false,
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );
                                if (pickedDate != null) {
                                  String formattedDate = DateFormat('dd / MM / yyyy').format(pickedDate);
                                  homeCubit.startFilterShopDateController.text = formattedDate;                              }
                              },
                            ),
                          ),
                          horizontalSpace(1.w),
                          ///End Date
                          Expanded(
                            child: DefaultTextField(
                              controller: homeCubit.endFilterShopDateController,
                              hint: appBloc.translationModel!.to,
                              isPassword: false,
                              disabled: true,
                              svgImg: Assets.images.svg.time,
                              onTap: () async{
                                DateTime? pickedDate = await   showDatePicker(
                                  context: context,
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime.now(),
                                  initialDate: DateTime.now(),
                                  barrierDismissible: false,
                                  initialEntryMode: DatePickerEntryMode.calendarOnly,
                                  builder: (BuildContext context, Widget? child) {
                                    return Theme(
                                      data: ThemeData.light().copyWith(
                                        inputDecorationTheme: const InputDecorationTheme(
                                          border: InputBorder.none,
                                          filled: false,
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                );
                                if (pickedDate != null) {
                                  String formattedDate = DateFormat('dd / MM / yyyy').format(pickedDate);
                                  homeCubit.endFilterShopDateController.text = formattedDate;
                                }
                              },
                            ),
                          ),
                        ],
                      ),

                      ///Offer Type
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
                                  Icons.type_specimen,
                                  color: ColorsManager.black.withOpacity(0.7),

                                ),
                                horizontalSpace(3.w),
                                DefaultText(
                                  title: homeCubit.selectedFilterShopCategoryName ?? appBloc.translationModel!.productsCategory,
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
                                              if(homeCubit.shopDataEntity != null)
                                                Expanded(
                                                  child: Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 10.0.rSp),
                                                      child:ListView.builder(
                                                          itemCount: homeCubit.filterShopCategories.length,
                                                          itemBuilder: (context, i) {
                                                            return DropdownMenuItem(
                                                              child: InkWell(
                                                                onTap: () {
                                                                  homeCubit.changeShopCategoriesValue(
                                                                    filterShopCategoryName: homeCubit.filterShopCategories.values.toList()[i],
                                                                    filterShopCategoryID: homeCubit.filterShopCategories.keys.toList()[i],
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
                                                                          title: homeCubit.filterShopCategories.values.toList()[i],
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
                                              if(homeCubit.shopDataEntity == null)
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
                          homeCubit.shopData(
                            shopID: shopId,
                            category: homeCubit.selectedFilterShopCategoryName == null ? []: [homeCubit.selectedFilterShopCategoryName],
                            subCategory: homeCubit.subCategories,
                            from: homeCubit.startFilterShopDateController.text,
                            to: homeCubit.endFilterShopDateController.text,
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
