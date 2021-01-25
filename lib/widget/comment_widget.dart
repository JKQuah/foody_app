import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foody_app/model/comment.dart';
import 'package:foody_app/resource/app_colors.dart';
import 'package:foody_app/services/commentService.dart';

class CommentWidget extends StatefulWidget {
  final int ownerId;
  final Comment comment;

  const CommentWidget({Key key, this.comment, this.ownerId}) : super(key: key);

  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.all(10.0),
        leading: CircleAvatar(
          child: Image(
            image: AssetImage("assets/app_logo.png"),
          ),
          backgroundColor: Colors.transparent,
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            widget.comment.username,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        subtitle: Text(
          widget.comment.comment,
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
        trailing: widget.ownerId == widget.comment.userId
            ? IconButton(
                icon: Icon(
                  Icons.delete,
                  color: AppColors.DANGER_COLOR,
                ),
                iconSize: 28.0,
                onPressed: () {
                  setState(() {
                    deleteComment(widget.comment.id);
                  });
                },
              )
            : Text(""),
      ),
    );
  }

  deleteComment(int commentId) async {
    bool isDeleted = await CommentService().deleteComment(commentId);
    if (isDeleted) {
      final snackBar = SnackBar(
        content: Text(
          'Successfully deleted',
          style: TextStyle(fontSize: 16.0),
        ),
        backgroundColor: AppColors.PRIMARY_COLOR,
      );
      // Find the Scaffold in the widget tree and use it to show a SnackBar.
      // ignore: deprecated_member_use
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }
}
