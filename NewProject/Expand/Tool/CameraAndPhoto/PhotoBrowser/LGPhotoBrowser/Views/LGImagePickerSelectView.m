//
//  LGImagePickerSelectView.m
//  LGPhotoBrowser
//
//  Created by ligang on 15/10/27.
//  Copyright (c) 2015年 L&G. All rights reserved.

#import "LGImagePickerSelectView.h"
#import "LGPhotoPickerCommon.h"

@implementation LGImagePickerSelectView

- (id)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
        self.backgroundColor = [UIColor clearColor];
        
        UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
        [bgView setBackgroundColor:[UIColor blackColor]];
        [bgView setAlpha:0.4];
        [self addSubview:bgView];
        
        self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.backBtn setFrame:CGRectMake(0, 20, 60, 50)];
        [self.backBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 20, 25, 24)];
        [self.backBtn setImage:GetImage(@"btn_back_imagePicker.png") forState:UIControlStateNormal];
        [self addSubview:self.backBtn];
        
        self.selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.selectBtn setFrame:CGRectMake(SCREEN_WIDTH - 68 -10, 20, 68, 24)];
//        [self.selectBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 25, 0)];
        self.selectBtn.titleLabel.font = [UIFont fontWithName:@"AvenirNext-DemiBold" size:16.0f];
        [self.selectBtn setTitle:@"使用照片" forState:UIControlStateNormal];
        [self.selectBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];//livesxu
//        [self.selectBtn setImage:GetImage(@"checkbox_pic_non2.png") forState:UIControlStateNormal];
//        [self.selectBtn setImage:GetImage(@"checkbox_pic2.png") forState:UIControlStateSelected];
//        [self addSubview:self.selectBtn];
    }
    return self;
}

- (void)addTarget:(id)target backAction:(SEL)backAction selectAction:(SEL)selectAction forControlEvents:(UIControlEvents)controlEvents {
    [self.backBtn addTarget:target action:backAction forControlEvents:controlEvents];
    [self.selectBtn addTarget:target action:selectAction forControlEvents:controlEvents];
}

@end
