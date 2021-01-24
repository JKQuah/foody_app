class PostGridDTO{
  int postId;
  String imageUrl;

  PostGridDTO({
    postId,
    imageUrl
  });

  factory PostGridDTO.fromJson(Map<String, dynamic> json) {
    return PostGridDTO(
      postId: json['username'] as String,
      imageUrl: json['media_link'] as String
    );
  }
}