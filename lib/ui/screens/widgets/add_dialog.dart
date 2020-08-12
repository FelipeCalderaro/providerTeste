import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoList/core/view_models/main_view_model.dart';

class AddDialog extends StatelessWidget {
  TextEditingController _controller = TextEditingController();

  int index;
  AddDialog({@required this.index});

  @override
  Widget build(BuildContext context) {
    final mainViewModel = Provider.of<MainViewModel>(context);

    return Dialog(
      child: ListView(
        padding: EdgeInsets.all(16),
        shrinkWrap: true,
        children: [
          Text("Adicione o valor"),
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
          ),
          ButtonBar(
            children: [
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Text('cancel'),
              ),
              RaisedButton(
                onPressed: () {
                  mainViewModel.changeValue(
                      index, double.parse(_controller.text));
                  Navigator.pop(context);
                },
                child: Text("Adicionar"),
              )
            ],
          )
        ],
      ),
    );
  }
}
