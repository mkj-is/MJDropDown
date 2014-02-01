
#define DROPDOWN_DEFAULT_PADDING 0.0
#define DROPDOWN_DEFAULT_ANIMATION_TIME 0.15

#import <UIKit/UIKit.h>

@protocol MJDropDownDelegate <NSObject>

-(void)dropDownShut:(id)dropDown;
-(void)dropDownOpened:(id)dropDown;

@end

@interface MJDropDown : UIControl
{
    NSArray *buttons;
    NSUInteger selectedButtonIndex;
    BOOL isOpen;
    CGSize size;
    CGFloat padding;
    double animationTime;
}

@property (weak) id<MJDropDownDelegate> delegate;
@property (nonatomic, strong) NSArray *buttons;
@property (atomic) NSUInteger selectedButtonIndex;
@property (atomic) CGFloat padding;
@property (atomic) double animationTime;

@property UIColor *openedBackgroundColor;
@property UIColor *closedBackgroundColor;

- (void)shut;
- (void)open;

@end
