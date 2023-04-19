import 'package:asuka/asuka.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/home_data_provider.dart';
import '../domain/home_repository.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://jsonplaceholder.typicode.com',
    ),
  );

  late final HomeDataProvider dataProvider;
  late final HomeRepository repository;
  late final HomeCubit cubit;

  @override
  void initState() {
    dataProvider = HomeDataProvider(dio);
    repository = HomeRepository(dataProvider);
    cubit = HomeCubit(repository);
    super.initState();

    cubit.stream.listen((state) {
      if (state is InsertingResultState) {
        if (state.successed) {
          AsukaSnackbar.success(state.message).show();
        } else {
          AsukaSnackbar.alert(state.message).show();
        }
      }
    });
  }

  insertItems() {
    Asuka.showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            TextField(
              controller: cubit.titleController,
              decoration: const InputDecoration(hintText: 'Título'),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: cubit.bodyController,
              decoration: const InputDecoration(hintText: 'Conteúdo'),
              maxLines: 5,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                Navigator.pop(context);

                cubit.insertItem();
              },
              child: const Text('Enviar'),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: insertItems,
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Listagem de posts'),
      ),
      body: BlocBuilder<HomeCubit, HomeStates>(
        bloc: cubit,
        builder: (context, state) {
          return state is LoadingPostsState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  itemCount: (state as LoadedPostsState).items.length,
                  separatorBuilder: (_, __) => const Divider(),
                  itemBuilder: (_, index) {
                    final item = (state).items[index];
                    return ListTile(
                      title: Text(item.title),
                      subtitle: Text(item.body),
                    );
                  },
                );
        },
      ),
    );
  }
}
