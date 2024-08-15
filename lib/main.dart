import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/blocs/item_list_bloc.dart';
import 'package:untitled/screens/home_screen.dart';
import 'package:untitled/services/api_service.dart';
import 'package:untitled/services/image_cache_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memory Optimization Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => ItemListBloc(ImageCacheService(), ApiService()),
        child: const HomeScreen(),
      ),
    );
  }
}