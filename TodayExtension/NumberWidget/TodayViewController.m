//
//  TodayViewController.m
//  NumberWidget
//
//  Created by apple on 12/10/2014.
//  Copyright (c) 2014 Lukas Petr. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "NewsCell.h"
#import "News.h"

@interface TodayViewController () <NCWidgetProviding>
{
    int i;
    NSTimer *_myTimer;
}

- (IBAction)click:(UIButton *)sender;
- (IBAction)stop:(UIButton *)sender;
- (IBAction)Enter:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@property (strong, nonatomic) NSArray *newses;

@end

@implementation TodayViewController


//让隐藏的插件重新显示
- (void)showTodayExtension
{
    [[NCWidgetController widgetController] setHasContent:YES forWidgetWithBundleIdentifier:@"com.wangzz.app.extension"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(userDefaultsDidChange:)
                                                     name:NSUserDefaultsDidChangeNotification
                                                   object:nil];
    }
    return self;
}

- (NSArray *)newses
{
    if (!_newses) {
//       NSString *path = [[NSBundle mainBundle] pathForResource:@"newses.plist" ofType:nil];
//       self.newses = [[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:@"Root"];
        
        NSArray *imageArray=@[@"img_01.png",@"img_02.png",@"img_03.png",@"img_04.png",@"img_05.png"];
        self.newses=imageArray;
    }
    return _newses;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.preferredContentSize = CGSizeMake(320, 1000);
    [self updateNumberLabelText];
    
    i=0;
    
    // 注册cell
    [self.collectionView registerNib:[UINib nibWithNibName:@"NewsCell" bundle:nil] forCellWithReuseIdentifier:@"news"];
    
  //  [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];

    [self addTimer];
}

- (void)addTimer
{
   _myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(recycle) userInfo:nil repeats:YES];
}

- (void)recycle
{
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:i++ inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.newses.count*100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"news";
    NewsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
//    NSString *name=[self.newses[indexPath.item % self.newses.count] objectForKey:@"icon"];
//    cell.iconView.image = [UIImage imageNamed:name];

    cell.iconView.image=[UIImage imageNamed:self.newses[indexPath.item%5]];
    
    return cell;
}

- (void)openURLContainingAPP
{
     NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.TodayExtensionSharingDefaults"];
     [defaults setObject:@"abc" forKey:@"MyPage"];
     [defaults synchronize];

    
//    [self.extensionContext openURL:[NSURL URLWithString:@"bananar://"]
//                 completionHandler:^(BOOL success) {
//                     NSLog(@"asasa");
//                     
//                 }];

    
[self.extensionContext openURL:[NSURL URLWithString:@"apple://com.fengxing"]
             completionHandler:^(BOOL success) {
                 NSLog(@"asasa");
                
                }];
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encoutered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

- (void)userDefaultsDidChange:(NSNotification *)notification {
    [self updateNumberLabelText];
}

- (void)updateNumberLabelText {
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.TodayExtensionSharingDefaults"];
    NSInteger number = [defaults integerForKey:@"MyNumberKey"];
    self.numberLabel.text = [NSString stringWithFormat:@"%ld", (long)number];
}

- (IBAction)click:(UIButton *)sender {
  //  self.imageView.image=[UIImage imageNamed:@"img_02.png"];
//    NSString *name=[self.newses[1 % self.newses.count] objectForKey:@"icon"];
//    self.imageView.image=[UIImage imageNamed:name];

    
    self.imageView.image=[UIImage imageNamed:self.newses[i++%5]];
//    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:i++ inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];

}

- (IBAction)stop:(UIButton *)sender {
    
    [_myTimer invalidate];
}

- (IBAction)Enter:(UIButton *)sender
{
    [self openURLContainingAPP];
}

@end
