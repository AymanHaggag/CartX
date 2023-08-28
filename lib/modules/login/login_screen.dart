import 'package:catrx/style/themes/themes_conestants.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../layout/home_screen.dart';
import '../../shared/components.dart';
import '../../shared/local/sheared_preferances.dart';
import '../register/register_screen.dart';
import 'cubit/user_cubit.dart';
import 'cubit/user_states.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {
        if (state is UserLoginSuccessfulState) {
          if (UserCubit.get(context).userModel!.status) {
            debugPrint(UserCubit.get(context).userModel!.message);
            CacheHelper.saveData(key: "token", value: UserCubit.get(context).userModel!.data?.token);
            showToast(UserCubit.get(context).userModel!.message, ToastStates.success);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false);
          } else {
            debugPrint(UserCubit.get(context).userModel!.message);
            showToast(UserCubit.get(context).userModel!.message,
                ToastStates.error);
          }
        }
      },
      builder: (context, state) {
        return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 200,),

                      const Text(
                        'Hello Again!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Fill Your Details To See Our Latest Offers',
                        style: TextStyle(fontSize: 15),
                      ),
                      const SizedBox(
                        height: 85,
                      ),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.text,
                        hintText: 'xyz@gmail.com',
                        validate: (var value) {
                          if (value.isEmpty) {
                            return 'Please enter your email';
                          }
                        },
                        label: "Email Address",
                        prefix: Icons.email,
                      ),
                      const SizedBox(
                        height: 10,
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
                        height: 5,
                      ),
                      Row(
                        children: [
                          Spacer(),
                          TextButton(onPressed: (){}, child: Text("Recovery Password"))

                      ],),
                      const SizedBox(
                        height: 15,
                      ),
                      ConditionalBuilder(
                          condition: state is! UserLoadingState,
                          builder: (context) =>Container(
                            height: 45,
                            width: double.infinity,
                            child:   ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  UserCubit.get(context).login(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                  CacheHelper.saveData(key: "onboarding", value: true);
                                }
                                debugPrint(UserCubit.get(context).userModel!.data!.token);
                              },
                              child: Text('Login'),
                              style: ElevatedButton.styleFrom(
                                shadowColor: Colors.black,
                                backgroundColor: defaultColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(13),
                                ),

                              ),

                            ),
                          ) ,
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator())),
                      SizedBox(height: 170,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'New User? ',
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterScreen()),
                              );
                            },
                            child:  Text(
                              'Create Account',
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
