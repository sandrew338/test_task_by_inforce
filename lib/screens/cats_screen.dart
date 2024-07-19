import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_by_inforce/bloc/cat_bloc.dart';
import 'package:test_task_by_inforce/bloc/cat_event.dart';
import 'package:test_task_by_inforce/bloc/cat_state.dart';
import 'package:test_task_by_inforce/models/cat.dart';

class CatListScreen extends StatefulWidget {
  const CatListScreen({super.key});

  @override
  State<CatListScreen> createState() => _CatListScreenState();
}

class _CatListScreenState extends State<CatListScreen> {
  String _selectedItem = 'alphabet';
  @override
  Widget build(BuildContext context) {
    const List<String> list = <String>['alphabet', 'id'];
    context.read<CatBloc>().add(SortCat(_selectedItem));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat List'),
        actions: [
          DropdownButton<String>(
            hint: Text(
              _selectedItem.toString(),
              style: const TextStyle(color: Colors.blue),
            ),
            value: _selectedItem,
            items: list.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedItem = newValue!;
                context.read<CatBloc>().add(SortCat(_selectedItem));
              });
            },
          ),
        ],
      ),
      body: BlocBuilder<CatBloc, CatState>(
        builder: (context, state) {
          if (state is CatLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CatLoaded) {
            return CatListView(cats: state.cats);
          } else if (state is CatError) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCatDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddCatDialog(BuildContext context) {
    final TextEditingController nameController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Cat'),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  final newCat = Cat(
                    id: DateTime.now().millisecondsSinceEpoch,
                    name: nameController.text,
                    origin: '',
                    temperament: '',
                    colors: [],
                    description: '',
                    image: '',
                  );
                  context.read<CatBloc>().add(AddCat(newCat));
                  context.read<CatBloc>().add(SortCat(_selectedItem));
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}

class CatListView extends StatelessWidget {
  final List<Cat> cats;

  const CatListView({super.key, required this.cats});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cats.length,
      itemBuilder: (context, index) {
        final cat = cats[index];
        return ListTile(
          title: Text(cat.name),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _showDeleteCatDialog(context, cat),
          ),
        );
      },
    );
  }

  void _showDeleteCatDialog(BuildContext context, Cat cat) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Cat'),
          content: Text('Are you sure you want to delete ${cat.name}?'),
          actions: [
            TextButton(
              onPressed: () {
                context.read<CatBloc>().add(RemoveCat(cat));
                Navigator.of(context).pop();
              },
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
