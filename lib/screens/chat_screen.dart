import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('messages');
  final _auth = FirebaseAuth.instance;
  User? loggedInUser;
  late String messageText;

  // void messagesStream() async {
  //   await for (var snapshot in _collectionRef.snapshots()) {
  //     for (var message in snapshot.docs) {
  //       print(message.data);
  //     }
  //   }
  // }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void onSendMessage() async {
    if (messageText.isNotEmpty) {
      messageController.clear();
      await _collectionRef
          .add({'sender': loggedInUser!.email, 'text': messageText});
    } else {
      print('Enter Some Text');
    }
  }

  void getCurrentUser() async {
    final user = await _auth.currentUser;
    try {
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages() async {
  //   final messages = await _firestore.collection('messages').get();
  //   for(var message in messages.docs)
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const FaIcon(FontAwesomeIcons.signOutAlt),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder(
              stream: _collectionRef.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      reverse: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        // final message = snapshot.data!.docs.reversed;
                        final messageSender =
                            (snapshot.data!.docs[index].data() as Map)['sender']
                                .toString();
                        final messageText =
                            (snapshot.data!.docs[index].data() as Map)['text']
                                .toString();
                        final currentUser = loggedInUser!.email;
                        // return Card(
                        //   child: ListTile(
                        //     title: Text((snapshot.data!.docs[index].data()
                        //             as Map)['text']
                        //         .toString()),
                        //     subtitle: Text((snapshot.data!.docs[index].data()
                        //             as Map)['sender']
                        //         .toString()),
                        //   ),
                        // );
                        return Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: currentUser == messageSender
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              Text(
                                messageSender,
                                style: const TextStyle(
                                    color: Colors.black54, fontSize: 12),
                              ),
                              Material(
                                borderRadius: currentUser == messageSender
                                    ? const BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30))
                                    : const BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomLeft: Radius.circular(30),
                                        bottomRight: Radius.circular(30)),
                                elevation: 5,
                                color: currentUser == messageSender
                                    ? Colors.lightBlueAccent
                                    : Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Text(
                                    messageText,
                                    style: TextStyle(
                                        color: currentUser == messageSender
                                            ? Colors.white
                                            : Colors.black54,
                                        fontSize: 15),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            // StreamBuilder<QuerySnapshot>(
            //   stream: _collectionRef.snapshots(),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       final messages = snapshot.data!.docs;
            //       List<Text> messageWidgets = [];

            //       for (var message in messages) {
            //         final messageText = message.data()['text'];
            //         final messageSender = message.data();
            //       }
            //     }
            //     return const Text('error');
            //   },
            // ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      onChanged: (value) {
                        messageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageController.clear();
                      onSendMessage();
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// Future<void> getData() async {
//     // Get docs from collection reference
//     QuerySnapshot querySnapshot = await _collectionRef.get();

//     // Get data from docs and convert map to List
//     final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

//     print(allData);
// }


