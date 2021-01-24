class ProfileDTO{
  String username;
  String imageUrl;
  String gender;
  String biography;
  int postCount;
  int followingCount;
  int followerCount;

  ProfileDTO({
    this.username,
    this.imageUrl,
    this.gender,
    this.biography,
    this.postCount,
    this.followingCount,
    this.followerCount
  });

  factory ProfileDTO.fromJson(Map<String, dynamic> json) {
    return ProfileDTO(
      username: json['username'] as String,
      imageUrl: json['imageUrl'] as String,
      gender: json['gender'] as String,
      biography: json['biography'] as String,
      postCount: json['postCount'] as int,
      followingCount: json['followingCount'] as int,
      followerCount: json['followerCount'] as int
    );
  }
}

