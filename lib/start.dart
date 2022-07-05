import 'package:draw/draw.dart';
import 'package:estudos_app/comments.dart';
import 'package:flutter/material.dart';

class Start extends StatefulWidget {
  Start({required this.subreddit});

  final String subreddit;

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  final posts = <Submission>[];

  late Reddit reddit;

  @override
  void initState() {
    super.initState();
    Reddit.createReadOnlyInstance(
      clientId: '3lGeRnaR6VYInvsFqTIfNA',
      clientSecret: 'ySO4pDSieFaDCitnbtgqbM5sdEd2Aw',
      userAgent: 'flutter:reddit_search_gabriel_fonseca:1.0.0',
    ).then((instance) {
      reddit = instance;
      _fetch();
    });
  }

  Future<void> _fetch() async {
    final stream =
        reddit.subreddit(widget.subreddit).hot().asBroadcastStream();
    posts.clear();

    stream.listen((content) {
      if (content is Submission) {
        posts.add(content);
      }
    });

    await stream.last;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Feed'),
          backgroundColor: Colors.red,
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return _fetch();
          },
          color: Colors.red,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: posts.length,
            itemBuilder: (_, i) => GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Comments(post: posts[i]),
                  ),
                );
              },
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(children: [
                    if (posts[i].thumbnail.path != "self" &&
                        posts[i].thumbnail.path != "default" &&
                        posts[i].thumbnail.path != "nsfw")
                      SizedBox(
                        width: posts[i].data!['thumbnail_width']?.toDouble() ??
                            0.0,
                        height: posts[i].data!['thumbnail_width']?.toDouble() ??
                            0.0,
                        child: Image.network(posts[i].thumbnail.toString()),
                      ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                              child: Text(posts[i].title,
                                  style: new TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400))),
                          Divider(),
                          if (!posts[i].isSelf)
                            Text(posts[i].url.path,
                                style: new TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontStyle: FontStyle.italic)),
                          Divider(),
                          Row(
                            children: [
                              SizedBox(
                                  child: Icon(
                                Icons.arrow_upward,
                                size: 20,
                              )),
                              SizedBox(width: 10.0),
                              Text(posts[i].score.toString()),
                              SizedBox(width: 50.0),
                              SizedBox(
                                  child: Icon(
                                Icons.comment,
                                size: 20,
                              )),
                              SizedBox(width: 10.0),
                              Text(posts[i].numComments.toString()),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
        ));
  }
}
