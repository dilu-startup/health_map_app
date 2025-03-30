import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_health_map_app/core/routes/app_pages.dart';
import 'package:validatorless/validatorless.dart';

import '../controllers/auth_controller.dart';

class LoginPage extends GetView<AuthController> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: SingleChildScrollView( // Add this for scrollable content
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min, // Add this
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: Validatorless.multiple([
                  Validatorless.required('Email is required'),
                  Validatorless.email('Invalid email'),
                ]),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: Validatorless.multiple([
                  Validatorless.required('Password is required'),
                  Validatorless.min(6, 'Password must be at least 6 characters'),
                ]),
              ),
              SizedBox(height: 32),
              Obx(() => controller.isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _submit,
                child: Text('Login'),
              )),
              TextButton(
                onPressed: () => Get.toNamed(Routes.SIGNUP),
                child: Text('Create an account'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      controller.login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    }
  }
}