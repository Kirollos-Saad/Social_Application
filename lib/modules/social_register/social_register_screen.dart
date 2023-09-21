import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/social_layout.dart';
import '../../shared/components.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialRegisterScreen extends StatelessWidget
{
  var formKey= GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SocialRegisterCubit() ,
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterStates>(
        listener: (BuildContext context, state) {
          if (state is SocialCreateUserSuccessState) {
            navigateAndFinish(
              context,
              SocialLayout(),
            );
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
                          'REGISTER',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Register now to communicate with friends',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          controller: nameController,
                          keyboardType:TextInputType.name ,
                          validator:(value){
                            if(value!.isEmpty)
                            {
                              return 'Please enter your name';
                            }
                          } ,
                          decoration: InputDecoration(
                            labelText:'User Name',
                            prefixIcon: Icon(
                              Icons.person,
                            ),
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
                          obscureText: SocialRegisterCubit.get(context).isPassword,
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
                                  SocialRegisterCubit.get(context).changePasswordVisibility();
                                },
                                icon:Icon( SocialRegisterCubit.get(context).suffix) ),

                          ),
                          onFieldSubmitted:(value){
                          },
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        TextFormField(
                          controller: phoneController,
                          keyboardType:TextInputType.phone ,
                          validator:(value){
                            if(value!.isEmpty)
                            {
                              return 'Please enter your phone number';
                            }
                          } ,
                          decoration: InputDecoration(
                            labelText:'Phone',
                            prefixIcon: Icon(
                              Icons.phone,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        ConditionalBuilder(
                          condition: state is!SocialRegisterLoadingState ,
                          builder: (context)=> Container(
                            width:double.infinity,
                            height: 50.0,
                            child: MaterialButton(
                              onPressed: (){
                                if (formKey.currentState!.validate())
                                {
                                  SocialRegisterCubit.get(context).userRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                    phone: phoneController.text,
                                 );

                                }
                              },
                              child: Text(
                                'Register',
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
