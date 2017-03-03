//
//  VourcherAlertView.h
//  AlertView
//
//  Created by lwj on 16/12/27.
//  Copyright © 2016年 WenJin Li. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WJLALertviewDelegate<NSObject>
@optional
-(void)didClickButtonAtIndex:(NSUInteger)index;//index = 0 充值 index = 1 兑换
@end
@interface VourcherAlertView : UIView
@property (weak,nonatomic) id<WJLALertviewDelegate> delegate;

-(instancetype)initWithwithType:(int)type;//type = 1 充值 type = 2 兑换
- (void)show;
- (void)dismiss;
- (void)setvourcherNumber:(NSInteger)voucherNumber;//传入礼券数量
@end
