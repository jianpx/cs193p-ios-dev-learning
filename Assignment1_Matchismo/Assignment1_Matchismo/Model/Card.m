//
//  Card.m
//  Assignment1_Matchismo
//
//  Created by jianpx on 3/25/13.
//  Copyright (c) 2013 PS. All rights reserved.
//

#import "Card.h"

@implementation Card

- (BOOL)isFaceup
{
    return _faceUp;
}

- (BOOL)isUnplayable
{
    return _unplayable;
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            return 1;
        }
    }
    return score;
}
@end
