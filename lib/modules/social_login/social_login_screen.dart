import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/social_layout.dart';
import '../../network/cache_helper.dart';
import '../../shared/components.dart';
import '../social_register/social_register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


class SocialLoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
        listener: (BuildContext context, state) {
      if (state is SocialLoginErrorState) {
        showToast(
          text: state.error,
          state: ToastStates.ERROR,
        );
      }
      if(state is SocialLoginSuccessState) {
        CacheHelper.saveData(
          key: 'uId',
          value: state.uId,
        ).then((value) {
          navigateAndFinish(
            context,
            SocialLayout(),
          );
        });
      }
        },
        builder: (BuildContext context, Object? state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Login now to communicate with friends',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          controller: emailController,
                          keyboardType:TextInputType.emailAddress ,
                          validator:(value){
                            if(value!.isEmpty)
                            {
                              return 'Please enter your email address';
                            }
                          } ,
                          decoration: InputDecoration(
                            labelText:'Email Address',
                            prefixIcon: Icon(
                              Icons.email_outlined,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        TextFormField(
                          obscureText: SocialLoginCubit.get(context).isPassword,
                          controller: passwordController,
                          keyboardType:TextInputType.visiblePassword ,
                          validator:(value){
                            if(value!.isEmpty)
                            {
                              return 'Password is too short';
                            }
                          } ,
                          decoration: InputDecoration(
                            labelText:'Password',
                            prefixIcon: Icon(
                              Icons.lock_outline,
                            ),
                            suffixIcon: IconButton(
                                onPressed: (){
                                  SocialLoginCubit.get(context).changePasswordVisibility();
                                },
                                icon:Icon( SocialLoginCubit.get(context).suffix) ),

                          ),
                          onFieldSubmitted:(value){
                            if (formKey.currentState!.validate())
                            {
                          //    SocialLoginCubit.get(context).userLogin(email: emailController.text, password: passwordController.text);

                            }
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is! SocialLoginLoadingState ,
                          builder: (context)=> Container(

                            width:double.infinity,
                            height: 50.0,
                            child: MaterialButton(
                              onPressed: (){
                                if (formKey.currentState!.validate())
                                {
                                 SocialLoginCubit.get(context).userLogin(
                                     email: emailController.text,
                                     password: passwordController.text
                                 );

                                }
                              },
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                3.0,
                              ),
                              color: Colors.blue,
                            ),
                          ),
                          fallback:(context)=> Center(child: CircularProgressIndicator()),
                        ),

                        SizedBox(
                          height: 15.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                            ),
                            TextButton(
                              onPressed: (){
                                navigateTo(
                                  context,
                                  SocialRegisterScreen(),
                                );
                              },
                              child:Text('register'),
                            )

                          ],
                        ),


                      ],
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
