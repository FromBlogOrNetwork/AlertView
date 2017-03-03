//
//  VourcherAlertView.m
//  AlertView
//
//  Created by lwj on 16/12/27.
//  Copyright © 2016年 WenJin Li. All rights reserved.
//

#import "VourcherAlertView.h"
#define Kpicvorcherbg                         @"picvorcherbg"
#define kvorcherClosebtnPressed               @"vorcherClosebtnPressed"
#define kvorcherClosebtn                      @"vorcherClosebtn"
#define kchongzhiacer                         @"chongzhiacer"
#define kduihuanvoucher                       @"duihuanvoucher"
#define kbutton_rechange_click                @"button_rechange_click"
#define kbutton_rechange                      @"button_rechange"
#define kbutton_exchange_click                @"button_exchange_click"
#define kbutton_exchange                      @"button_exchange"
@interface VourcherAlertView(){
   
   
}
@property (strong,nonatomic)UIDynamicAnimator * animator;
@property (strong,nonatomic)UIImageView * alertview;
@property (strong,nonatomic)UIView * backgroundview;
@property (strong,nonatomic)UIImage * image;
@property (assign,nonatomic) int type;
@end

@implementation VourcherAlertView
-(void)click:(UITapGestureRecognizer *)sender{
    CGPoint tapLocation = [sender locationInView:self.backgroundview];
    CGRect alertFrame = self.alertview.frame;
    if (!CGRectContainsPoint(alertFrame, tapLocation)) {
        [self dismiss];
    }
}
-(void)clickButton:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(didClickButtonAtIndex:)]) {
        [self.delegate didClickButtonAtIndex:(button.tag -1)];
    }
    [self dismiss];
}
-(void)dismiss{
    [self.animator removeAllBehaviors];
    [UIView animateWithDuration:0.7 animations:^{
        self.alpha = 0.0;
        CGAffineTransform rotate = CGAffineTransformMakeRotation(0.9 * M_PI);
        CGAffineTransform scale = CGAffineTransformMakeScale(0.1, 0.1);
        self.alertview.transform = CGAffineTransformConcat(rotate, scale);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.alertview = nil;
    }];
}
- (void)setvourcherNumber:(NSInteger)voucherNumber{
    UILabel*label = (UILabel*) [_alertview viewWithTag:1003];
    NSString*str = [NSString stringWithFormat:@"尚有%li礼券可兑换",(long)voucherNumber];
    label.text = str;
}
-(void)setUpWithAlertViewSize:(CGSize)size{
   
    _backgroundview = [[UIView alloc] initWithFrame:[[UIApplication sharedApplication] keyWindow].frame];
    self.backgroundview.backgroundColor = [UIColor blackColor];
    self.backgroundview.alpha = 0.4;
    [self addSubview:self.backgroundview];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    [self.backgroundview addGestureRecognizer:tap];
    
    _alertview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    _alertview.userInteractionEnabled = YES;
    _alertview.image = _image;
    self.alertview.layer.cornerRadius = 0;
    UIView * keywindow = [[UIApplication sharedApplication] keyWindow];
    self.alertview.center = CGPointMake(CGRectGetMidX(keywindow.frame), -CGRectGetMidY(keywindow.frame));
    self.alertview.backgroundColor = [UIColor clearColor];
    self.alertview.clipsToBounds = YES;
    [self addSubview:self.alertview];
    //关闭按钮
    UIButton* closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage* btnImage = [UIImage imageNamed:kvorcherClosebtn];
    closeBtn.frame = CGRectMake(size.width-btnImage.size.width-7, 7, btnImage.size.width, btnImage.size.height);
    [closeBtn setImage:btnImage forState:UIControlStateNormal];
    [closeBtn setImage:[UIImage imageNamed:kvorcherClosebtnPressed] forState:UIControlStateHighlighted];
    [closeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [_alertview addSubview:closeBtn];
    UIImage* typeImage = nil;
    
    UIImage* btnTypeImage = nil;
    UIImage* btnTypeImagePressed = nil;
    if (_type == 1) {//type = 1 充值 type = 2 兑换
        typeImage = [UIImage imageNamed:kchongzhiacer];
        NSString* tipsString = @"抱歉,当前元宝余额不足\n请及时充值";
        btnTypeImage = [UIImage imageNamed:kbutton_rechange];
        btnTypeImagePressed = [UIImage imageNamed:kbutton_rechange_click];
        UILabel*noMoneylabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 55, size.width, 80)];
        noMoneylabel.text = tipsString;
        noMoneylabel.numberOfLines = 2;
        noMoneylabel.textAlignment = NSTextAlignmentCenter;
        noMoneylabel.font = [UIFont systemFontOfSize:16];
        [_alertview addSubview:noMoneylabel];
        
    }else if(_type == 2){
        typeImage = [UIImage imageNamed:kduihuanvoucher];
       //tipsString = @"元宝余额不足";
        btnTypeImage = [UIImage imageNamed:kbutton_exchange];
        btnTypeImagePressed = [UIImage imageNamed:kbutton_exchange_click];
        UILabel*label = [[UILabel alloc]initWithFrame:CGRectMake(0, 68, size.width, 25)];
        label.text = @"元宝不足";
        label.textColor = [UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13];
        [_alertview addSubview:label];
        
        UILabel* vourcherLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 90, size.width-10, 25)];
        vourcherLabel.textAlignment = NSTextAlignmentCenter;
        vourcherLabel.font = [UIFont systemFontOfSize:16];
        vourcherLabel.text = @"尚有1237384839礼券可兑换";
        vourcherLabel.adjustsFontSizeToFitWidth = YES;
        vourcherLabel.tag = 1003;
        [_alertview addSubview:vourcherLabel];
        
        
    }
    UIImageView*imagview= [[UIImageView alloc]initWithImage:typeImage];
    imagview.frame = CGRectMake((size.width-typeImage.size.width)/2, 10, typeImage.size.width, typeImage.size.height);
    [_alertview addSubview:imagview];
    
    UIButton*okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame = CGRectMake((size.width-btnTypeImage.size.width)/2, size.height-btnTypeImage.size.height-10, btnTypeImage.size.width, btnTypeImage.size.height);
    [okBtn setBackgroundImage:btnTypeImage forState:UIControlStateNormal];
     [okBtn setBackgroundImage:btnTypeImagePressed forState:UIControlStateHighlighted];
    okBtn.tag = _type;
    [okBtn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    [_alertview addSubview:okBtn];
    
}
- (void)show {
    UIView * keywindow = [[UIApplication sharedApplication] keyWindow];
    self.tag = 1992;
    [keywindow addSubview:self];
    _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
    UISnapBehavior * sanp = [[UISnapBehavior alloc] initWithItem:self.alertview snapToPoint:self.center];
    sanp.damping = 0.7;
    [self.animator addBehavior:sanp];
}
-(instancetype)initWithwithType:(int)type{ //type = 1 充值 type = 2 兑换
    if (self = [super initWithFrame:[[UIApplication sharedApplication] keyWindow].frame]) {
        _image = [UIImage imageNamed:Kpicvorcherbg];
        _type = type;
        if (_image) {
            [self setUpWithAlertViewSize:_image.size];
        }
       
    }
    return self;
}

@end
