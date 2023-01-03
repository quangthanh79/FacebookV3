
import 'package:facebook_auth/data/models/chat_detail.dart';
import 'package:facebook_auth/icon/person_icons.dart';
import 'package:facebook_auth/screen/chat_screen/message_item/message_partner_item.dart';
import 'package:facebook_auth/utils/app_theme.dart';
import 'package:facebook_auth/utils/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum ItemType{BOTTOM,MIDDLE,SINGLE,TOP}
class MessagePartnerItemTypeImpl extends MessagePartnerItem{
  final MessageDetail messageDetail;
  final ItemType itemType;
  MessagePartnerItemTypeImpl({
    required this.messageDetail,
    required this.itemType,
  });

  @override
  Widget getContent() {
    switch(this.itemType){
      case ItemType.BOTTOM:
        return Padding(
            padding: EdgeInsets.only(bottom: 20),
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: getImage(
                    uri: this.messageDetail.sender?.avatar ?? 'assets/images/default_avatar_image.jpg',
                    defaultUri: 'assets/images/default_avatar_image.jpg',
                    width: 30,
                    height: 30,
                  ),
                ),
                SizedBox(width: 5,),
                Flexible(
                  child: Container(
                    child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.grey200,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15.0),
                              topLeft: Radius.circular(5.0),
                              bottomRight: Radius.circular(15.0),
                              bottomLeft: Radius.circular(15.0)
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                          child: Text(
                            messageDetail.message!,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 16
                            ),
                          ),
                        )
                    ),
                  ),
                ),
                SizedBox(width: 50),
              ],
            )
        );
      case ItemType.MIDDLE:
        return Padding(
            padding: EdgeInsets.only(bottom:5),
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 35),
                Flexible(
                  child: Container(
                      decoration: BoxDecoration(
                        color: AppTheme.grey200,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12.0),
                            topLeft: Radius.circular(4.0),
                            bottomRight: Radius.circular(12.0),
                            bottomLeft: Radius.circular(4.0)
                        ),
                      ),
                      child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12,horizontal: 10),
                          child: Text(
                            messageDetail.message!,
                            maxLines: null,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 16
                            ),
                          )
                      )
                  ),
                ),
                SizedBox(width: 50),
              ],
            )
        );
      case ItemType.SINGLE:
        return Padding(
            padding: EdgeInsets.only(bottom: 20),
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: getImage(
                    uri: this.messageDetail.sender?.avatar ?? 'assets/images/default_avatar_image.jpg',
                    defaultUri: 'assets/images/default_avatar_image.jpg',
                    width: 30,
                    height: 30,
                  ),
                ),
                SizedBox(width: 5,),
                Flexible(
                  child: Container(
                    child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.grey200,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15.0),
                              topLeft: Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0),
                              bottomLeft: Radius.circular(15.0)
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                          child: Text(
                            messageDetail.message!,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 16
                            ),
                          ),
                        )
                    ),
                  ),
                ),
                SizedBox(width: 50),
              ],
            )
        );
      case ItemType.TOP:
        return Padding(
            padding: EdgeInsets.only(bottom: 0),
            child:
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 35),
                Flexible(
                  child: Container(
                    child: Container(
                        decoration: BoxDecoration(
                          color: AppTheme.grey200,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15.0),
                              topLeft: Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0),
                              bottomLeft: Radius.circular(5.0)
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                          child: Text(
                            messageDetail.message!,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 16
                            ),
                          ),
                        )
                    ),
                  ),
                ),
                SizedBox(width: 50),
              ],
            )
        );
    }
  }

}