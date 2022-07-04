import 'package:draw/draw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    print(comments);
  }

  @override
  Widget build(BuildContext context) {
    final content = [
      SizedBox(height: 20.0),
      Text('u/gabrielfonseca',
          style: new TextStyle(
              color: Colors.blueGrey[400],
              fontSize: 12,
              fontStyle: FontStyle.italic)),
      SizedBox(height: 20.0),
      Text('Title',
          style: new TextStyle(fontSize: 22, fontWeight: FontWeight.w400)),
      SizedBox(height: 20.0),
      Text('Score'),
      SizedBox(height: 20.0),
      Text('www.linkdoreddit.com',
          style: new TextStyle(
              color: Colors.blue, fontSize: 16, fontStyle: FontStyle.italic)),
      Divider(),
      SizedBox(
          width: double.infinity,
          height: 100.0,
          child: Icon(Icons.image_not_supported)),
    ];

    final commentList = List.generate(
      comments.length,
      (i) => Column(
        children: [
          SizedBox(height: 100.0),
          Text(comments[i].author),
          SizedBox(height: 20.0),
          Text(comments[i].body!),
          SizedBox(height: 20.0),
          Text(comments[i].score.toString()),
        ],
      ),
    );

    content.addAll(commentList);

    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
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
