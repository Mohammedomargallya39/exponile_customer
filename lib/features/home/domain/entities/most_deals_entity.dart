import 'package:equatable/equatable.dart';

class MostOffersEntity extends Equatable {
  final List<StoresWithMostOffer> storesWithMostOffers;

  const MostOffersEntity({
    required this.storesWithMostOffers,
  });

  @override
  List<Object?> get props => [
  ];
}

class StoresWithMostOffer {
  String shopName;
  dynamic banner;
  String commercial;
  String vat;
  int id;
  String slug;
  dynamic logo;
  int totalOffers;
  String rate;
  String logoPath;
  String bannerPath;
  String commercialPath;
  String vatPath;

  StoresWithMostOffer({
    required this.shopName,
    required this.banner,
    required this.commercial,
    required this.vat,
    required this.id,
    required this.slug,
    required this.logo,
    required this.totalOffers,
    required this.rate,
    required this.logoPath,
    required this.bannerPath,
    required this.commercialPath,
    required this.vatPath,
  });

  factory StoresWithMostOffer.fromJson(Map<String, dynamic> json) => StoresWithMostOffer(
    shopName: json["shop_name"]??'',
    banner: json["banner"]??'',
    commercial: json["commercial"]??'',
    vat: json["vat"]??'',
    id: json["id"]??0,
    slug: json["slug"]??'',
    logo: json["logo"]??'',
    totalOffers: json["total_offers"]??0,
    rate: json["rate"]??'',
    logoPath: json["logo_path"]??'',
    bannerPath: json["banner_path"]??'',
    commercialPath: json["commercial_path"]??'',
    vatPath: json["vat_path"]??'',
  );

// Map<String, dynamic> toJson() => {
//   "shop_name": shopName,
//   "banner": banner,
//   "commercial": commercial,
//   "vat": vat,
//   "id": id,
//   "slug": slug,
//   "logo": logo,
//   "total_offers": totalOffers,
//   "rate": rate,
//   "logo_path": logoPath,
//   "banner_path": bannerPath,
//   "commercial_path": commercialPath,
//   "vat_path": vatPath,
// };
}
