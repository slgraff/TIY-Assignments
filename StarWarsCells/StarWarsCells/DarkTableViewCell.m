//
//  DarkTableViewCell.m
//  StarWarsCells
//
//  Created by Steve Graff on 5/4/16.
//  Copyright © 2016 Steve Graff. All rights reserved.
//

#import "DarkTableViewCell.h"

@implementation DarkTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    // Set custom border color to blue
    // cell.imageView.layer.borderColor=[[UIColor redColor]CGColor];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
