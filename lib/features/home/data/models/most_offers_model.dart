import '../../domain/entities/most_deals_entity.dart';

class MostOffersModel extends MostOffersEntity {
  const MostOffersModel({
    required super.storesWithMostOffers,
  });

  factory MostOffersModel.fromJson(Map<String, dynamic> json) {
    return MostOffersModel(
      storesWithMostOffers: List<StoresWithMostOffer>.from(json["storesWithMostOffers"].map((x) => StoresWithMostOffer.fromJson(x))),
    );
  }
}
