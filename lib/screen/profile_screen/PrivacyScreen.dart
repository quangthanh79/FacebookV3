
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrivacyScreen extends StatelessWidget {
  PrivacyScreen(Key? key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            key: key,
            elevation: 2.0,
            centerTitle: false,
            backgroundColor: Colors.white,
            title: Text("Chính sách quyền riêng tư của facebook", style: TextStyle(color: Colors.black,),),
            leading: GestureDetector(
              child: Icon(Icons.arrow_back, color: Colors.black,),
              onTap: () {
                Navigator.pop(context);
              },
            )
        ),
        body: ListView(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          children: <Widget>[
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black54, fontSize: 20.0),
                children: <TextSpan>[
                  TextSpan(text: '\nChính sách quyền riêng tư\n\n', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0)),
                  TextSpan(text: '\n\nChính sách quyền riêng tư là gì và chính sách này điều chỉnh những gì?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                  TextSpan(text: '\n\nMeta muốn bạn nắm được loại thông tin chúng tôi thu thập, cũng như cách chúng tôi sử dụng và chia sẻ thông tin đó. Vì thế, bạn nên đọc Chính sách quyền riêng tư của chúng tôi. Như vậy, bạn sẽ sử dụng Sản phẩm của Meta theo cách phù hợp với mình.\n\nChính sách quyền riêng tư giải thích cách chúng tôi thu thập, sử dụng, chia sẻ, lưu giữ và chuyển thông tin. Chúng tôi còn cho biết những quyền bạn có. Từng mục trong Chính sách này đều cung cấp ví dụ hữu ích và sử dụng cách diễn đạt đơn giản hơn để các biện pháp của chúng tôi trở nên dễ hiểu. Ngoài ra, chúng tôi đã thêm liên kết đến các thông tin và nguồn lực để bạn có thể tìm hiểu thêm về những chủ đề liên quan đến quyền riêng tư mà bạn quan tâm.\n\nChúng tôi thấy rằng bạn cần phải biết cách kiểm soát quyền riêng tư của mình. Do đó, chúng tôi cũng sẽ chỉ cho bạn nơi bạn có thể quản lý thông tin trong phần cài đặt Sản phẩm của Meta mà bạn sử dụng. Bạn có thể  để định hình trải nghiệm của mình.\n\nHãy đọc toàn bộ chính sách ở bên dưới.\n\n'),
                  TextSpan(text: '\nChúng tôi thu thập những thông tin nào?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                  TextSpan(text: '\n\nThông tin về bạn mà chúng tôi thu thập và xử lý phụ thuộc vào cách bạn sử dụng Sản phẩm của chúng tôi. Ví dụ: nếu bạn bán nội thất trên Marketplace, chúng tôi sẽ thu thập thông tin khác với trường hợp bạn đăng một thước phim trên Instagram. Khi bạn sử dụng Sản phẩm, chúng tôi thu thập một số thông tin về bạn.\n\nSau đây là những thông tin chúng tôi thu thập:\n\n'),
                  TextSpan(text: '\n\nNếu bạn không cho phép chúng tôi thu thập một số thông tin thì sao?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0)),
                  TextSpan(text: '\n\nChúng tôi cần phải có một số thông tin để vận hành Sản phẩm. Các thông tin khác không bắt buộc, nhưng nếu thiếu thì chất lượng trải nghiệm của bạn có thể bị ảnh hưởng.\n\nĐể hạn chế sử dụng thông tin liên kết với người dùng cá nhân, trong một số trường hợp, chúng tôi loại bỏ thông tin nhận dạng hoặc tổng hợp thông tin. Chúng tôi cũng có thể ẩn danh thông tin này để bạn không bị lộ danh tính. Chúng tôi sử dụng thông tin trên theo cách giống với khi dùng thông tin của bạn như mô tả trong mục này.\n\nChúng tôi là thành viên trong số , cung cấp Sản phẩm của các công ty thuộc Meta.  bao gồm tất cả các Sản phẩm của Meta mà Chính sách này điều chỉnh, cùng với các sản phẩm khác như WhatsApp, Novi, v.v.\n\nChúng tôi cũng xử lý thông tin nhận được về bạn từ Các công ty khác của Meta, theo điều khoản và chính sách của các công ty đó, cũng như theo quy định của luật hiện hành. Trong một số trường hợp, Meta đóng vai trò là nhà cung cấp dịch vụ cho Các công ty khác của Meta. Chúng tôi hành động thay mặt họ, theo hướng dẫn và điều khoản của họ.\n\nChúng tôi cung cấp cho bạn nhiều công cụ để xem, quản lý, tải xuống và xóa thông tin như bên dưới. Bạn cũng có thể quản lý thông tin của mình bằng cách truy cập vào phần cài đặt của Sản phẩm bạn dùng. Ngoài ra, bạn có thể có các quyền riêng tư khác theo luật hiện hành.Bạn có thể tìm hiểu thêm về cách thực hiện quyền riêng tư trên ,  và trong . Nếu có thắc mắc về chính sách này, bạn có thể  theo địa chỉ nêu bên dưới. Ở một số quốc gia, bạn cũng có thể liên hệ với Nhân viên bảo vệ dữ liệu của Meta Platforms, Inc. và tùy theo khu vực pháp lý, bạn còn có thể liên hệ trực tiếp với Cơ quan bảo vệ dữ liệu ("DPA") tại địa phương.Chúng tôi lưu giữ thông tin trong khoảng thời gian cần thiết để cung cấp Sản phẩm, tuân thủ các nghĩa vụ pháp lý hay bảo vệ lợi ích của chúng tôi hoặc của người khác. Chúng tôi xác định khoảng thời gian cần lưu giữ thông tin tùy vào từng trường hợp. Sau đây là những yếu tố chúng tôi cân nhắc khi xác định:\n\nLiệu chúng tôi có cần thông tin đó để vận hành hoặc cung cấp Sản phẩm hay không. Ví dụ: chúng tôi cần lưu giữ một số thông tin nhằm duy trì tài khoản của bạn.\n\nTính năng mà chúng tôi sử dụng thông tin, cũng như cách hoạt động của tính năng đó. Ví dụ: tin nhắn gửi bằng chế độ tạm thời của Messenger được lưu giữ trong thời gian ngắn hơn tin nhắn thông thường. .\n\n'),
                ]
              ),
            )
          ],
        )
    );
  }
}