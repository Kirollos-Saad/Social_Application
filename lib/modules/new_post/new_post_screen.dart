import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/shared/components.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../shared/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context,  state) {  },
      builder: (BuildContext context,  state) {
        var userModel = SocialCubit.get(context).userModel;
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Create post',
            actions: [
              TextButton(
                onPressed: () {
                  var now = DateTime.now();

                  if (SocialCubit.get(context).postImage == null)
                  {
                    SocialCubit.get(context).createPost(
                      dateTime: now,
                      text: textController.text,
                    );
                   // SocialCubit.get(context).getPosts();
                    textController.text='';
                  } else
                  {
                    SocialCubit.get(context).uploadPostImage(
                      dateTime: now.toString(),
                      text: textController.text,
                    );
                   // SocialCubit.get(context)..getPosts();
                    textController.text='';
                  }
                },
                child: Text(
                  'POST',
                ),)
            ],
          ),
          body:Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  SizedBox(
                    height: 10.0,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                        '${userModel.image}'
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text(
                        '${userModel.name}',
                        style: TextStyle(
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'What is on your mind ...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if(SocialCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 140.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0,),
                          image: DecorationImage(
                            image: FileImage(File(SocialCubit.get(context).postImage!.path)) as ImageProvider,

                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: CircleAvatar(
                          radius: 20.0,
                          child: Icon(
                            Icons.close,
                            size: 16.0,
                          ),
                        ),
                        onPressed: ()
                        {
                          SocialCubit.get(context).removePostImage();
                        },
                      ),
                    ],
                  ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: ()
                          {
                            SocialCubit.get(context).getPostImage();
                          },
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Icon(
                               IconBroken.Image,
                             ),
                             SizedBox(
                               width: 5.0,
                             ),
                             Text(
                               'add photo',
                             ),
                           ],
                          ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: (){},
                        child:Text(
                          '# tags',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ) ,
        );
      },

    );
  }
}
