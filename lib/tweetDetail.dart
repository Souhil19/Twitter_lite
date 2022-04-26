import 'package:flutter/material.dart';
import 'package:twitter/main.dart';
import 'package:twitter/tts.dart';
import 'package:twitter/tweet.dart';

class tweetDetail extends StatelessWidget {
  //const tweetDetail({key , this.tw}) : super(key: key);
  final List<Tweet> list;
  final int index;


tweetDetail({
    @required this.index, @required this.list,
});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tweet Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    CircleAvatar(
                      radius: 100.0,
                      backgroundImage: NetworkImage(
                          'https://avatars.githubusercontent.com/u/45470744?v=4'),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        bottom: 3.0,
                        end: 3.0,
                      ),
                      child: CircleAvatar(
                        radius: 20.0,
                        backgroundColor: Colors.green,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Souhil OMARI',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  '${list[index].content}',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  '${list[index].time}',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                ElevatedButton(
                  onPressed: () {
                    //Navigator.pop(context);
                    tts().speak(list[index].content);
                  },
                  child: const Text('Listen to Tweet'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
