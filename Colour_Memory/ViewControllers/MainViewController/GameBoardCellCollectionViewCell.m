//
//  GameBoardCellCollectionViewCell.m
//  Colour_Memory
//
//  Created by akshay bansal on 2/14/17.
//  Copyright © 2017 akshay bansal. All rights reserved.
//

#import "GameBoardCellCollectionViewCell.h"

@implementation GameBoardCellCollectionViewCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.card.clipsToBounds = YES;
    self.card.layer.cornerRadius = 8.0;
    self.card.layer.borderWidth = 1.0;
    self.card.layer.borderColor = [UIColor whiteColor].CGColor;
}


@end
