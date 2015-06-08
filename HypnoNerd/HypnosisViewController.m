//
//  HypnosisViewController.m
//  HypnoNerd
//
//  Created by Sander Peerna on 6/2/15.
//  Copyright (c) 2015 Sander Peerna. All rights reserved.
//

#import "HypnosisViewController.h"
#import "HypnosisView.h"

@interface HypnosisViewController () <UITextFieldDelegate>

@end

@implementation HypnosisViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollView.frame = self.view.frame;
    
    CGRect frame = self.scrollView.frame;
    HypnosisView *hypnosisView = [[HypnosisView alloc] initWithFrame:frame];
    [self.scrollView addSubview:hypnosisView];
    
    HypnosisView *anotherHypnosisView = [[HypnosisView alloc] initWithFrame:CGRectMake(frame.origin.x+frame.size.width, 0, frame.size.width, frame.size.height)];
    [self.scrollView addSubview:anotherHypnosisView];
    
    CGRect textFieldRect = CGRectMake(40, 70, 240, 30);
    UITextField *textField = [[UITextField alloc] initWithFrame: textFieldRect];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.enablesReturnKeyAutomatically = YES;
    textField.placeholder = @"Hypnotize me";
    textField.returnKeyType = UIReturnKeyDone;
    textField.delegate = self;
    [self.scrollView addSubview:textField];
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width*2, self.scrollView.frame.size.height);
    self.scrollView.pagingEnabled = YES;
}

- (void)drawHypnoticMessage:(NSString *)message
{
    for (int i = 0; i < 20; i++)
    {
        UILabel *messageLabel = [[UILabel alloc] init];
        
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.text = message;
        [messageLabel sizeToFit];
        
        CGRect bounds = self.scrollView.bounds;
        
        int width = (int)(bounds.size.width - messageLabel.bounds.size.width);
        int x = arc4random() % width;
        
        int height = (int)(bounds.size.height - messageLabel.bounds.size.height);
        int y = arc4random() % height;
        
        CGRect frame = messageLabel.frame;
        frame.origin = CGPointMake(x, y);
        messageLabel.frame = frame;
        
        [self.scrollView addSubview:messageLabel];
        
        UIInterpolatingMotionEffect *motionEffect;
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.x"
                                                                       type:UIInterpolatingMotionEffectTypeTiltAlongHorizontalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [messageLabel addMotionEffect:motionEffect];
        
        motionEffect = [[UIInterpolatingMotionEffect alloc] initWithKeyPath:@"center.y"
                                                                       type:UIInterpolatingMotionEffectTypeTiltAlongVerticalAxis];
        motionEffect.minimumRelativeValue = @(-25);
        motionEffect.maximumRelativeValue = @(25);
        [messageLabel addMotionEffect:motionEffect];
    }
}

- (BOOL)textFieldShouldReturn: (UITextField *)textField
{
    [self drawHypnoticMessage:textField.text];
    textField.text = @"";
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
