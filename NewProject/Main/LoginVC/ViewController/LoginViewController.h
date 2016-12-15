//
//  LoginViewController.h
//  NewProject
//
//  Created by Livespro on 2016/12/6.
//  Copyright © 2016年 FZ. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^LoginDirection)(NSDictionary *followDic);//@{@"follow":  }

@interface LoginViewController : BaseViewController


@property (nonatomic,copy) LoginDirection loginDirection;


@end
