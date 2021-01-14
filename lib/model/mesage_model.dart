import 'package:foody_app/model/user_model.dart';

class Message {
  final UserModel sender;
  final String
  time;
  final String text;
  final bool isLiked;
  final bool unread;

  Message({
    this.sender,
    this.time,
    this.text,
    this.isLiked,
    this.unread,
  });
}

// User(ME)
final UserModel currentUser = UserModel(
  id: 0,
  username: 'Current User',
  imageUrl: 'assets/images/img.jpg',
);

// OTHER USERS
final UserModel greg = UserModel(
  id: 1,
  username: 'Greg',
  imageUrl: 'assets/images/img.jpg',
);
final UserModel james = UserModel(
  id: 2,
  username: 'James',
  imageUrl: 'assets/images/img.jpg',
);
final UserModel john = UserModel(
  id: 3,
  username: 'John',
  imageUrl: 'assets/images/img.jpg',
);
final UserModel olivia = UserModel(
  id: 4,
  username: 'Olivia',
  imageUrl: 'assets/images/img.jpg',
);
final UserModel sam = UserModel(
  id: 5,
  username: 'Sam',
  imageUrl: 'assets/images/img.jpg',
);
final UserModel sophia = UserModel(
  id: 6,
  username: 'Sophia',
  imageUrl: 'assets/images/img.jpg',
);
final UserModel steven = UserModel(
  id: 7,
  username: 'Steven',
  imageUrl: 'assets/images/img.jpg',
);

// FAVORITE CONTACTS
List<UserModel> favorites = [sam, steven, olivia, john, greg];

//CHATS ON HOME SCREEN
List<Message> chats = [
  Message(
    sender: james,
    time: '5:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: olivia,
    time: '4:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: john,
    time: '3:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: sophia,
    time: '2:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: steven,
    time: '1:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: sam,
    time: '12:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: greg,
    time: '11:30 AM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: false,
    unread: false,
  ),
];

//MESSAGES IN CHAT SCREEN
List<Message> messages = [
  Message(
    sender: james,
    time: '5:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isLiked: true,
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '4:30 PM',
    text: 'Just walked my doge. She was super duper cute. The best pupper!!',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: james,
    time: '3:45 PM',
    text: 'How\'s the doggo?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: james,
    time: '3:15 PM',
    text: 'All the food',
    isLiked: true,
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '2:30 PM',
    text: 'Nice! What kind of food did you eat?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: james,
    time: '2:00 PM',
    text: 'I ate so much food today.',
    isLiked: false,
    unread: true,
  ),
];
