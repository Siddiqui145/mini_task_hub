import 'package:flutter/material.dart';

void showErrorMessage(BuildContext context, String message){

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Center(
        child: Text(message,
    style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Colors.white),)),
              backgroundColor: Colors.red,
              behavior: SnackBarBehavior.floating,
              duration: Duration(
                milliseconds: 1500
              ),));
}

void showSuccessMessage(BuildContext context, String message){

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Center(
        child: Text(message,
    style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Colors.white),)),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              duration: Duration(
                milliseconds: 1500
              ),));
}