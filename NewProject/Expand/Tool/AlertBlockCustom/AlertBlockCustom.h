
//
#import <UIKit/UIKit.h>
#define DEFAULT_LINE_SPACING        (int)0
#define DEFAULT_PARAGRAPH_SPACING   (int)3

typedef NS_ENUM(NSInteger, AlertStyle) {
    AlertStyleDefault = 0,
    AlertStyleSecureTextInput,
    AlertStylePlainTextInput,
    AlertStyleLoginAndPasswordInput,
    AlertStyleCustom
};
@class AlertBlockCustom;

@interface AlertBlockCustom : UIView {
    UITextView *_messageLabel;
    UILabel *_titleLabel;
}
@property (nonatomic, retain) id object;

// alertView
@property (nonatomic, strong, readonly) UIToolbar *alertView;

//title font
@property (nonatomic, strong) UIFont *titleFont;

//title Color
@property (nonatomic, strong) UIColor *titleColor;

// 内容文字大小
@property (nonatomic, strong) UIFont *messageFont;

//message Color
@property (nonatomic, strong) UIColor *messageColor;

//cancel Button Title Color
@property (nonatomic,strong) UIColor *cancelTitleColor;

//other Button Title Color
@property (nonatomic,strong) UIColor *otherTitleColor;

// 设置message的对齐方式
@property (nonatomic, assign) NSTextAlignment contentAlignment;

// Alert TextInput LoginInput
@property (nonatomic, strong) UITextField *textField;

// Alert PasswordInput
@property (nonatomic, strong) UITextField *passwordTextField;

@property (nonatomic, strong) UIView *customView;

@property (nonatomic, assign) CGFloat customHeight;

@property (nonatomic, assign) CGFloat lineSpacing;        // DEFAULT_LINE_SPACING
@property (nonatomic, assign) CGFloat paragraphSpacing;   // DEFAULT_PARAGRAPH_SPACING
@property (nonatomic, assign) AlertStyle alertStyle;   // DEFAULT_PARAGRAPH_SPACING

#pragma mark - --block
typedef void (^CancelAlertBlock)(AlertBlockCustom *alertView) ;
typedef void (^ClicksAlertBlock)(AlertBlockCustom *alertView, NSInteger buttonIndex);

@property (nonatomic, copy, readonly) ClicksAlertBlock clickBlock;

@property (nonatomic,assign) BOOL otherClickCanDismiss;//点击其他按钮alert是否消失

- (void)setClickBlock:(ClicksAlertBlock)clickBlock;

#pragma mark - --init
/**
 *  创建alertView
 *
 *  @param title             提示标题
 *  @param message           提示详情
 *  @param cancelButtonTitle 取消按钮名称
 *  @param otherButtonTitles 其他按钮
 *
 *  @return Alert
 */
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle clickBlockAction:(ClicksAlertBlock)clickBlock otherButtonTitles:(NSString *)otherButtonTitles, ...NS_REQUIRES_NIL_TERMINATION;

/**
 *  显示alertView
 */
- (void)show;

/**
 *  移除alertView
 */
- (void)dismiss;

@end
