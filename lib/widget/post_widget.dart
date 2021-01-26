import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foody_app/model/like_model.dart';
import 'package:foody_app/model/post_model.dart';
import 'package:foody_app/services/postService.dart';
import 'package:foody_app/services/userService.dart';
import 'package:foody_app/view/commentView.dart';
import 'package:foody_app/utils/mapUtils.dart';

import '../resource/app_colors.dart';

class PostWidget extends StatefulWidget {
  final PostModel post;
  // final Function like;
  // final Function comment;

  const PostWidget({Key key, this.post}) : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool liked = false;
  double averageScore = 0.0;
  dynamic ownerId = 0;

  @override
  void initState() {
    super.initState();

    averageScore = (widget.post.services +
            widget.post.taste +
            widget.post.cleanliness +
            widget.post.price) /
        4;
    getOwnerIdAndLikes();
  }

  void getOwnerIdAndLikes() async {
    dynamic user = await UserService().getSelfId();
    ownerId = user['id'];
    Like like = new Like(postId: widget.post.id, userId: ownerId);
    bool isLiked = await PostService().readLike(like);
    this.liked = isLiked;
  }

  void openCommentView(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(
      builder: (BuildContext context) {
        return CommentView(postId: widget.post.id, ownerId: ownerId);
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.zero,
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.PRIMARY_COLOR,
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
              // CircleAvatar(
              //   radius: 20,
              //   backgroundColor: Colors.white,
              //   backgroundImage:
              //       AssetImage(post.profileImage ?? 'assets/app_logo.png'),

              // ),
            ),
            title: Text(
              widget.post.username ?? "No Username",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: AppColors.TEXT_COLOR,
              ),
            ),
            subtitle: Text(
              widget.post.location.locationName ?? 'Mid Valley',
              style: TextStyle(
                fontSize: 18.0,
                color: AppColors.PRIMARY_COLOR,
              ),
            ),
            trailing: IconButton(
              icon: Icon(
                Icons.location_pin,
                size: 30.0,
              ),
              onPressed: () {
                MapUtils.openMap(widget.post.location.latitude,
                    widget.post.location.longitude);
              },
            ),
          ),
          Row(
            children: [
              Container(
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      widget.post.postImages ??
                          "https://image.freepik.com/free-vector/404-error-page-found_41910-364.jpg",
                    ),
                    // Image.asset(
                    //   post.postImages ?? 'assets/app_logo.png',
                    //   width: 350,
                    // ),
                  ),
                ),
              ),
              Container(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: IconButton(
                        onPressed: () async {
                          // print("before, $liked");
                          if (!liked) {
                            Like like = new Like(
                                id: 2,
                                postId: widget.post.id,
                                userId: ownerId,
                                postReaction: "like");
                            bool isLiked = await PostService().createLike(like);
                            print("like status is $isLiked");
                          }

                          setState(() {
                            liked = !liked;
                          });
                        },
                        icon: liked
                            ? Icon(
                                CupertinoIcons.heart_fill,
                                size: 35,
                                color: AppColors.DANGER_COLOR,
                              )
                            : Icon(
                                CupertinoIcons.heart,
                                size: 35,
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: IconButton(
                        icon: Icon(
                          CupertinoIcons.chat_bubble_text,
                          size: 35,
                        ),
                        onPressed: () {
                          openCommentView(context);
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: RatingBarIndicator(
                  rating: averageScore,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemSize: 30.0,
                  itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Center(
                child: Text(
                  averageScore.toStringAsFixed(2).toString() ?? '-',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: AppColors.PRIMARY_COLOR,
                  ),
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ratingWidget(
                  Icons.sentiment_satisfied_alt, widget.post.services),
              _ratingWidget(Icons.cleaning_services, widget.post.cleanliness),
              _ratingWidget(Icons.restaurant, widget.post.taste),
              _ratingWidget(Icons.attach_money, widget.post.price),
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, bottom: 4.0),
                child: Text(
                  widget.post.username ?? "No Username",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    widget.post.caption ?? '',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          FlatButton(
            onPressed: () {
              openCommentView(context);
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'View more comment...',
                style: TextStyle(
                  color: AppColors.PRIMARY_COLOR,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          Divider(
            height: 40,
            thickness: 1,
            indent: 10,
            endIndent: 10,
          ),
        ],
      ),
    );
  }

  _ratingWidget(IconData icon, double score) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 22.0,
        ),
        SizedBox(width: 5),
        Text(
          score.toString() ?? '-',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22.0,
            color: AppColors.PRIMARY_COLOR,
          ),
        ),
      ],
    );
  }
}
