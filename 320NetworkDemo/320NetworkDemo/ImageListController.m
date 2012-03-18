//
//  ImageListController.m
//  320NetworkDemo
//
//  Created by he baochen on 12-3-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ImageListController.h"
#import "TTNetImageView.h"

@interface ImageListController ()

@end

@implementation ImageListController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc {
  [_imgURLArray release];
  [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
  
  _imgURLArray = [[NSArray arrayWithObjects:
                          @"http://attachments.cngba.com/attachments/month_1008/1008121612c5783c8ecbcd5519.jpg",
                          @"http://image215.poco.cn/mypoco/myphoto/20091106/16/27984696200911061622511271229455261_001.jpg",
                          @"http://www.sodoos.com/cms/uploads/allimg/100209/1-100209194510.jpg",
                          @"http://ps3.tgbus.com/UploadFiles/201003/20100322170940849.jpg",
                          @"http://bizhi.zhuoku.com/2010/10/15/yishu/yishu012.jpg",
                          @"http://www.sodoos.com/discuz/attachments/month_0910/09102011335feb8b1c282f5ee3.jpg",
                          @"http://bizhi.zhuoku.com/2010/10/15/yishu/yishu107.jpg",
                          @"http://pic.jj20.com/up/allimg/411/0z6111g310/110z61g310-0.jpg",
                          @"http://img1.qq.com/gamezone/pics/13806/13806620.jpg",
                          @"http://img.wokende.com/uploadworks/d/44/2785644201064145137472.jpg",
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
                          @"http://www.sodoos.com/cms/uploads/allimg/100224/8-100224215017.jpg",
                          @"http://img3.gamersky.com/upload-news/200806/20080605185702432.jpg",
                          nil] retain];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
  return [_imgURLArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    cell.textLabel.text = @"";
    TTNetImageView *imageView = [[TTNetImageView alloc] initWithFrame:CGRectMake(10, 2, 40, 40)];
    imageView.tag = 20;
    imageView.defaultImage = [UIImage imageNamed:@"defaultImage.png"];
    [cell.contentView addSubview:imageView];
    [imageView release];
  }
  
  
  TTNetImageView *imageView = (TTNetImageView*)[cell.contentView viewWithTag:20];
  imageView.urlPath = [_imgURLArray objectAtIndex:indexPath.row];
  cell.textLabel.text = [_imgURLArray objectAtIndex:indexPath.row];
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end
