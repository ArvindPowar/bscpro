//
//  MsgChatVO.h
//  Chatapp
//
//  Created by arvind on 5/2/15.
//  Copyright (c) 2015 MobiWebCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MsgChatVO : NSObject
@property(nonatomic,retain) NSString *message_id,*user_id,*username,*receiver_id,*receiver,*message_time,*message,*subject,*fav_message,*attach_image,*attach_file,*matchup_id,*req_response;
@end
