//
//  NewsCell.h
//  TodayExtensionSharingDefaults
//
//  Created by 周浩 on 14/11/21.
//  Copyright (c) 2014年 Lukas Petr. All rights reserved.
//

#import <UIKit/UIKit.h>

@class News;
@interface NewsCell : UICollectionViewCell

@property (nonatomic,strong) News *news;

@property (weak, nonatomic) IBOutlet UIImageView *iconView;


@end
