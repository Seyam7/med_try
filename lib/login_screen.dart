import 'package:flutter/material.dart';
import 'package:medai_try/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  SharedPreferences? sharedPreferences;

  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey();

  userCheck() async {
    sharedPreferences = await SharedPreferences.getInstance();
    var userData = await sharedPreferences!.getString('user');
    var passData = await sharedPreferences!.getString('pass');
    if (userData != null && passData != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    }
  }

  @override
  void initState() {
    userCheck();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'username cannot be empty';
                  }
                },
                controller: userController,
                //autofocus: true,
              ),
              TextFormField(
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'password cant be empty';
                  }
                },
                controller: passwordController,
                //autofocus: true,
              ),
              MaterialButton(
                onPressed: () async {
                  sharedPreferences = await SharedPreferences.getInstance();
                  sharedPreferences!
                      .setString('user', userController.text.toString());
                  sharedPreferences!
                      .setString('pass', passwordController.text.toString());
                  print('User: ${sharedPreferences!.getString('user')}');
                  print('Password: ${sharedPreferences!.getString('pass')}');
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                    print('successful');
                  }
                },
                child: Text("Login"),
                color: Colors.blue,
              ),
              MaterialButton(
                onPressed: () async {
                  print('User: ${sharedPreferences!.getString('user')}');
                  print('Password: ${sharedPreferences!.getString('pass')}');
                },
                child: Text("Check data"),
                color: Colors.green,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Text('home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
