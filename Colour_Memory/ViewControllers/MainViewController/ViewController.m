//
//  ViewController.m
//  Colour_Memory
//
//  Created by akshay bansal on 2/14/17.
//  Copyright © 2017 akshay bansal. All rights reserved.
//

#import "ViewController.h"
#import "NSMutableArray+shuffling.h"
#import "GameBoardCellCollectionViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "ScoreBoard+CoreDataProperties.h"
#import "AppDelegate.h"

@interface ViewController ()
{
    NSArray *cards;
    NSMutableArray *gridCards;
    NSMutableArray *selectedCards;
    __block int score;
    UIAlertAction* ok;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    cards=[[NSArray alloc] initWithObjects:@"colour1.png",@"colour2.png",@"colour3.png",@"colour4.png",@"colour5.png",@"colour6.png",@"colour7.png",@"colour8.png",nil];
    gridCards=[[NSMutableArray alloc] init];
    [gridCards addObjectsFromArray:cards];
    [gridCards addObjectsFromArray:cards];
    [gridCards shuffle];
    selectedCards=[[NSMutableArray alloc]init];
    score=0;
    self.scoreLable.text=[NSString stringWithFormat:@"Score:%d",score];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return 16.0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat screenWidth = collectionView.bounds.size.width;
    CGFloat screenHeight=collectionView.bounds.size.height;
    float cellWidth = screenWidth / 4.0 -2;
    float cellHeight = screenHeight/ 4.0 - 2;
    CGSize size = CGSizeMake(cellWidth, cellHeight);
    
    return size;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    GameBoardCellCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"gameGridCell" forIndexPath:indexPath];
    
    if (cell==NULL) {
        cell=[[GameBoardCellCollectionViewCell alloc] init];
    }

   
    cell.card.image=[UIImage imageNamed:@"card_back.jpg"];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GameBoardCellCollectionViewCell *cell= ((GameBoardCellCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath]);

    
    if (![selectedCards containsObject:indexPath]) {

        [UIView transitionWithView:cell.card duration:1.0f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            cell.card.image = [UIImage imageNamed:[gridCards objectAtIndex:indexPath.row]];
        } completion:nil];
        
        if ([selectedCards count]%2==0) {
            [selectedCards addObject:indexPath];
        }
        else
        {
            NSIndexPath *previousindex=[selectedCards lastObject];
            if ([[gridCards objectAtIndex:previousindex.row] isEqualToString:[gridCards objectAtIndex:indexPath.row]]) {
                [selectedCards addObject:indexPath];
                score=score+2;
            }
            else{
                [selectedCards removeLastObject];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [UIView transitionWithView:cell.card duration:1.0f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                        cell.card.image = [UIImage imageNamed:@"card_back.jpg"];
                    } completion:nil];
                    
                    GameBoardCellCollectionViewCell *previousCell=((GameBoardCellCollectionViewCell *)[collectionView cellForItemAtIndexPath:previousindex]);
                    [UIView transitionWithView:previousCell.card duration:1.0f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
                        previousCell.card.image = [UIImage imageNamed:@"card_back.jpg"];
                    } completion:nil];

                });
                
                score= score-1;
                
            }
            
            //set score
            self.scoreLable.text=[NSString stringWithFormat:@"Score:%d",score];
            
        }
        
    }
    
    if ([selectedCards count]==16) {
        [self GameFinised];
    }
    
    

}

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    context = delegate.persistentContainer.viewContext;
    return context;
}


-(void)SaveScoreonDisk:(NSString *)name{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    // Create a new managed object
    ScoreBoard *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"ScoreBoard" inManagedObjectContext:context];
    newDevice.name=name;
    newDevice.score=[NSString stringWithFormat:@"%d",score] ;
    
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
    

}

-(void)GameFinised{
    
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:[NSString stringWithFormat:@"Woa! you scored :%d",score]
                                  message:@"Enter Your Name"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action) {
                                                   //Do Some action here
                                                   
                                                   
                                                   [self SaveScoreonDisk:[alert.textFields objectAtIndex:0].text];
                                                   
                                                   [self.gameGrid reloadData];
                                                   score=0;
                                                   self.scoreLable.text=[NSString stringWithFormat:@"Score:%d",score];
                                                   
                                                   
                                               }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {
                                                       [alert dismissViewControllerAnimated:YES completion:nil];
                                                       
                                                       [self.gameGrid reloadData];
                                                       score=0;
                                                       self.scoreLable.text=[NSString stringWithFormat:@"Score:%d",score];
                                                   }];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Name";
           }];
    ok.enabled=[[alert.textFields objectAtIndex:0].text isEqualToString:@""]?false:true;
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(handleTextChange:) name:UITextFieldTextDidChangeNotification object:[alert.textFields objectAtIndex:0]];

    
    [alert addAction:ok];
    [alert addAction:cancel];

    [self presentViewController:alert animated:YES completion:nil];
    
}


-(void) handleTextChange:(NSNotification *)notification {
    
    NSString *string=[notification.object text];
    if (string.length>0) {
        ok.enabled=true;
    }
    else{
        ok.enabled=false;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)ScoreBoardButton:(id)sender {
    
}
@end
