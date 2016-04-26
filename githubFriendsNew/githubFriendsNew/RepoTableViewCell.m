//
//  RepoTableViewCell.m
//  githubFriendsNew
//
//  Created by Steve Graff on 4/26/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import "RepoTableViewCell.h"

@implementation RepoTableViewCell

// awakFromNib is like viewDidLoad
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

// Initialize color of table cell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.contentView.backgroundColor = [UIColor blueColor];
    } else {
        self.contentView.backgroundColor = [UIColor orangeColor];

    }


}

@end
