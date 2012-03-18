//
//  ViewController.m
//  320NetworkDemo
//
//  Created by he baochen on 12-3-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "Only320Network.h"
#import "TTURLRequestQueue-Debug.h"
#import "TTRequestLoader-Debug.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)dealloc {
  [_valueUIDict release];
  [_refreshTimer invalidate];
  [_refreshTimer release];
  [super dealloc];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  _refreshTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self
                                                 selector:@selector(refreshUI) userInfo:nil repeats:YES];
  _valueUIDict = [[NSMutableDictionary dictionaryWithCapacity:8] retain];
  
  
  
  self.view.backgroundColor = [UIColor blackColor];
  [self addObserver:self
         forKeyPath:@"loaderQueue.count"];
  [self addObserver:self
         forKeyPath:@"totalLoading"];
  [self addObserver:self
         forKeyPath:@"loaders.count"];
  
  _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _labelPosY, 320, 300) style:UITableViewStylePlain];
  _tableView.delegate = self;
  _tableView.dataSource = self;
  _tableView.backgroundColor = [UIColor blackColor];
  _tableView.rowHeight = 24;

  [self.view addSubview:_tableView];
  
  UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  button.frame = CGRectMake(50, 400, 100, 30);
  [button setTitle:@"开始" forState:UIControlStateNormal];
  [button addTarget:self action:@selector(sendRequestAction:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
  
  UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  button1.frame = CGRectMake(170, 400, 100, 30);
  [button1 setTitle:@"暂停" forState:UIControlStateNormal];
  [button1 addTarget:self action:@selector(suspendAction:) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button1];
  
  TTURLRequestQueue *queue = [TTURLRequestQueue mainQueue];
  queue.defaultTimeout = 1;
}

- (void)suspendAction:(id)sender {
  TTURLRequestQueue *queue = [TTURLRequestQueue mainQueue];
  queue.suspended = !queue.suspended;
  if (queue.suspended) {
    [sender setTitle:@"继续" forState:UIControlStateNormal];
  } else {
    [sender setTitle:@"暂停" forState:UIControlStateNormal];
  }
  
}

- (void)sendRequestAction:(id)sender {
  NSArray *imgURLArray = [NSArray arrayWithObjects:
                          @"http://attachments.cngba.com/attachments/month_1008/1008121612c5783c8ecbcd5519.jpg",
                          @"http://image215.poco.cn/mypoco/myphoto/20091106/16/27984696200911061622511271229455261_001.jpg",
                          @"http://http://www.sodoos.com/cms/uploads/allimg/100209/1-100209194510.jpg",
                          @"http://ps3.tgbus.com/UploadFiles/201003/20100322170940849.jpg",
                          @"http://bizhi.zhuoku.com/2010/10/15/yishu/yishu012.jpg",
                          @"http://www.sodoos.com/discuz/attachments/month_0910/09102011335feb8b1c282f5ee3.jpg",
                          @"http://bizhi.zhuoku.com/2010/10/15/yishu/yishu107.jpg",
                          @"http://pic.jj20.com/up/allimg/411/0z6111g310/110z61g310-0.jpg",
                          @"http://img1.qq.com/gamezone/pics/13806/13806620.jpg",
                          @"http://img.wokende.com/uploadworks/d/44/2785644201064145137472.jpg",
                          @"http://t2.baidu.com/it/u=1151216972,2030068136&fm=52&gp=0.jpg",
                          @"http://bizhi.zhuoku.com/2011/04/05/youxi/Youxi50.jpg",
                          @"http://imgk.zol.com.cn/nbbbs/3893/a3892567.jpg",
                          @"http://img.m580.cn/desktop/201108/110806120619948.jpg",
                          @"http://www.kkdesk.com/d/file/wallpaper/1920x1080/2010-01-12/d4074c40f10e1100366647e1a77733ae.jpg",
                          @"http://www.kkdesk.com/d/file/wallpaper/1920x1080/2010-01-12/91f6293e0dac17326f48be03699bb2f0.jpg",
                          @"http://ps3.tgbus.com/uploadfiles/201107/20110706185846876.jpg",
                          @"http://www.sodoos.com/cms/uploads/allimg/100208/8-10020R20250.jpg",
                          @"http://www.sodoos.com/cms/uploads/allimg/100224/8-100224215S3.jpg",
                          @"http://www.86ps.com/sc/RW/214/GirlsGeneration_003013.jpg",
                          @"http://bizhi.zhuoku.com/2010/05/18/chengshi/chengshi077.jpg",
                          @"http://pic.jj20.com/up/allimg/411/0G511155407/110G5155407-11.jpg",
                          @"http://www.zghtpc.com/bbs/attachments/month_1003/10033008083ea4ec4586e592eb.jpg",
                          @"http://i3.3conline.com/images/piclib/201011/11/batch/1/74221/1289443294111y2cc6l7j1r.jpg",
                          @"http://desktop.inlishui.com/DesktopFiles/%C6%FB%B3%B5/%A1%B6GT%C8%FC%B3%B55%A1%B7%B8%DF%C7%E5%BF%ED%C6%C1%B1%DA%D6%BD/Gran_turismo_5_04.jpg",
                          @"http://www.sodoos.com/cms/uploads/allimg/100224/8-100224215017.jpg",
                          @"http://img3.gamersky.com/upload-news/200806/20080605185702432.jpg",
                          nil];
  
  for (NSString *url in imgURLArray) {
    [self sendRequest:url];
  }
}

- (void) refreshUI {
  TTURLRequestQueue *queue = [TTURLRequestQueue mainQueue];
  UILabel *label = [_valueUIDict objectForKey:@"loaderQueue.count"];
  label.text = [NSString stringWithFormat:@"%d", [queue.loaderQueue count]];
  
  label = [_valueUIDict objectForKey:@"loaders.count"];
  label.text = [NSString stringWithFormat:@"%d", [queue.loaders count]];
  
  label = [_valueUIDict objectForKey:@"totalLoading"];
  label.text = [NSString stringWithFormat:@"%d", queue.totalLoading];
  
  [_tableView reloadData];
}

- (void) sendRequest:(NSString*)urlPath {
  TTURLRequest *request = [TTURLRequest request];
  request.urlPath = urlPath;
  request.cachePolicy = TTURLRequestCachePolicyNoCache;
  [request send];
}

- (void) addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath {
  //    TTURLRequestQueue *queue = [TTURLRequestQueue mainQueue];
  //    [queue addObserver:observer forKeyPath:keyPath];
  [self addKeyLabelWithY:_labelPosY text:keyPath];
  [self addValueLabelWithY:_labelPosY key:keyPath];
  _labelPosY += 20;
}

- (void) addKeyLabelWithY:(CGFloat)y text:(NSString*)text {
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, y, 200, 20)];
  label.text = [NSString stringWithFormat:@"%@: ", text];
  label.textColor = [UIColor whiteColor];
  label.backgroundColor = [UIColor blackColor];
  [self.view addSubview:label];
  [label release];
}

- (void) addValueLabelWithY:(CGFloat)y key:(NSString*)key {
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(210, y, 100, 20)];
  label.textColor = [UIColor whiteColor];
  label.backgroundColor = [UIColor blackColor];
  [self.view addSubview:label];
  [_valueUIDict setValue:label forKey:key];
  [label release];
}

- (void)viewDidUnload
{
  [super viewDidUnload];
  // Release any retained subviews of the main view.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 24;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  TTURLRequestQueue *queue = [TTURLRequestQueue mainQueue];
  return [queue.loaders count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.backgroundColor = [UIColor blackColor];
  }
  TTURLRequestQueue *queue = [TTURLRequestQueue mainQueue];
  TTRequestLoader *loader  = nil;
  int row = indexPath.row;
  int runningLoaderCount = [queue.runningLoaderQueue count];
  if (row < runningLoaderCount) {
    loader = [queue.runningLoaderQueue objectAtIndex:row];
  } else {
    loader = [queue.loaderQueue objectAtIndex:row - runningLoaderCount];
  } 
  TTURLRequest *anyRequest = [loader.requests objectAtIndex:0];
  int percent = 0;
  if (anyRequest.totalContentLength!=0) {
    percent = 100 * anyRequest.totalBytesDownloaded / (anyRequest.totalContentLength);
  }
  
  cell.textLabel.text = [NSString stringWithFormat:@"ld:%@-req:%d-re:%d-%d%%",[loader.cacheKey substringFromIndex:28], [loader.requests count], loader.retriesLeft, percent] ;
  return cell;
}

@end
