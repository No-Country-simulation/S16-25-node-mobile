import 'package:app_patitas/auth/pages/forms/login_form.dart';
import 'package:app_patitas/auth/pages/forms/register_form.dart';
import 'package:app_patitas/config/constantes/const.dart';
import 'package:flutter/material.dart';

class RegisterAndLoginPage extends StatelessWidget {
  const RegisterAndLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 200,
          centerTitle: true,
          title: const Text(
            '¡PatitasEnRed!',
            style: TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.bold,
              color: Const.primaryColorTextOrange,
            ),
            textAlign: TextAlign.center,
          ),
          bottom: const TabBar(
            unselectedLabelColor: Const.primaryColorTextOrange,
            indicatorColor: Const.primaryColorTextOrange,
            indicatorWeight: 4,
            labelStyle: TextStyle(
                fontSize: 18,
                //fontWeight: FontWeight.bold,
                color: Const.primaryColorTextOrange),
            tabs: [
              Tab(text: 'Register'),
              Tab(text: 'Login'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RegisterForm(),
            LoginForm(),
          ],
        ),
      ),
    );
  }
}
