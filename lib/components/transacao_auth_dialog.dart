import 'package:flutter/material.dart';

class TransacaoAuthDialog extends StatefulWidget {
  final Function(String password) onConfirm;

  TransacaoAuthDialog({
    @required this.onConfirm,
  });

  @override
  _TransacaoAuthDialogState createState() => _TransacaoAuthDialogState();
}

class _TransacaoAuthDialogState extends State<TransacaoAuthDialog> {

  final TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Autenticação'),
      content: TextField(
        controller: _passwordController,
        obscureText: true,
        maxLength: 4,
        decoration: InputDecoration(border: OutlineInputBorder()),
        style: TextStyle(fontSize: 55, letterSpacing: 24),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancelar'),
        ),
        FlatButton(
          onPressed: () {
            widget.onConfirm(_passwordController.text);
            Navigator.pop(context);
          },
          child: Text('Confirmar'),
        )
      ],
    );
  }
}
