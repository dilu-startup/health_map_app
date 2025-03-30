import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';
import '../controllers/auth_controller.dart';

class SignupPage extends GetView<AuthController> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _ageController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _bloodGroupController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final RxBool _isBloodDonor = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Username
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(labelText: 'Username'),
                validator: Validatorless.required('Username is required'),
              ),
              SizedBox(height: 16),

              // Date of Birth
              TextFormField(
                controller: _dateOfBirthController,
                decoration: InputDecoration(
                  labelText: 'Date of Birth',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                validator: Validatorless.required('Date of birth is required'),
                readOnly: true,
              ),
              SizedBox(height: 16),

              // Age
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
                validator: Validatorless.multiple([
                  Validatorless.required('Age is required'),
                  Validatorless.number('Must be a valid number'),
                ]),
              ),
              SizedBox(height: 16),

              // Phone
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: Validatorless.multiple([
                  Validatorless.required('Phone number is required'),
                  Validatorless.number('Must be a valid number'),
                ]),
              ),
              SizedBox(height: 16),

              // Email
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: Validatorless.multiple([
                  Validatorless.required('Email is required'),
                  Validatorless.email('Invalid email'),
                ]),
              ),
              SizedBox(height: 16),

              // Blood Group
              DropdownButtonFormField<String>(
                value: null,
                decoration: InputDecoration(labelText: 'Blood Group'),
                items: [
                  'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  _bloodGroupController.text = value ?? '';
                },
                validator: (value) =>
                value == null ? 'Blood group is required' : null,
              ),
              SizedBox(height: 16),

              // Blood Donor Checkbox
              Obx(() => CheckboxListTile(
                title: Text('Are you a blood donor?'),
                value: _isBloodDonor.value,
                onChanged: (bool? value) {
                  _isBloodDonor.value = value ?? false;
                },
              )),
              SizedBox(height: 16),

              // Address
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
                maxLines: 3,
                validator: Validatorless.required('Address is required'),
              ),
              SizedBox(height: 16),

              // Password
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: Validatorless.multiple([
                  Validatorless.required('Password is required'),
                  Validatorless.min(6, 'Password must be at least 6 characters'),
                ]),
              ),
              SizedBox(height: 16),

              // Confirm Password
              TextFormField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(labelText: 'Confirm Password'),
                obscureText: true,
                validator: Validatorless.multiple([
                  Validatorless.required('Please confirm password'),
                  Validatorless.compare(
                    _passwordController,
                    'Passwords do not match',
                  ),
                ]),
              ),
              SizedBox(height: 32),

              // Submit Button
              Obx(() => controller.isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _submit,
                child: Text('Sign Up'),
              )),
              TextButton(
                onPressed: () => Get.back(),
                child: Text('Already have an account? Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _dateOfBirthController.text =
      "${picked.day}/${picked.month}/${picked.year}";
      // Calculate age
      final age = DateTime.now().year - picked.year;
      _ageController.text = age.toString();
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      controller.signup(
        _usernameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text.trim(),
        // Add additional parameters to your signup method
        dateOfBirth: _dateOfBirthController.text.trim(),
        age: int.tryParse(_ageController.text.trim()) ?? 0,
        phone: _phoneController.text.trim(),
        bloodGroup: _bloodGroupController.text.trim(),
        isBloodDonor: _isBloodDonor.value,
        address: _addressController.text.trim(),
      );
    }
  }
}