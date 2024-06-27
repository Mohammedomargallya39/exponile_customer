import '../../domain/entities/delete_cart_item_entity.dart';

class DeleteCartItemModel extends DeleteCartItemEntity {
  const DeleteCartItemModel({
    required super.data,
    required super.message,
    required super.success,
  });

  factory DeleteCartItemModel.fromJson(Map<String, dynamic> json) {
    return DeleteCartItemModel(
      data: json['data'],
      message: json['message'],
      success: json['success'],
    );
  }
}
