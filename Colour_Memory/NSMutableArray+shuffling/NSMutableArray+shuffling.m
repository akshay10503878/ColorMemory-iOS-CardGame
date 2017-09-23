//
//  NSMutableArray+shuffling.m
//  Colour_Memory
//
//  Created by akshay bansal on 2/14/17.
//  Copyright © 2017 akshay bansal. All rights reserved.
//

#import "NSMutableArray+shuffling.h"

@implementation NSMutableArray (shuffling)


-(void)shuffle
{
    NSUInteger count = [self count];
    if (count <= 1) return;
    for (NSUInteger i = 0; i < count - 1; ++i) {
        NSInteger remainingCount = count - i;
        NSInteger exchangeIndex = i + arc4random_uniform((u_int32_t )remainingCount);
        [self exchangeObjectAtIndex:i withObjectAtIndex:exchangeIndex];
    }
}



@end
