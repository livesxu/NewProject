//
//  SubTestBtn.h
//  NewProject
//
//  Created by Livespro on 2016/12/20.
//  Copyright © 2016年 FZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SubTestDelegate <NSObject>

-(void)testPrintfSome;

@end

@interface SubTestBtn : UIButton

@property (nonatomic,assign) id <SubTestDelegate>delegate;

@end
