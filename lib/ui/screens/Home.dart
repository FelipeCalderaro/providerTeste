import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoList/core/view_models/main_view_model.dart';
import 'package:todoList/ui/screens/widgets/add_dialog.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mainViewModel = Provider.of<MainViewModel>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        mainViewModel.createStringList();
      }),
      appBar: AppBar(),
      body: mainViewModel.items.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: mainViewModel.items.length,
              itemBuilder: (BuildContext context, int index) => ListTile(
                title: Text(mainViewModel.items[index].name),
                subtitle: Text('R\$ ${mainViewModel.items[index].value}'),
                leading: CircleAvatar(),
                onTap: () => showDialog(
                  context: context,
                  builder: (context) => AddDialog(
                    index: index,
                  ),
                ),
              ),
            ),
    );
  }
}
