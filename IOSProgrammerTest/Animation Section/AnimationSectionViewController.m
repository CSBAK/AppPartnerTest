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
//    self.startingPoint = self.logoImage.center;
    self.logoImage.userInteractionEnabled = YES;

    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gesture:)];
    [self.logoImage addGestureRecognizer:panRecognizer];

}

- (IBAction)spinAction:(id)sender {
    CABasicAnimation* anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    [anim setDuration:1.0f]; // Animation duration to 3 seconds
    [anim setAutoreverses:NO];
    [anim setRepeatCount:1]; // Perfrom animation 1 time
    [anim setFromValue:[NSNumber numberWithDouble:0.0f]];
    [anim setToValue:[NSNumber numberWithDouble:(M_PI * 2.0f)]];
    [self.logoImage.layer addAnimation:anim forKey:@"my_rotation"];
    
    NSLog(@"Spinning!");
}
- (IBAction)gesture:(UIPanGestureRecognizer *)sender {
    NSLog(@"Touched!");
    
    CGPoint point = [sender locationInView:self.view];
//    self.logoImage.center = point;

    
//    CGPoint translation = [sender translationInView:self.view];
//    CGPoint imageViewPosition = self.logoImage.center;
//    imageViewPosition.x += translation.x;
//    imageViewPosition.y += translation.y;
    
    self.logoImage.center = point;
    [sender setTranslation:CGPointZero inView:self.view];


    if (CGRectContainsPoint(self.logoImage.frame, point)) {
//        [self.logoImage sizeToFit];
    }
//    if (sender.state == UIGestureRecognizerStateEnded) {
//        [UIImageView animateWithDuration:2.0f animations:^ {
//            self.logoImage.center = self.startingPoint;
//
//        }];
//    }
}



    
//    [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationOptionTransitionNone
//                     animations:^
//     {
//         CGAffineTransform transform = self.logoImage.transform;
//         CGAffineTransform transform_new = CGAffineTransformRotate(transform, M_PI);
//         self.logoImage.transform = transform_new;
//     } completion:nil];


- (IBAction)backAction:(id)sender
{
    MainMenuViewController *mainMenuViewController = [[MainMenuViewController alloc] init];
    [self.navigationController pushViewController:mainMenuViewController animated:YES];
}

@end
