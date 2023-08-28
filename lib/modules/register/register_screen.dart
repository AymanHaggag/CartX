import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/home_screen.dart';
import '../../shared/components.dart';
import '../../shared/local/sheared_preferances.dart';
import '../login/cubit/user_cubit.dart';
import '../login/cubit/user_states.dart';
import '../login/login_screen.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(),
      child: BlocConsumer<UserCubit, UserStates>(
        listener: (context, state) {
          if (state is UserSignUpSuccessfulState) {
            if (UserCubit.get(context).userModel!.status) {
              debugPrint(UserCubit.get(context).userModel!.message);
              CacheHelper.saveData(
                  key: "token",
                  value: UserCubit.get(context).userModel!.data!.token);
              showToast(
                  UserCubit.get(context).userModel!.message,
                  ToastStates.success);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                  (route) => false);
            }
            else {
              debugPrint(UserCubit.get(context).userModel!.message);
              showToast(UserCubit.get(context).userModel!.message,
                  ToastStates.error);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Register Account",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w900),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'Fill Your Details To See Our Latest Offers',
                            style: TextStyle(fontSize: 15),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          defaultFormField(
                            prefix: Icons.short_text,
                            controller: nameController,
                            type: TextInputType.text,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your Name';
                              }
                            },
                            label: "User Name",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                            prefix: Icons.mail,
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your E-mail';
                              }
                            },
                            label: "E-mail",
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                            isPassword: UserCubit.get(context).hidePass,
                            controller: passwordController,
                            type: TextInputType.text,
                            validate: (var value) {
                              if (value.isEmpty) {
                                return 'Please enter your password';
                              }
                            },
                            label: "Password",
                            prefix: Icons.lock_outline,
                            suffix: UserCubit.get(context).suffixIcon,
                            suffixPressed: () {
                              UserCubit.get(context).hidePassword();
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
                            prefix: Icons.phone,
                            controller: phoneNumberController,
                            type: TextInputType.number,
                            validate: (value) {
                              if (value.isEmpty) {
                                return 'Please enter your Phone Number';
                              }
                            },
                            label: "Phone Number",
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          ConditionalBuilder(
                              condition: state is! UserLoadingState,
                              builder: (context) => defaultButton(
                                  title: "Sign Up",
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      UserCubit.get(context).signUp(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passwordController.text,
                                        phone: phoneNumberController.text,
                                      );
                                    }
                                  }),
                              fallback: (context) =>
                                  const Center(child: CircularProgressIndicator())),
                          const SizedBox(
                            height: 170,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already Have Account?"),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()),
                                      (route) => false);
                                },
                                child: const Text("Log in"),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
