//
//  ViewController.h
//  320NetworkDemo
//
//  Created by he baochen on 12-3-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
    NSMutableDictionary *_valueUIDict;
    CGFloat _labelPosY;
    NSTimer *_refreshTimer;
  UITableView *_tableView;
}

@end
