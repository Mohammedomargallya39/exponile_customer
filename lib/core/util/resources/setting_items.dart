import 'package:equatable/equatable.dart';

class SettingsItem extends Equatable{
  final String title;
  final String icon;

  const SettingsItem(this.title, this.icon);

  @override
  List<Object?> get props => [ title, icon];
}