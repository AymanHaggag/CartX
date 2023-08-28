import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/cubit/shop_states.dart';
import '../../shared/components.dart';
import '../login/cubit/user_cubit.dart';
import '../login/cubit/user_states.dart';

class UpdateProfileScreen extends StatelessWidget {
  UpdateProfileScreen({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {
        if (state is! UserLoadingState) {
          if (UserCubit.get(context).userModel!.status) {
            debugPrint(UserCubit.get(context).userModel!.message);
            // CacheHelper.saveData(
            //     key: "token",
            //     value: ShopLoginCubit.get(context).userModel.data?.token);
            showToast(
                UserCubit.get(context).userModel!.message,
                ToastStates.success);
          }
          else {
            debugPrint(UserCubit.get(context).userModel!.message);
            showToast(UserCubit.get(context).userModel!.message,
                ToastStates.error);
          }
        }
      },
      builder: (context, state) {

        nameController.text = UserCubit.get(context).userModel!.data!.name;
        emailController.text = UserCubit.get(context).userModel!.data!.email;
        phoneNumberController.text = UserCubit.get(context).userModel!.data!.phone;

        return Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if(state is ShopLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 50,
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Profile Update",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w600),
                        ),
                      ],
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
                      prefix: Icons.phone,
                      controller: phoneNumberController ,
                      type: TextInputType.number,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your Phone Number';
                        }
                      },
                      label: "Phone Number",
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ConditionalBuilder(
                        condition: state is! ShopLoadingState,
                        builder: (context) => defaultButton(
                            title: "Save Now",
                            onPressed: () {
                              if (formKey.currentState!.validate()) {

                                UserCubit.get(context).update(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phoneNumberController.text,
                                  image: UserCubit.get(context).userModel!.data!.image,

                                );
                              }
                            }),
                        fallback: (context) =>
                            const Center(child: CircularProgressIndicator())),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
