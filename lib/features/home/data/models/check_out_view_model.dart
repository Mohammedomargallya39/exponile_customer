import '../../domain/entities/check_out_view_entity.dart';

class CheckOutViewModel extends CheckOutViewEntity {
  const CheckOutViewModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory CheckOutViewModel.fromJson(Map<String, dynamic> json) {
    return CheckOutViewModel(
      data: Data.fromJson(json['data']),
      message: json['message'],
      success: json['success'],
    );
  }
}
