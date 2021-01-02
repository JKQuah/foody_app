import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foody_app/model/post_model.dart';

import '../resource/app_colors.dart';

class PostWidget extends StatefulWidget {
  final PostModel post;
  final Function like;
  final Function comment;

  const PostWidget({Key key, this.post, this.comment, this.like})
      : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool liked = false;

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
              widget.post.username,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.TEXT_COLOR,
              ),
            ),
            subtitle: Text(
              widget.post.location ?? 'Default Restaurant',
              style: TextStyle(
                fontSize: 18.0,
                color: AppColors.PRIMARY_COLOR,
              ),
            ),
            trailing: Icon(
              Icons.location_on,
              size: 30,
            ),
          ),
          Row(
            children: [
              Container(
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,

                    image: NetworkImage(
                      "https://64.media.tumblr.com/9c54cf83b096e7b31bff2a444eb0a979/17f389f91054af1f-45/s1280x1920/233b6a8342eb701279ac787936268f747b96dc3f.png",
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
                        onPressed: () {
                          setState(() {
                            liked = !liked;
                          });
                        },
                        icon: liked == true
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
                        onPressed: () {},
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
                child: Icon(Icons.star_rate),
              ),
              Icon(Icons.star_rate),
              Icon(Icons.star_rate),
              Icon(Icons.star_rate),
              Icon(Icons.star_rate),
              SizedBox(width: 10),
              Center(
                child: Text(
                  widget.post.averageScore ?? '0.0',
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
              Row(
                children: [
                  Icon(Icons.sentiment_satisfied_alt),
                  SizedBox(width: 5),
                  Text(
                    widget.post.happyScore ?? '0.0',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: AppColors.PRIMARY_COLOR,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.cleaning_services),
                  SizedBox(width: 5),
                  Text(
                    widget.post.cleanScore ?? '0.0',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: AppColors.PRIMARY_COLOR,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(Icons.restaurant),
                  SizedBox(width: 5),
                  Text(
                    widget.post.tasteScore ?? '0.0',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: AppColors.PRIMARY_COLOR,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Text(
                  widget.post.username,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
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
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    widget.post.caption ??
                        'Lorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumLorem ipsumpsumLorem ipsum',
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
            onPressed: () {},
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
}
