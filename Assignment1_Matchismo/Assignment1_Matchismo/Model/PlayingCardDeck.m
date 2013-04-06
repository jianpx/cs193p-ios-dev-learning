//
//  PlayingCardDeck.m
//  Assignment1_Matchismo
//
//  Created by jianpx on 3/26/13.
//  Copyright (c) 2013 PS. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (PlayingCardDeck *)init
{
    self = [super init];
    if (self){
        for (NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank=1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc] init];
                card.suit = suit;
                card.rank = rank;
                [self addCard:card atTop:YES];
            }
        }
    }
    return self;
}
@end
