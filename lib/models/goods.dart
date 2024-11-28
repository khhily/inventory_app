import 'package:hive/hive.dart';

part 'goods.g.dart';

@HiveType(typeId: 0)
class Goods extends HiveObject {
  Goods({required this.name, this.description});

  @HiveField(0)
  final String name;

  @HiveField(1)
  final String? description;
}
