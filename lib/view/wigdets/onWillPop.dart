import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

 OnWillPop(context,msg){
  return showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text("Exit"),
        content: Text("$msg"),
        actions: [
          CupertinoDialogAction(
              child: Text("YES"),
              onPressed: () {
                SystemChannels.platform
                    .invokeMethod('SystemNavigator.pop');
              }),
          CupertinoDialogAction(
              child: Text("NO"),
              onPressed: () {
                Navigator.of(context).pop(false);
              })
        ],
      ));
}