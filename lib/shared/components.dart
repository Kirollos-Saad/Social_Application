import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../modules/social_login/social_login_screen.dart';
import '../network/cache_helper.dart';
import 'styles/icon_broken.dart';


void navigateTo(context,widget)=> Navigator.push(
  context,
  MaterialPageRoute(builder: (context)=>widget),
);

void navigateAndFinish(context,widget)=>
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context)=>widget,
        ),
            (Route<dynamic> route)=>false

    );

void signOut(context)
{
  CacheHelper.removeData(key: 'uId',).then((value) =>{
    if(value!)
      {
        navigateAndFinish(context,SocialLoginScreen()),
      }
  });
}

PreferredSizeWidget? defaultAppBar({
  required BuildContext context,
   String? title,
  List<Widget>? actions,
}) => AppBar(
  leading: IconButton(
    onPressed: ()
    {
      Navigator.pop(context);
    },
    icon: Icon(
      IconBroken.Arrow___Left_2,
    ),
  ),
  titleSpacing: 5.0,
  title: Text(
    title!,
  ),
  actions: actions,
);

Widget myDivider()=> Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

String token= '';
String uId= '';
void showToast({
  required String text,
  required ToastStates state,

})=> Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates{SUCCESS,ERROR,WARNING}

Color ?chooseToastColor(ToastStates state)
{
  Color ?color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}