// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class TransactionCategory extends Equatable{
  final String name;
  const TransactionCategory({
    required this.name,
  });

  String get asset;

  String get viewText => name;

  @override
  List<Object> get props => [name];
}
