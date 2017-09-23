//
//  HighScoreViewController.h
//  Colour_Memory
//
//  Created by akshay bansal on 2/16/17.
//  Copyright © 2017 akshay bansal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HighScoreViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

- (IBAction)BackButton:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *HightScoreTableView;
@property (strong,nonatomic) NSMutableArray *highScoreData;

@end
