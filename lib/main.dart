import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:test_task_by_inforce/repositories/cat_repository.dart';
import 'package:test_task_by_inforce/screens/cats_screen.dart';
import 'bloc/cat_bloc.dart';
import 'bloc/cat_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<CatRepository>(create: (_) => CatRepository()),
        BlocProvider<CatBloc>(
          create: (context) => CatBloc(context.read<CatRepository>())..add(FetchCats()),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CatListScreen(),
      ),
    );
  }
}

