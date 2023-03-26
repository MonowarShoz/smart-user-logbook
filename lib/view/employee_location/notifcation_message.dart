import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_launcher/url_launcher.dart';

class NotifMessage extends StatefulWidget {
  final RemoteMessage message;
  const NotifMessage({super.key, required this.message});

  @override
  State<NotifMessage> createState() => _NotifMessageState();
}

class _NotifMessageState extends State<NotifMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Remote Message'),
      ),
      body: Center(
        child: Text('${widget.message.data['message']}}'),
      ),
    );
  }
}
