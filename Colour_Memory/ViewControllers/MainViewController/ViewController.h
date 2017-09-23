//
//  ViewController.h
//  Colour_Memory
//
//  Created by akshay bansal on 2/14/17.
//  Copyright © 2017 akshay bansal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface ViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UICollectionView *gameGrid;
@property (strong, nonatomic) IBOutlet UILabel *scoreLable;
- (IBAction)ScoreBoardButton:(id)sender;

@end

