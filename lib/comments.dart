import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class Comments extends ConsumerStatefulWidget {
  Comments({required this.post});

  final Submission post;

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends ConsumerState<Comments> {
  late Reddit reddit;

  final comments = <Comment>[];

  @override
  void initState() {
    super.initState();
    _fetch();
  }

  void _fetch() async {
    await widget.post.refresh();
    await widget.post.refreshComments();
    comments.clear();
    comments.addAll(widget.post.comments?.comments.whereType<Comment>() ?? []);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final content = [
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.0),
            Text("u/${widget.post.author}",
                style: new TextStyle(
                    color: Colors.blueGrey[400],
                    fontSize: 12,
                    fontStyle: FontStyle.italic)),
            SizedBox(height: 20.0),
            Text(widget.post.title,
                style:
                    new TextStyle(fontSize: 22, fontWeight: FontWeight.w400)),
            SizedBox(height: 20.0),
            Row(
              children: [
                SizedBox(
                    child: Icon(
                  Icons.arrow_upward,
                  size: 24,
                )),
                SizedBox(width: 8.0),
                Text(widget.post.score.toString()),
              ],
            ),
            SizedBox(height: 20.0),
            if (!widget.post.isSelf)
              GestureDetector(
                onTap: () => launchUrl(widget.post.url),
                child: Text(widget.post.url.toString(),
                    style: new TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontStyle: FontStyle.italic)),
              ),
          ],
        ),
      ),
      Divider(),
      if ((!widget.post.isSelf)&&(widget.post.data?["post_hint"] == "image"))
        SizedBox(
            width: double.infinity,
            height: 500.0,
            child: Image.network(widget.post.url.toString())),
      Container(
        color: Colors.amber[50],
        child: Column(
          children: List<Widget>.generate(
            comments.length,
            (i) => Column(
              children: [
                Card(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(height: 50.0),
                            SizedBox(
                                child: Icon(
                              Icons.arrow_upward,
                              size: 24,
                            )),
                            SizedBox(width: 5.0),
                            Text(comments[i].score.toString()),
                            SizedBox(width: 20.0),
                            Text("u/${comments[i].author}",
                                style: new TextStyle(
                                    color: Colors.blueGrey[400],
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic)),
                          ],
                        ),
                        SizedBox(height: 10.0),
                        Text(comments[i].body!),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: content,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
