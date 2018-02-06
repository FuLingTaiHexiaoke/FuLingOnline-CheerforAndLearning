//
//  RemoteNotificationNote.h
//  FuLingOnline-CheerforAndLearning
//
//  Created by 肖科 on 17/3/10.
//  Copyright © 2017年 com.FuLing. All rights reserved.
//

#ifndef RemoteNotificationNote_h
#define RemoteNotificationNote_h

//==================================================//知识点======================================================
//http://www.cnblogs.com/MasterPeng/p/5909752.html


//==================================================//正确的APNs数据======================================================
{
    "aps" : {
        "alert" : "title",
        "message_json" :{"title":"有新的服务需求被发布","content":{"message_content":"#测推送测推送测推送测推送测送测推送测推送送测推送测推送送测推送测推送送测推送测推送送测推送测推送送测推送测推送推送测推送测推送测推送测推送测推送#【测推送】测推送","lvcontent_id":10010},"up":""},
        "sound" : "default"
    }
}


{
    "aps" : {
        "alert" : {
            "title" : "Your ",
            "body" : "Your message Here"
        },
        "mutable-content": "1",
        "message_json" :{"title":"有新的服务需求被发布","content":{"message_content":"#测推送#【测推送】测推送","lvcontent_id":10010},"up":""},
        "sound" : "default"
    }
}


{
    "aps" : {
        "alert" : {
            "title" : "Your 222222333 ",
            "body" : "Your Include this key when y Include this key when y 222222 Include this key when y message Here"
        },
        "mutable-content": "1",
        "message_json" :{"title":"有新的服务需求被发布","content":{"message_content":"#测推送#【测推送】测推送","lvcontent_id":10010},"up":""},
        "sound" : "default"
    }
}


{
    "aps" :  {
        "alert" : "This is some fancy message.",
        "badge" : 1,
        "from" : "大家好有新的服务需求被发布有新的服务需求被发布有新的服务需求被发布”,
        "imageAbsoluteString" : "http://upload.univs.cn/2012/0104/1325645511371.jpg",
        "mutable-content" : 1,
        "sound" : "default"
    }
}




#endif /* RemoteNotificationNote_h */
