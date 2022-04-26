import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:twitter/splashScreen.dart';
import 'package:twitter/tweetDetail.dart';

import 'tweet.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twitter App',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: splashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController mycontroller = TextEditingController();
  String tw = '';
  final List<Tweet> list=[];

  @override
  void initState() {
    super.initState();
    TextEditingController mycontroller;
  }

  @override
  void dispose() {
    mycontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title:
            Text('Flutter Twitter App', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: FaIcon(FontAwesomeIcons.twitter),
            onPressed: () async {
              final tw = await openDialog(context);
              if (tw == null || tw.isEmpty) return;
              print(tw);
              setState(() {
                this.tw = tw;
              });
            },
            tooltip: 'Add a tweet',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              //Text(
                //'Votre tweet est: $tw ',
              //),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => buildTweetItem(context,index),
                separatorBuilder: (context, index) => SizedBox(
                  height: 20.0,
                ),
                itemCount: list.length,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final tw = await openDialog(context);
          if (tw == null || tw.isEmpty) return;
          print(tw);
          setState(() {
            this.tw = tw;
          });
        },
        tooltip: 'Add Tweet',
        child: Icon(Icons.edit),
      ),
    );
  }

  Future<String> openDialog(context) => showDialog<String>(
        context: context,
        builder: (context) => Center(
          child: SingleChildScrollView(
            child: AlertDialog(
              title: Text('Publish a Tweet'),
              content: TextField(
                decoration: InputDecoration(hintText: 'What are you thinking ?'),
                controller: mycontroller,
                onTap: () {
                  print(mycontroller.text);
                },
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      tweet(context);
                    },
                    child: Text('Tweet')),
              ],
            ),
          ),
        ),
      );
  void tweet(context) {
    Navigator.of(context).pop(mycontroller.text);
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);

    setState(() {
      //liste.add(mycontroller.text);
      Tweet twt = Tweet(content: mycontroller.text.toString(),time:formattedDate);
      list.add(twt);
    });

    mycontroller.clear(); // pour vider le contenu de controller aprés le tweet
  }

  Widget buildTweetItem(context, index) =>
      InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => tweetDetail(list:list ,index: index,)),
          );
        },
        onLongPress: (){
          openDialogDelete(context,index);
          print('long press');

          },
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(
                      'https://avatars.githubusercontent.com/u/45470744?v=4'),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    bottom: 3.0,
                    end: 3.0,
                  ),
                  child: CircleAvatar(
                    radius: 7.0,
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Souhil OMARI',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children:
                    [
                      Expanded(
                        child: Text(
                          '${list[index].content}',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                        child: Container(
                          width: 7.0,
                          height: 7.0,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Text(
                        '${list[index].time}',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Future<String> openDialogDelete(context,index) => showDialog<String>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Delete Tweet'),
      content: Text('Are You Sure ?'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('No')),
        TextButton(
            onPressed: () {
              //here
              setState(() {
                list.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: Text('Yes')),
      ],
    ),
  );


}
