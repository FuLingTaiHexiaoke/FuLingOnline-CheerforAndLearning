////
////  LTHomeAsyncSocket.m
////  LTLeyoyoWH
////
////  Created by PsylifeMacBook on 15/5/13.
////  Copyright (c) 2015年 LakeTony. All rights reserved.
////
//
//#import "LTHomeAsyncSocket.h"
//#import "config.h"
//#import "AFNetworking.h"
//#import "PsyCommonMacro.h"
//
//@interface LTHomeAsyncSocket ()<UIAlertViewDelegate>
//{
//    BOOL linking;
//    NSDate*  socketHeartBeatLastRecord;
//}
//@end
//
//@implementation LTHomeAsyncSocket
//
//
//+(LTHomeAsyncSocket *) sharedInstance
//{
//    
//    static LTHomeAsyncSocket *sharedInstace = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        
//        sharedInstace = [[self alloc] init];
//    });
//    
//    return sharedInstace;
//}
//#pragma mark 1. socket 连接
//// socket连接
//-(void)socketConnectHost{
//    
//    if ([[AFNetworkReachabilityManager sharedManager]isReachable]) {
//        self.socket    = [[AsyncSocket alloc] initWithDelegate:self];
//        
//        NSError *error = nil;
//        
//        if (linking == NO) {
//            [self.socket connectToHost:self.socketHost onPort:self.socketPort withTimeout:3 error:&error];
//        }
//        
//        if (error) {
//            NSLog(@"%@",[error localizedDescription]);
//        }else{
//            linking  = YES;
//        }
//    }
//}
//
//#pragma mark  - 2. socket 断开连接与重连
//
//#pragma mark  连接成功回调
//-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString  *)host port:(UInt16)port
//{
//    NSLog(@"socket连接成功");
//    // 每隔30s像服务器发送心跳包
//    // self.connectTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(longConnectToSocket) userInfo:nil repeats:YES];// 在longConnectToSocket方法中进行长连接需要向服务器发送的讯息
//    //    [self.connectTimer fire];
//    //注册一个读取包。
//    NSData   *dataStream  = [@"\f\n\rEND" dataUsingEncoding:NSUTF8StringEncoding];
//    [sock readDataToData:dataStream withTimeout:-1 tag:0];
//    
//    if(![[[NSUserDefaults standardUserDefaults]objectForKey:@"scanText_login"]isEqualToString:@""]&&[[NSUserDefaults standardUserDefaults]objectForKey:@"scanText_login"]!=nil){
//        //        NSLog([[NSUserDefaults standardUserDefaults]objectForKey:@"scanText_login"]);
//        [self socketSendString: [[NSUserDefaults standardUserDefaults]objectForKey:@"scanText_login"]];
//        socketHeartBeatLastRecord=[NSDate date];
//        [self performSelector:@selector(detectSocketConnecting) withObject:nil afterDelay:10];
//    }
//
//    
//    
//}
//-(void)detectSocketConnecting{
//    NSTimeInterval socketHeartBeatInterval=[[NSDate date] timeIntervalSinceDate:socketHeartBeatLastRecord];
//    if (socketHeartBeatInterval>20) {
//        PsyLog(@"socketHeartBeatInterval>20  [self socketConnectHost];");
//        [self cutOffSocket];
//        
//        self.socket.userData = SocketOfflineByServer;
//        [self socketConnectHost];
//    }
//    [self performSelector:@selector(detectSocketConnecting) withObject:nil afterDelay:10];
//}
//// 切断socket
//-(void)cutOffSocket{
//    
//    linking  = NO;
//    self.socket.userData = SocketOfflineByUser;// 声明是由用户主动切断
//    [self.connectTimer invalidate];
//    
//    [self.socket disconnect];
//}
//-(void)onSocketDidDisconnect:(AsyncSocket *)sock
//{
//    NSLog(@"sorry the connect is failure %ld",sock.userData);
//    linking  = NO;
//    if (sock.userData == SocketOfflineByServer) {
//        // 服务器掉线，重连
//        [self socketConnectHost];
//    }
//    else if (sock.userData == SocketOfflineByUser) {
//        // 如果由用户断开，不进行重连
//        return;
//    }
//    
//}
//
//#pragma mark - 3. socket 发送与接收数据
//
//// 心跳连接
//-(void)longConnectToSocket{
//    // 根据服务器要求发送固定格式的数据，假设为指令@"longConnect"，但是一般不会是这么简单的指令
//    //    NSString *longConnect = @"heart_connect\n";
//    NSString *longConnect = @"FD&CTR&h&1&END";
//    NSData   *dataStream  = [longConnect dataUsingEncoding:NSUTF8StringEncoding];
//    [self.socket writeData:dataStream withTimeout:1 tag:1];
//}
//
//#pragma mark 接受到了数据
//
//-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
//{
//    //    NSLog(@"socket:%p didReadData:withTag:%ld", sock, tag);
//    NSString *httpResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"HTTP Response:\n%@", httpResponse);
//    //再此，我们对httpResponse进行解析。
//    NSArray<NSString*>*  responseArray=[httpResponse componentsSeparatedByString:@"\f\r\f&"];
//    //1)FD&CTR&tichu&1&END
//    if ([responseArray[2] isEqualToString:@"tichu"]) {
//        if (self.delegate!=nil &&  [self.delegate respondsToSelector:@selector(didRead:)]) {
//            [self.delegate didRead:@"tichu"];
//            //            [self.delegate didRead:@"tichu"];
//        }
//    }
//    //2)FD&CTR&login&ok&json数据&END
//    else if([responseArray[2] isEqualToString:@"login"]){
//        if ([self.loginDelegate  isKindOfClass:NSClassFromString(@"LTViewLoginStudent")] && self.loginDelegate!=nil) {
//            if (responseArray.count==6  &&  [responseArray[3] isEqualToString: @"ok"] &&  responseArray[4].length>1) {
//                [self.loginDelegate didRead:responseArray[4]];
//            }
//            else{
//                UIAlertView* alertView=[[UIAlertView alloc]initWithTitle:@"注意" message:@"服务器没有匹配的登录者信息，请核对二维码登录信息是否正确"  delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
//                 alertView.delegate=self;
//                [alertView show];
//            }
//            
//        }
//    }
//    //2心跳包)FD&CTR&h&1&END
//    else if ([responseArray[2] isEqualToString:@"h"]){
//        //发送心跳包FD&STU&h&1&END
//        [self socketSendString:@"h&1"];
//        socketHeartBeatLastRecord=[NSDate date];
//        //        if (self.delegate!=nil &&  [self.delegate respondsToSelector:@selector(didRead:)]) {
//        //            [self.delegate didRead:@"tichu"];
//        //        }
//        
//    }
//    //注册一个读取包。防止socket缓存无限增长。
//    NSData   *dataStream  = [@"\f\n\rEND" dataUsingEncoding:NSUTF8StringEncoding];
//    [sock readDataToData:dataStream withTimeout:-1 tag:0];
//    
//}
//-(void)sendString:(NSString *)str
//{
//    //    NSString *dabaoString = [NSString stringWithFormat:ScoketFormat,[str stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
//    //    NSData   *dataStream  = [dabaoString dataUsingEncoding:NSUTF8StringEncoding];
//    //    [self.socket writeData:dataStream withTimeout:1 tag:1];
//    //    NSLog(@"send over :%@",str);
//}
//
//
////socket各个分割符号
////#define _SOCKETStartChar_    @"\f\rFD"
////#define _SOCKETEndChar_      @"\f\n\rEND"
////#define _SOCKETSeperator1_    @"\f\r\f&"
////#define _SOCKETSeperator2_   @"\f\n\f#"
////重新定义一个发送接口，因为以前的接口使用太多，重新开辟一个。
//-(void)socketSendString:(NSString *)str
//{
//    if([self isLinking]){
//        NSString *dabaoString1 = [NSString stringWithFormat:NewScoketFormat,str];
//        //以前的分割方式
//        dabaoString1=[dabaoString1 stringByReplacingOccurrencesOfString:@"&" withString:_SOCKETSeperator1_];
//        dabaoString1=[dabaoString1 stringByReplacingOccurrencesOfString:@"#" withString:_SOCKETSeperator2_];
//        dabaoString1=[dabaoString1 stringByReplacingOccurrencesOfString:@"FD" withString:_SOCKETStartChar_];
//        dabaoString1=[dabaoString1 stringByReplacingOccurrencesOfString:@"END" withString:_SOCKETEndChar_];
//        NSString*  dabaoString=dabaoString1;
//        NSData   *dataStream  = [dabaoString dataUsingEncoding:NSUTF8StringEncoding];
//        [self.socket writeData:dataStream withTimeout:1 tag:1];
//        //        NSLog(@"send over :%@",dabaoString);
//        
//    }
//}
//
//- (void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag{
//    
//}
//
//+(void)sendString:(NSString *)str
//{
//    [[[self class]sharedInstance]sendString:str];
//}
//
//-(BOOL)isLinking
//{
//    return linking;
//}
//
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (buttonIndex==0) {
//        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"scanText_login"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
//}
//@end
