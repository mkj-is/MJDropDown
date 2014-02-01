
#import "MJDropDown.h"

@interface MJDropDown()

@property BOOL isOpened;
@property NSArray *items;

@end

@implementation MJDropDown

@synthesize delegate;
@synthesize buttons;
@synthesize selectedButtonIndex;
@synthesize animationTime;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.buttons = @[];
        self.openedBackgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.8];
        self.closedBackgroundColor = [UIColor lightGrayColor];
        self.padding = DROPDOWN_DEFAULT_PADDING;
        self.animationTime = DROPDOWN_DEFAULT_ANIMATION_TIME;
    }
    return self;
    
}

- (id)initWithButtons:(NSArray *)buttonsArray
{
    self = [super init];
    if (self)
    {
        self.buttons = buttonsArray;
        self.openedBackgroundColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:0.8];
        self.closedBackgroundColor = [UIColor lightGrayColor];
        self.padding = DROPDOWN_DEFAULT_PADDING;
        self.animationTime = DROPDOWN_DEFAULT_ANIMATION_TIME;
    }
    return self;
}

#pragma mark - User interface

- (void)reloadUserInterface
{
    size = CGSizeMake(self.frame.size.width, self.frame.size.height);
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    for (UIButton *button in buttons) {
        button.frame = CGRectMake(0.0, 0.0, size.width, size.height);
        [self addSubview:button];
    }
    [self shut];
}

- (void)shut
{
    [delegate dropDownShut:self];
    isOpen = NO;
    [UIView animateWithDuration:animationTime delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void){
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
        self.backgroundColor = self.closedBackgroundColor;
    } completion:nil];
    for (UIButton *button in buttons) {
        if (button.tag == selectedButtonIndex) {
            [UIView animateWithDuration:animationTime delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void){
                button.alpha = 1.0;
                button.frame = CGRectMake(padding, padding, size.width - 2.0 * padding, size.height - 2.0 * padding);
            } completion:nil];
        }
        else
        {
            [UIView animateWithDuration:animationTime delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void){
                button.alpha = 0.0;
                button.frame = CGRectMake(padding, padding, size.width - 2.0 * padding, size.height - 2.0 * padding);
            } completion:nil];
        }
    }
}

- (void)open
{
    [delegate dropDownOpened:self];
    isOpen = YES;
    [UIView animateWithDuration:animationTime delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void){
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height * buttons.count);
        self.backgroundColor = self.openedBackgroundColor;
    } completion:nil];
    NSUInteger __block i = 0;
    for (UIButton *button in buttons)
    {
        if (button.tag == selectedButtonIndex) {
            [UIView animateWithDuration:animationTime delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void){
                button.alpha = 1.0;
                button.frame = CGRectMake(padding, padding, size.width - 2.0 * padding, size.height - 2.0 * padding);
            } completion:nil];
        } else {
            [UIView animateWithDuration:animationTime delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^(void){
                button.alpha = 1.0;
                button.frame = CGRectMake(padding, (i++ + 1) * size.height + padding, size.width - 2.0 * padding, size.height - 2.0 * padding);
            } completion:nil];
        }
    }
}

#pragma mark - Getters/Setters

- (void)setButtons:(NSArray *)buttonsArray
{
    buttons = buttonsArray;
    NSUInteger i = 0;
    for (UIButton *button in buttons) {
        button.tag = i++;
        [button addTarget:self action:@selector(selectedButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self reloadUserInterface];
}

- (void)setSelectedButtonIndex:(NSUInteger)index
{
    if(index < buttons.count)
    {
        selectedButtonIndex = index;
    }
    else
    {
        selectedButtonIndex = 0;
    }
    [self shut];
}

- (NSUInteger)selectedButtonIndex
{
    return selectedButtonIndex;
}

- (CGFloat)padding
{
    return padding;
}

- (void)setPadding:(CGFloat)p
{
    padding = p;
    [self reloadUserInterface];
}

#pragma mark - Actions

- (IBAction)selectedButton:(UIButton *)sender
{
    if(isOpen)
    {
        self.selectedButtonIndex = sender.tag;
        [self sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [self open];
    }
    
}

@end
