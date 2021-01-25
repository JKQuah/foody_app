import 'package:flutter/material.dart';
import 'package:foody_app/resource/app_colors.dart';
import 'package:foody_app/model/comment.dart';
import 'package:foody_app/services/commentService.dart';
import 'package:foody_app/widget/comment_widget.dart';

class CommentView extends StatefulWidget {
  final int postId;
  final int ownerId;
  const CommentView({this.postId, this.ownerId});
  @override
  _CommentViewState createState() =>
      _CommentViewState(postId: postId, ownerId: ownerId);
}

class _CommentViewState extends State<CommentView> {
  bool isCommented = false;
  List<Comment> fetchedComments = [];
  final TextEditingController _commentController = TextEditingController();
  final int postId;
  final int ownerId;

  _CommentViewState({this.postId, this.ownerId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_left,
            color: Colors.grey[900],
            size: 35,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Comment',
          style: TextStyle(
            fontFamily: 'Nexa',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: buildCommentList(postId),
          ),
          Divider(),
          ListTile(
            title: TextFormField(
              style: TextStyle(fontSize: 22.0),
              controller: _commentController,
              decoration: InputDecoration(
                labelText: 'Write a comment...',
                contentPadding: EdgeInsets.zero,
                fillColor: Colors.red,
                focusColor: Colors.grey,
                border: InputBorder.none,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                addComment(postId, ownerId, _commentController.text);
              },
              icon: Icon(Icons.send),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCommentList(int postId) {
    return FutureBuilder<List<Comment>>(
      future: getComments(postId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          this.fetchedComments = snapshot.data;
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              final item = snapshot.data[index];
              return CommentWidget(comment: item, ownerId: ownerId);
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<List<Comment>> getComments(postId) async {
    // List<Comment> comments = [];

    List<Comment> comments = await CommentService().fetchComments(postId);
    return comments;
  }

  addComment(int postId, int userId, String comment) async {
    _commentController.clear();
    Comment commentObj = new Comment(
      postId: postId,
      userId: userId,
      comment: comment ?? "",
    );
    int commentId = await CommentService().createComment(commentObj);
    setState(() {
      FocusScope.of(context).unfocus();
    });
  }
}
