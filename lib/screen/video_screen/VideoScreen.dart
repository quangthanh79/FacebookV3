import 'package:flutter/material.dart';

// class VideoScreen extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(
//         child: Text("Longgg"),
//       ),
//     );
//   }
// }

class PageTitle extends StatelessWidget {
  final String title;
  PageTitle({this.title: ""});

  @override
  Widget build(BuildContext context) {
    return Text(
      this.title,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}

class VideoScreen extends StatefulWidget {
  VideoScreen({Key key: const Key("456")}) : super(key: key);

  _VideoScreen createState() => _VideoScreen();
}

class _VideoScreen extends State<VideoScreen> {
  bool hasNotification = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        preferredSize: Size.fromHeight(0),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: PageTitle(title: 'Videos'),
            backgroundColor: Colors.white,
            centerTitle: false,
            actions: <Widget>[
              Container(
                child: IconButton(
                  icon: Icon(Icons.settings),
                  color: Colors.black,
                  disabledColor: Colors.black,
                  splashColor: Theme.of(context).colorScheme.secondary,
                  onPressed: () {},
                ),
                decoration: BoxDecoration(
                  color: Theme
                      .of(context)
                      .colorScheme
                      .secondary,
                  shape: BoxShape.circle,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildListDelegate(_getVideos()),
          )
        ],
      ),
    );
  }

  List<Widget> _getVideos() {
    List<Widget> videos = [];
    videos.add(_getVideo(
        "assets/images/no_image.png",
        "Long",
        "40 minutes ago",
        "Đây là video",
        35,
        55
    ));
    videos.add(_getVideo(
        "assets/images/no_image.png",
        "Tiệp",
        "45 minutes ago",
        "Đây là video",
        15,
        77
    ));
    videos.add(_getVideo(
        "assets/images/no_image.png",
        "Phúc",
        "1 hours ago",
        "Đây là video",
        99,
        152
    ));
    videos.add(_getVideo(
        "assets/images/no_image.png",
        "Long",
        "6 minutes ago",
        "Đây là video",
        35,
        55
    ));
    videos.add(_getVideo(
        "assets/images/no_image.png",
        "Long",
        "40 minutes ago",
        "Đây là video",
        35,
        55
    ));
    videos.add(_getVideo(
        "assets/images/no_image.png",
        "Long",
        "40 minutes ago",
        "Đây là video",
        35,
        55
    ));
    videos.add(_getVideo(
        "assets/images/no_image.png",
        "Long",
        "40 minutes ago",
        "Đây là video",
        35,
        55
    ));
    return videos;
  }

  Widget _getVideo(String avtURL, String userName, String postTime, String postContent, int likeNumber, int commentNumber) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        avtURL,
                        width: 32,
                        height: 32,
                      ),
                      Column(
                        children: [Text(userName), Text(postTime)],
                      )
                    ],
                  ),
                  Image.asset(
                    'assets/images/menu_3_dots.png',
                    width: 24,
                    height: 24,
                  )
                ],
              ),

              Text(postContent),

              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/icon_like_fix.png',
                            width: 32,
                            height: 32,
                          ),
                          Text(likeNumber.toString())
                        ],
                      ),
                      Text('${commentNumber} comments')
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 16),
                    color: Colors.grey,
                    height: 0.3,
                    width: double.infinity,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/icon_like_black.png',
                            width: 20,
                            height: 20,
                          ),
                          const Text(' Like')
                        ],
                      ),
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/comment_icon.png',
                            width: 20,
                            height: 20,
                          ),
                          const Text(' Comment')
                        ],
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        Container(
          color: Colors.grey,
          height: 5,
          width: double.infinity,
        ),
      ],
    );
  }
}
