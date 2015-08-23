//
//  TableSectionTableViewCell.m
//  IOSProgrammerTest
//
//  Created by Justin LeClair on 12/15/14.
//  Copyright (c) 2014 AppPartner. All rights reserved.
//

#import "ChatCell.h"

@interface ChatCell ()
@property (nonatomic, strong) IBOutlet UILabel *usernameLabel;
@property (nonatomic, strong) IBOutlet UITextView *messageTextView;
@property (nonatomic, strong) IBOutlet UIImageView *avatar;

@end

@implementation ChatCell

- (void)loadWithData:(ChatData *)chatData
{
    self.usernameLabel.text = chatData.username;
    self.messageTextView.text = chatData.message;
    
    NSURL *url = [NSURL URLWithString:chatData.avatar_url];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
    self.avatar.image = image;
    
    self.avatar.layer.cornerRadius = self.avatar.frame.size.width / 2;
    self.avatar.clipsToBounds = YES;
}

@end
