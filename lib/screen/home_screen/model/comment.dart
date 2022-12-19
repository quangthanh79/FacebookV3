// ignore_for_file: public_member_api_docs, sort_constructors_first
class Comment {
  final String? user_id;
  final String? avatarUrl;
  final String userName;
  final String content;
  final String time;
  Comment({
    this.user_id,
    this.avatarUrl,
    required this.userName,
    this.content = '',
    required this.time,
  });

  static Comment get fakeData => Comment(
      userName: 'SonNN',
      content:
          'Haha Hihi Huffffffffffffffffffffffffffffffffhhi Huffffffffffffffffffffffffffffffffhhi Huffffffffffffffffffffffffffffffffhhi Huffffffffffffffffffffffffffffffffhhi Huffffffffffffffffffffffffffffffffhhi Huffffffffffffffffffffffffffffffffhhi Huffffffffffffffffffffffffffffffffhhi Huffffffffffffffffffffffffffffffffhhi Huffffffffffffffffffffffffffffffffhhi Huffffffffffffffffffffffffffffffffhhi Huffffffffffffffffffffffffffffffffhhi Huffffffffffffffffffffffffffffffffhu',
      time: '10 minutes ago');

  static List<Comment> fakeList = [
    fakeData,
    fakeData,
    fakeData,
    fakeData,
    fakeData,
    fakeData,
    fakeData,
    fakeData,
    fakeData,
    fakeData,
    fakeData,
    fakeData,
    fakeData,
    fakeData,
    fakeData,
    fakeData
  ];
}
