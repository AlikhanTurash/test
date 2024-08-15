import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/blocs/item_list_bloc.dart';
import 'package:untitled/blocs/item_list_event.dart';
import 'package:untitled/blocs/item_list_state.dart';
import 'package:untitled/widgets/item_list_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Art Institute of Chicago'),
      ),
      body: BlocBuilder<ItemListBloc, ItemListState>(
        builder: (context, state) {
          if (state is ItemListInitial) {
            BlocProvider.of<ItemListBloc>(context).add(LoadItems());
            return const Center(child: CircularProgressIndicator());
          } else if (state is ItemListLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ItemListLoaded) {
            return ListView.builder(
              controller: _scrollController,
              itemCount: state.items.length + 1,
              itemBuilder: (context, index) {
                if (index < state.items.length) {
                  return ItemListTile(item: state.items[index]);
                } else {
                  return const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            );
          } else if (state is ItemListError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('Unknown state'));
        },
      ),
    );
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<ItemListBloc>().add(LoadMoreItems());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}