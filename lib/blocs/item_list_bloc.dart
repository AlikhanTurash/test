import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/blocs/item_list_event.dart';
import 'package:untitled/blocs/item_list_state.dart';
import 'package:untitled/models/item.dart';
import 'package:untitled/services/api_service.dart';
import 'package:untitled/services/image_cache_service.dart';

class ItemListBloc extends Bloc<ItemListEvent, ItemListState> {
  final ImageCacheService imageCacheService;
  final ApiService apiService;
  int currentPage = 1;

  ItemListBloc(this.imageCacheService, this.apiService) : super(ItemListInitial()) {
    on<LoadItems>(_onLoadItems);
    on<LoadMoreItems>(_onLoadMoreItems);
  }

  Future<void> _onLoadItems(LoadItems event, Emitter<ItemListState> emit) async {
    emit(ItemListLoading());
    try {
      final items = await apiService.fetchArtworks(page: currentPage);
      emit(ItemListLoaded(items));
    } catch (e) {
      emit(ItemListError('Failed to load items: $e'));
    }
  }

  Future<void> _onLoadMoreItems(LoadMoreItems event, Emitter<ItemListState> emit) async {
    if (state is ItemListLoaded) {
      final currentState = state as ItemListLoaded;
      currentPage++;
      try {
        final newItems = await apiService.fetchArtworks(page: currentPage);
        emit(ItemListLoaded([...currentState.items, ...newItems]));
      } catch (e) {
        emit(ItemListError('Failed to load more items: $e'));
      }
    }
  }

  @override
  Future<void> close() {
    imageCacheService.clearCache();
    return super.close();
  }
}