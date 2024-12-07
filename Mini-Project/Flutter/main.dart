import 'dart:html';
import 'dart:convert'; // For parsing JSON
import 'dart:async'; // For asynchronous programming

void main() {
  // Reference to form and inputs
  final loginForm = querySelector('#loginForm') as FormElement;
  final usernameInput = querySelector('#username') as InputElement;
  final passwordInput = querySelector('#password') as InputElement;

  // Event listener for form submission
  loginForm.onSubmit.listen((event) async {
    event.preventDefault(); // Prevent default form submission

    // Get user input
    final username = usernameInput.value ?? '';
    final password = passwordInput.value ?? '';

    try {
      // Call the API
      final response = await HttpRequest.getString('https://jsonplaceholder.typicode.com/users');
      final List<dynamic> users = jsonDecode(response);

      // Validate user
      final isValidUser = users.any((user) =>
          user['username'] == username && user['email'] == password);

      // Display result
      if (isValidUser) {
        window.alert('Sign in Successful');
        navigateToUploadScreen();
      } else {
        window.alert('Sign in Unsuccessful. Please try again.');
      }
    } catch (e) {
      window.alert('Error while connecting to the server: $e');
    }
  });
}

// Function to navigate to Upload Documents Screen
void navigateToUploadScreen() {
  // Simulating navigation to another page
  document.body!.innerHtml = '''
    <h1>Upload Documents</h1>
    <p>Welcome! You can now upload your documents.</p>
  ''';
}


import 'dart:html';
import 'dart:convert'; // For parsing JSON
import 'dart:async'; // For asynchronous programming

void main() {
  // Reference to form and inputs
  final loginForm = querySelector('#loginForm') as FormElement;
  final usernameInput = querySelector('#username') as InputElement;
  final passwordInput = querySelector('#password') as InputElement;

  // Event listener for form submission
  loginForm.onSubmit.listen((event) async {
    event.preventDefault(); // Prevent default form submission

    // Get user input
    final username = usernameInput.value ?? '';
    final password = passwordInput.value ?? '';

    try {
      // Call the API
      final response = await HttpRequest.getString('https://jsonplaceholder.typicode.com/users');
      final List<dynamic> users = jsonDecode(response);

      // Validate user
      final isValidUser = users.any((user) =>
          user['username'] == username && user['email'] == password);

      // Display result
      if (isValidUser) {
        window.alert('Sign in Successful');
        navigateToNextPage();
      } else {
        window.alert('Sign in Unsuccessful. Please try again.');
      }
    } catch (e) {
      window.alert('Error while connecting to the server: $e');
    }
  });
}

// Function to navigate to the next page
void navigateToNextPage() {
  window.location.href = 'upl.html'; // Redirects to upl.html
}


import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;

  LoginSubmitted(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/login/login_bloc.dart';
import 'blocs/login/login_event.dart';
import 'blocs/login/login_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => LoginBloc(),
        child: const LoginPage(),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Log In', style: TextStyle(fontSize: 24)),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email Address'),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              BlocConsumer<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(const SnackBar(content: Text('Login Successful')));
                  } else if (state is LoginFailure) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.error)));
                  }
                },
                builder: (context, state) {
                  if (state is LoginLoading) {
                    return const CircularProgressIndicator();
                  }

                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          final email = emailController.text;
                          final password = passwordController.text;
                          context.read<LoginBloc>().add(LoginSubmitted(email, password));
                        },
                        child: const Text('LOGIN'),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Forgot Password?'),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 8),
              const Text("Don't have an account? Register Here"),
            ],
          ),
        ),
      ),
    );
  }
}
