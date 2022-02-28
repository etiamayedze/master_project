import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _formKey =GlobalKey<FormState>();
  final firstNameEditingController = new TextEditingController();
  final lastNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {

    final firstNameField =TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value){
        RegExp regex = new RegExp(r'^.{3,}$');
        if(value!.isEmpty){
          return("Enterez un prénom! Le champs est obligatoire");
        }
        if(!regex.hasMatch(value)){
          return("Le champs doit être de 5 caractères minimum");
        }
        return null;
      },
      onSaved: (value){
        firstNameEditingController.text =value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle),
        contentPadding:EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Prénom",
        border:OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        )
      ),
    );
    final lastNameField = TextField(
      autofocus: false,
      controller: lastNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value){
        RegExp regex = new RegExp(r'^.{3,}$');
        if(value!.isEmpty){
          return("Entrez un nom ! Le champs est obligatoire");
        }
        if(!regex.hasMatch(value)){
          return ("le champs doit être de 5 caracteres minimum");
        }
        return null;
      },
      onSaved: (value){
        lastNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle ),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Nom",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
          )
      ),
    );

    return Container();
  }
}
