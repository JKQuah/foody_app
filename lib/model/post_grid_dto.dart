class PostGridDTO{
  int postId;
  String imageUrl;

  PostGridDTO({
    this.postId,
    this.imageUrl
  });

  factory PostGridDTO.fromJson(Map<String, dynamic> json) {
    return PostGridDTO(
      postId: json['username'] as int,
      imageUrl: json['media_link'] as String
    );
  }
}