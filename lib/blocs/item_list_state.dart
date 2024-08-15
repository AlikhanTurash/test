import 'package:untitled/models/item.dart';

abstract class ItemListState {}

class ItemListInitial extends ItemListState {}

class ItemListLoading extends ItemListState {}

class ItemListLoaded extends ItemListState {
  final List<Item> items;

  ItemListLoaded(this.items);
}

class ItemListError extends ItemListState {
  final String message;

  ItemListError(this.message);
}