//
//  NewsCell.m
//  TodayExtensionSharingDefaults
//
//  Created by 周浩 on 14/11/21.
//  Copyright (c) 2014年 Lukas Petr. All rights reserved.
//

#import "NewsCell.h"
#import "News.h"

@implementation NewsCell

- (void)setNews:(News *)news
{
    _news=news;
    self.iconView.image = [UIImage imageNamed:news.icon];
}

@end
