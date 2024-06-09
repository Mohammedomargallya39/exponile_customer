import 'package:exponile_customer/core/util/resources/extensions_manager.dart';
import 'package:exponile_customer/core/util/widgets/main_appbar.dart';
import 'package:exponile_customer/features/home/presentation/controller/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../../../../../core/network/remote/api_endpoints.dart';
import '../../../../../core/util/cubit/cubit.dart';
import '../../../../../core/util/resources/assets.gen.dart';
import '../../../../../core/util/resources/colors_manager.dart';
import '../../../../../core/util/resources/constants_manager.dart';
import '../../../../../core/util/widgets/default_button.dart';
import '../../../../../core/util/widgets/default_text.dart';
import '../../../../../core/util/widgets/default_text_field.dart';
import '../../../../../core/util/widgets/hideKeyboard.dart';
import '../../../../../core/util/widgets/my_icon_button.dart';
import '../../../../../core/util/widgets/progress.dart';
import '../../controller/cubit.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController searchMapController = TextEditingController();

  final TextEditingController searchCityController = TextEditingController();

  final TextEditingController searchGovernmentController = TextEditingController();

  final TextEditingController streetNameEnController  = TextEditingController();

  final TextEditingController buildingNameController  = TextEditingController();

  final TextEditingController landMarkController  = TextEditingController();

  final TextEditingController floorNoController  = TextEditingController();

  final TextEditingController aptNoController  = TextEditingController();

  final MapController? mapController = MapController();

  double lat = 30.087446;

  double long = 31.348157;

  @override
  void initState() {
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.getLocation(lat: lat, long: long);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    AppBloc appBloc = AppBloc.get(context);
    return Directionality(
        textDirection: appBloc.isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: BlocConsumer<HomeCubit,HomeState>(
          listener: (context, state) {
            if(state is AreasSuccessState){
              for (int i = 0; i < homeCubit.filteredAreas.length; i++) {
                if (homeCubit.locationEntity!.data![0].displayName!.split(',').first == homeCubit.filteredAreas[i].name) {
                  homeCubit.selectedAreaName = homeCubit.filteredAreas[i].name;
                  homeCubit.selectedAreaID = homeCubit.filteredAreas[i].id;
                  break;
                }
              }
            }
            if(state is LocationLoadingState) {
              showDialog(
                context: context,
                builder: (context) {
                  return ProgressDialog(message: appBloc.translationModel!.loading);
                },
              );
            }
            if (state is LocationErrorState) {
              Navigator.pop(context);
              designToastDialog(
                  context: context,
                  toast: TOAST.error,
                  text: state.failure.toString());
            }
            if (state is LocationSuccessState && state.locationEntity.success == 0) {
              Navigator.pop(context);
              designToastDialog(
                  context: context,
                  toast: TOAST.error,
                  text: state.locationEntity.message!);
            }
            if (state is LocationSuccessState && state.locationEntity.success ==1 && state.locationEntity.data!.isEmpty) {
              Navigator.pop(context);
              designToastDialog(
                  context: context,
                  toast: TOAST.error,
                  text: appBloc.translationModel!.error);
            }
            if (state is LocationSuccessState && state.locationEntity.success ==1 && state.locationEntity.data!.isNotEmpty) {
              Navigator.pop(context);
              lat = double.parse(state.locationEntity.data![0].lat ?? '30.3154491');
              long = double.parse(state.locationEntity.data![0].long ?? '31.7392776');
              mapController!.move(
                LatLng(
                  lat,
                  long,
                ),

                mapController!.camera.zoom,
              );
              for (int i = 0; i < homeCubit.filteredCities.length; i++) {
                if (state.locationEntity.data![0].address!.stateName == homeCubit.filteredCities[i].name) {
                  homeCubit.selectedCityName = homeCubit.filteredCities[i].name;
                  homeCubit.selectedCityID = homeCubit.filteredCities[i].id;
                  homeCubit.areasEntity = null;
                  homeCubit.getAreas(cityID: homeCubit.selectedCityID!);
                  break;
                }
              }
            }
            if (state is GetLocationSuccessState && state.getLocationEntity.success ==1) {
              for (int i = 0; i < homeCubit.filteredCities.length; i++) {
                if (state.getLocationEntity.data!.governorateName == homeCubit.filteredCities[i].name) {
                  homeCubit.selectedCityName = state.getLocationEntity.data!.governorateName;
                  homeCubit.selectedCityID = state.getLocationEntity.data!.governorateID;
                  homeCubit.selectedAreaName = state.getLocationEntity.data!.areaName;
                  homeCubit.selectedAreaID = state.getLocationEntity.data!.areaID;
                  break;
                }
              }
            }

            if(state is AddLocationLoadingState) {
              showDialog(
                context: context,
                builder: (context) {
                  return ProgressDialog(message: appBloc.translationModel!.loading);
                },
              );
            }
            if (state is AddLocationErrorState) {
              Navigator.pop(context);
              designToastDialog(
                  context: context,
                  toast: TOAST.error,
                  text: state.failure.toString());
            }
            if (state is AddLocationSuccessState && state.addLocationEntity.success == 0) {
              Navigator.pop(context);
              designToastDialog(
                  context: context,
                  toast: TOAST.error,
                  text: state.addLocationEntity.message!);
            }
            if (state is AddLocationSuccessState && state.addLocationEntity.success == 1) {
              Navigator.pop(context);
              Navigator.pop(context);
              homeCubit.accountData();
              designToastDialog(
                  context: context,
                  toast: TOAST.success,
                  text: state.addLocationEntity.message!);
            }

          },
          builder: (context, state) {
            return Scaffold(
              appBar: MainAppBar(
                  title: appBloc.translationModel!.addAddress,
                  isBack: true,
                  isLang: false
              ),
              body: HideKeyboardPage(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.w),
                      child: Column(
                        children: [
                          verticalSpace(1.h),
                          DefaultTextField(
                            onChanged: (value){
                              String replacedValue = replaceArabicNumbers(value!);
                              searchMapController.value = TextEditingValue(
                                text: replacedValue,
                                selection: TextSelection.fromPosition(
                                  TextPosition(offset: replacedValue.length),
                                ),
                              );
                            },
                            isPassword: false,
                            showSuffix: true,
                            suffixIcon: DefaultIconButton(
                                icon: const Icon(
                                  Icons.search,
                                ),
                                onPressed: (){
                                  if(formKey.currentState!.validate()){
                                    homeCubit.location(
                                        address: searchMapController.text
                                    );
                                  }
                                }
                            ),
                            controller: searchMapController,
                            hint: appBloc.translationModel!.location,
                            svgImg: Assets.images.svg.location,
                          ),
                          Container(
                            width: 100.w,
                            height: 25.h,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                              shape: BoxShape.rectangle,
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                heightFactor: 0.3,
                                widthFactor: 2.5,
                                child: FlutterMap(
                                    mapController: mapController,
                                    options: MapOptions(
                                      minZoom: 8,
                                      maxZoom: 15,
                                      initialZoom: 10,
                                      initialCenter: LatLng(
                                          lat,
                                          long
                                      ),
                                      interactionOptions: const InteractionOptions(),
                                      onTap: (tap, latLng) {
                                        lat = latLng.latitude;
                                        long = latLng.longitude;
                                        mapController!.move(LatLng(lat, long), mapController!.camera.zoom,);
                                        mapController!.camera.center;
                                        homeCubit.toggleRoleSelection();
                                        homeCubit.getLocation(lat: lat, long: long);
                                      },
                                    ),
                                    children: [
                                      TileLayer(
                                        urlTemplate: mapURL,
                                        subdomains: const ['a', 'b', 'c'],
                                      ),
                                      MarkerLayer(
                                        markers: [
                                          Marker(
                                            point:  LatLng(
                                                lat,
                                                long
                                            ),
                                            width: 80,
                                            height: 80,
                                            child: Icon(
                                              Icons.location_on,
                                              color: ColorsManager.orangePrimary,
                                              size: 26.rSp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ]
                                ),
                              ),
                            ),
                          ),
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
                                      Icons.location_city,
                                      color: ColorsManager.black.withOpacity(0.7),

                                    ),
                                    horizontalSpace(3.w),
                                    DefaultText(
                                      title: homeCubit.selectedCityName ?? appBloc.translationModel!.city,
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
                                    return  Padding(padding: EdgeInsets.only(right: 20.0.rSp, top: 20.rSp, left: 20.0.rSp),
                                      child: SizedBox(
                                        height: 70.h,
                                        child: Column(
                                            children: [
                                              if(homeCubit.citiesEntity != null)
                                                Expanded(
                                                  child: Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 10.0.rSp),
                                                      child:ListView.builder(
                                                          itemCount: homeCubit.filteredCities.length,
                                                          itemBuilder: (context, i) {
                                                            if(i == 0){
                                                              return Column(
                                                                children: [
                                                                  SingleChildScrollView(
                                                                    child: DefaultTextField(
                                                                      controller: searchCityController,
                                                                      hint: appBloc.translationModel!.search,
                                                                      onChanged: (value) {
                                                                        homeCubit.filterCities(value!);
                                                                      },
                                                                    ),
                                                                  ),
                                                                  verticalSpace(2.h),
                                                                  DropdownMenuItem(
                                                                    child: InkWell(
                                                                      onTap: () {
                                                                        homeCubit.changeCityValue(cityID: homeCubit.filteredCities[0].id!,cityName: homeCubit.filteredCities[0].name!);
                                                                        homeCubit.location(address: homeCubit.filteredCities[0].name!);
                                                                        homeCubit.selectedAreaID = 0;
                                                                        homeCubit.selectedAreaName = appBloc.translationModel!.government;
                                                                        homeCubit.areasEntity = null;
                                                                        homeCubit.getAreas(cityID: homeCubit.filteredCities[0].id!);
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
                                                                                title: homeCubit.filteredCities[0].name!,
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
                                                                  ),
                                                                ],
                                                              );
                                                            }else {
                                                              return DropdownMenuItem(
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    homeCubit.changeCityValue(cityID: homeCubit.filteredCities[i].id!,cityName: homeCubit.filteredCities[i].name!);
                                                                    homeCubit.location(address: homeCubit.filteredCities[i].name!);
                                                                    homeCubit.selectedAreaID = 0;
                                                                    homeCubit.selectedAreaName = appBloc.translationModel!.government;
                                                                    homeCubit.areasEntity = null;
                                                                    homeCubit.getAreas(cityID: homeCubit.filteredCities[i].id!);
                                                                    Navigator.pop(context);
                                                                  },
                                                                  highlightColor: Colors.transparent,
                                                                  splashColor: Colors.transparent,
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      verticalSpace(2.h),
                                                                      SizedBox(
                                                                        width: 100.w,
                                                                        child: Theme(
                                                                          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                                                                          child: DefaultText(
                                                                            title: homeCubit.filteredCities[i].name!,
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
                                                            }
                                                          })
                                                  ),
                                                ),
                                              if(homeCubit.citiesEntity == null)
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
                                  });
                            },
                          ),
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
                                      Icons.location_on,
                                      color: ColorsManager.black.withOpacity(0.7),

                                    ),
                                    horizontalSpace(3.w),
                                    DefaultText(
                                      title: homeCubit.selectedAreaName ?? appBloc.translationModel!.government,
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
                                    return  Padding(padding: EdgeInsets.only(right: 20.0.rSp, top: 20.rSp, left: 20.0.rSp),
                                      child: SizedBox(
                                        height: 70.h,
                                        child: Column(
                                            children: [
                                              if(homeCubit.areasEntity != null)
                                                Expanded(
                                                  child: Padding(
                                                      padding: EdgeInsets.symmetric(horizontal: 10.0.rSp),
                                                      child:ListView.builder(
                                                          itemCount: homeCubit.filteredAreas.length,
                                                          itemBuilder: (context, i) {
                                                            if(i == 0){
                                                              return Column(
                                                                children: [
                                                                  SingleChildScrollView(
                                                                    child: DefaultTextField(
                                                                      controller: searchGovernmentController,
                                                                      hint: appBloc.translationModel!.search,
                                                                      onChanged: (value) {
                                                                        homeCubit.filterAreas(value!);
                                                                      },
                                                                    ),
                                                                  ),
                                                                  verticalSpace(2.h),
                                                                  DropdownMenuItem(
                                                                    child: InkWell(
                                                                      onTap: () {
                                                                        homeCubit.changeAreaValue(areaID: homeCubit.filteredAreas[0].id!,areaName: homeCubit.filteredAreas[0].name!);
                                                                        homeCubit.location(address: homeCubit.filteredAreas[0].name!);
                                                                        Navigator.pop(context);
                                                                      },
                                                                      highlightColor: Colors.transparent,
                                                                      splashColor: Colors.transparent,
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          verticalSpace(2.h),
                                                                          SizedBox(
                                                                            width: 100.w,
                                                                            child: Theme(
                                                                              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                                                                              child: DefaultText(
                                                                                title: homeCubit.filteredAreas[0].name!,
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
                                                                  ),
                                                                ],
                                                              );
                                                            }else {
                                                              return DropdownMenuItem(
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    homeCubit.changeAreaValue(areaID: homeCubit.filteredAreas[i].id!,areaName: homeCubit.filteredAreas[i].name!);
                                                                    homeCubit.location(address: homeCubit.filteredAreas[i].name!);
                                                                    Navigator.pop(context);
                                                                  },
                                                                  highlightColor: Colors.transparent,
                                                                  splashColor: Colors.transparent,
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      verticalSpace(1.h),
                                                                      SizedBox(
                                                                        width: 100.w,
                                                                        child: Theme(
                                                                          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                                                                          child: DefaultText(
                                                                            title: homeCubit.filteredAreas[i].name!,
                                                                            style: Style.small,
                                                                            fontWeight: FontWeight.w700,
                                                                            fontSize: 12.rSp,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      verticalSpace(1.h),
                                                                      Divider(
                                                                        thickness: 1.rSp,
                                                                        color: ColorsManager.darkGrey.withOpacity(0.5),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                          })
                                                  ),
                                                ),
                                              if(homeCubit.areasEntity == null)
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
                                  });
                            },
                          ),
                          DefaultTextField(
                            onChanged: (value){
                              String replacedValue = replaceArabicNumbers(value!);
                              streetNameEnController.value = TextEditingValue(
                                text: replacedValue,
                                selection: TextSelection.fromPosition(
                                  TextPosition(offset: replacedValue.length),
                                ),
                              );
                            },
                            isPassword: false,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return appBloc.translationModel!.requiredField;
                              }
                              return null;
                            },
                            controller: streetNameEnController,
                            hint: appBloc.translationModel!.streetNameAr,
                            svgImg: Assets.images.svg.street,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: DefaultTextField(
                                  onChanged: (value){
                                    String replacedValue = replaceArabicNumbers(value!);
                                    buildingNameController.value = TextEditingValue(
                                      text: replacedValue,
                                      selection: TextSelection.fromPosition(
                                        TextPosition(offset: replacedValue.length),
                                      ),
                                    );
                                  },
                                  isPassword: false,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return appBloc.translationModel!.requiredField;
                                    }
                                    return null;
                                  },
                                  controller: buildingNameController,
                                  hint: appBloc.translationModel!.buildingName,
                                  svgImg: Assets.images.svg.building,
                                ),
                              ),
                              horizontalSpace(4.w),
                              Expanded(
                                child: DefaultTextField(
                                  onChanged: (value){
                                    String replacedValue = replaceArabicNumbers(value!);
                                    floorNoController.value = TextEditingValue(
                                      text: replacedValue,
                                      selection: TextSelection.fromPosition(
                                        TextPosition(offset: replacedValue.length),
                                      ),
                                    );
                                  },
                                  isPassword: false,
                                  type: TextInputType.phone,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return appBloc.translationModel!.requiredField;
                                    }
                                    return null;
                                  },
                                  controller: floorNoController,
                                  hint: appBloc.translationModel!.floorNo,
                                  svgImg: Assets.images.svg.floor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: DefaultTextField(
                                  onChanged: (value){
                                    String replacedValue = replaceArabicNumbers(value!);
                                    landMarkController.value = TextEditingValue(
                                      text: replacedValue,
                                      selection: TextSelection.fromPosition(
                                        TextPosition(offset: replacedValue.length),
                                      ),
                                    );
                                  },
                                  isPassword: false,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return appBloc.translationModel!.requiredField;
                                    }
                                    return null;
                                  },
                                  controller: landMarkController,
                                  hint: appBloc.translationModel!.landmark,
                                  svgImg: Assets.images.svg.landmark,
                                ),
                              ),
                              horizontalSpace(4.w),
                              Expanded(
                                child: DefaultTextField(
                                  onChanged: (value){
                                    String replacedValue = replaceArabicNumbers(value!);
                                    aptNoController.value = TextEditingValue(
                                      text: replacedValue,
                                      selection: TextSelection.fromPosition(
                                        TextPosition(offset: replacedValue.length),
                                      ),
                                    );
                                  },
                                  isPassword: false,
                                  type: TextInputType.phone,
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return appBloc.translationModel!.requiredField;
                                    }
                                    return null;
                                  },
                                  controller: aptNoController,
                                  hint: appBloc.translationModel!.flatNo,
                                  svgImg: Assets.images.svg.shop,
                                ),
                              ),
                            ],
                          ),
                          verticalSpace(2.h),
                          Row(
                            children: [
                              Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      homeCubit.changeLocationPlace(
                                          isHomeValue: true,
                                          isWorkValue: false
                                      );
                                    },
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 4.5.w,
                                          height: 2.h,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: ColorsManager.black,
                                              width: 1.rSp,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.rSp),
                                            ),
                                            color: homeCubit.isHome ? ColorsManager.success : Colors.transparent
                                          ),
                                        ),
                                        horizontalSpace(2.w),
                                        svgImage(path: Assets.images.svg.home, color: ColorsManager.mainColor,
                                        ),
                                        horizontalSpace(1.w),
                                        DefaultText(
                                            title: appBloc.translationModel!.homeLocation,
                                            style: Style.small,
                                            maxLines: 1,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 12.rSp,
                                            color: ColorsManager.mainColor,
                                        )
                                      ],
                                    ),
                                  )
                              ),
                              horizontalSpace(2.w),
                              Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      homeCubit.changeLocationPlace(
                                          isHomeValue: false,
                                          isWorkValue: true
                                      );
                                    },
                                    highlightColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 4.5.w,
                                          height: 2.h,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: ColorsManager.black,
                                              width: 1.rSp,
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.rSp)
                                            ),
                                              color: homeCubit.isWork ? ColorsManager.success : Colors.transparent
                                          ),
                                        ),
                                        horizontalSpace(2.w),
                                        svgImage(path: Assets.images.svg.job,),
                                        horizontalSpace(1.w),
                                        DefaultText(
                                          title: appBloc.translationModel!.jobLocation,
                                          style: Style.small,
                                          maxLines: 1,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 12.rSp,
                                          color: ColorsManager.mainColor,
                                        )
                                      ],
                                    ),
                                  )
                              ),
                            ],
                          ),
                          verticalSpace(2.h),
                          DefaultButton(
                            text: appBloc.translationModel!.save,
                            onPressed: (){
                              if(formKey.currentState!.validate()){
                                if((homeCubit.selectedAreaID != 0 || homeCubit.selectedAreaID != '') && (homeCubit.isWork || homeCubit.isHome) ){
                                  homeCubit.addLocation(
                                      area: homeCubit.selectedAreaID,
                                      governorate: homeCubit.selectedCityID,
                                      late: lat.toString(),
                                      long: long.toString(),
                                      streetName: streetNameEnController.text,
                                      buildingName: buildingNameController.text,
                                      landmark: landMarkController.text,
                                      floorNo: int.parse(floorNoController.text),
                                      aptNo: int.parse(aptNoController.text),
                                      type: homeCubit.isHome ? 'home' : 'office'
                                  );
                                }else{
                                  designToastDialog(
                                      context: context,
                                      toast: TOAST.warning,
                                      text: appBloc.translationModel!.fillData
                                  );
                                }
                              }
                            },
                          ),
                          verticalSpace(2.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        )
    );
  }
}
