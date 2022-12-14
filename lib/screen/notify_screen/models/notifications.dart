
class MyNotification{
  String type;
  String object_id;
  String title;
  String notification_id;
  String created;
  String avatar;
  String group;
  String read;
  MyNotification({
    this.type = "",
    this.object_id = "",
    this.title = "",
    this.notification_id = "",
    this.created = "",
    this.avatar = "https://huongnghiep.hocmai.vn/wp-content/uploads/2022/02/1-58.png",
    this.group = "",
    this.read = ""
  });
}

class ListNotification{
  List<MyNotification> list = [];
  ListNotification(){
    fakeList();
  }
  void fakeList(){
    list.add(MyNotification(
        title: 'You have memories with Taliah Rossi and Mabel Quintero to look back on to dhdhjd djh djdh jdh dhj ddhj dhjd đhdhd djd dhddj dhjd hd dhdjhd jday.',
        created: '3 hours ago',
        read: "false"));
    list.add(MyNotification(
        title: 'Susan Preece changed his profile picture.',
        created: 'Yesterday at 11:22pm',
        read: " true"));
    list.add(MyNotification(
        title: 'David Beckham changed his profile picture.',
        created: 'Yesterday at 8:28pm',
        read: "false"));
    list.add(MyNotification(
        title: 'Macaulay Dolan\'s birthday was yesterday.',
        created: '10 hours ago',
        read: "true"));
    list.add(MyNotification(
        title: 'David Beckham changed his profile picture.',
        created: 'Yesterday at 8:28pm',
        read: "false"));
    list.add(MyNotification(
        title: 'David Beckham changed his profile picture.',
        created: 'Yesterday at 8:28pm',
        read: "false"));
    list.add(MyNotification(
        title: 'David Beckham changed his profile picture.',
        created: 'Yesterday at 8:28pm',
        read: "false"));
    list.add(MyNotification(
        title: 'David Beckham changed his profile picture.',
        created: 'Yesterday at 8:28pm',
        read: "false"));
    list.add(MyNotification(
        title: 'David Beckham changed his profile picture.',
        created: 'Yesterday at 8:28pm',
        read: "false"));
  }
}
