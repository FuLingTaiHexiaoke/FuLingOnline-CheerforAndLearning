////
////  LTHomeAsyncSocket.h
////  LTLeyoyoWH
////
////  Created by PsylifeMacBook on 15/5/13.
////  Copyright (c) 2015年 LakeTony. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
//#import <sys/socket.h>
//#import <netinet/in.h>
//#import <arpa/inet.h>
//#import <unistd.h>
//
//
//#import "AsyncSocket.h"
//#import "LTViewLoginStudent.h"
//#import "config.h"
//
//#define DEFINE_SHARED_INSTANCE_USING_BLOCK(block) \
//static dispatch_once_t onceToken = 0; \
//__strong static id sharedInstance = nil; \
//dispatch_once(&onceToken, ^{ \
//sharedInstance = block(); \
//}); \
//return sharedInstance; \
//
//#define ScoketFormat @"WH\t&Stu\t&%@\t&END\n"
//
//#define NewScoketFormat @"FD&STU&%@&END"
////#define NewScoketFormat  [NSString stringWithFormat:@"%@%@%@%@%@%@%@",_SOCKETStartChar_,_SOCKETSeperator1_,@"STU",_SOCKETSeperator1_,@"%@",_SOCKETSeperator1_,_SOCKETEndChar_];
//
//enum{
//    SocketOfflineByServer,// 服务器掉线，默认为0
//    SocketOfflineByUser,  // 用户主动cut
//};
//
//@protocol LTNetDelegate <NSObject>
//
//-(void)didRead:(NSString *)netString;
//
//@end
//
//@interface LTHomeAsyncSocket : NSObject<AsyncSocketDelegate>
//
//@property (nonatomic, strong) AsyncSocket    *socket;       // socket
//@property (nonatomic, copy  ) NSString       *socketHost;   // socket的Host
//@property (nonatomic, assign) UInt16         socketPort;    // socket的prot
//
//
//@property (nonatomic, retain) NSTimer        *connectTimer; // 计时器
//
//@property (nonatomic,strong) id<LTNetDelegate> delegate;
//
//@property (nonatomic,weak)LTViewLoginStudent*  loginDelegate;
//
//+ (LTHomeAsyncSocket *)sharedInstance;
//
//
//-(void)socketConnectHost;// socket连接
//
//-(void)cutOffSocket; // 断开socket连接
//
//+(void)sendString:(NSString *)str;
//-(void)sendString:(NSString *)str;
//
//-(void)socketSendString:(NSString *)str;
//
//
//-(BOOL)isLinking;
//
//@end
