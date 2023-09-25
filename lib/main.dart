import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreenAccent),
        useMaterial3: true,
      ),
      home: const MyForm(title: 'Flutter Sign Up with Validations'),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({super.key, required this.title});
  final String title;

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('Email: $_email');
      print('Password: $_password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: validateEmail,
                    onSaved: (newValue) => _email = newValue,
                    decoration: const InputDecoration(
                        hintText: 'Enter your email',
                        labelText: 'Email',
                        border: OutlineInputBorder())),
                const SizedBox(height: 10),
                TextFormField(
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                      hintText: 'Enter your password',
                      labelText: 'Password',
                      border: OutlineInputBorder()),
                  validator: (value) =>
                      value!.isEmpty ? 'Password cannot be empty' : null,
                  onSaved: (newValue) => _password = newValue,
                ),
                ButtonBar(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _submit();
                      },
                      child: const Text('Submit'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? validateEmail(value) {
    if (value!.isEmpty) {
      return 'Email field cannot be empty';
    }
    const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    final regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }
}
