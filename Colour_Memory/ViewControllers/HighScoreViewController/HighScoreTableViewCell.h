//
//  HighScoreTableViewCell.h
//  Colour_Memory
//
//  Created by akshay bansal on 2/16/17.
//  Copyright © 2017 akshay bansal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HighScoreTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *rank;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *score;

@end
