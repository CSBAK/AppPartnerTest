//
//  AnimationSectionViewController.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "AnimationSectionViewController.h"
#import "MainMenuViewController.h"

@interface AnimationSectionViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property CGPoint startingPoint;

@end

@implementation AnimationSectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.startingPoint = self.logoImage.center;
    self.logoImage.userInteractionEnabled = YES;

    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gesture:)];
    [self.logoImage addGestureRecognizer:panRecognizer];

}

- (IBAction)spinAction:(id)sender {
    CABasicAnimation *spin = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    [spin setDuration:1.0f];
    [spin setAutoreverses:NO];
    [spin setRepeatCount:1];
    [spin setFromValue:[NSNumber numberWithDouble:0.0f]];
    [spin setToValue:[NSNumber numberWithDouble:(M_PI * 2.0f)]];
    [self.logoImage.layer addAnimation:spin forKey:@"my_rotation"];
    
    NSLog(@"Spinning!");
}
- (IBAction)gesture:(UIPanGestureRecognizer *)sender {
    NSLog(@"Touched!");

    CGPoint point = [sender locationInView:self.view];
    self.logoImage.center = point;

        if (CGRectContainsPoint(self.logoImage.frame, point)) {
            [self.logoImage sizeToFit];
        }

        if (sender.state == UIGestureRecognizerStateEnded) {
        [UIImageView animateWithDuration:1.5f animations:^ {
            self.logoImage.center = self.startingPoint;
            }];
    }
}

- (IBAction)backAction:(id)sender {
    MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc] init];
    [self.navigationController pushViewController:mainMenuViewController animated:YES];
}

@end
