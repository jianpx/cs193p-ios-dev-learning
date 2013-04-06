//
//  PlayingCard.m
//  Assignment1_Matchismo
//
//  Created by jianpx on 3/26/13.
//  Copyright (c) 2013 PS. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

@synthesize suit = _suit;

- (NSString *)contents
{
    NSUInteger rank = self.rank <= [PlayingCard maxRank] ? self.rank : 0;
    return [[PlayingCard rankStrings][rank] stringByAppendingString:self.suit];
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    int count = [otherCards count];
    if (count == 1) {
        id card = [otherCards lastObject];
        //introspections for robust
        if ([card isKindOfClass:[PlayingCard class]]) {
            PlayingCard *otherPlayingCard = card;
            if ([otherPlayingCard.suit isEqualToString:self.suit]) {
                score = 1;
            } else if (otherPlayingCard.rank == self.rank) {
                score = 4;
            }
        }

    } else if (count == 2) {
        id firstCard = otherCards[0];
        id secondCard = otherCards[1];
        if ([firstCard isKindOfClass:[self class]] && [secondCard isKindOfClass:[self class]]) {
            PlayingCard *firstPlayingCard = firstCard;
            PlayingCard *secondPlayingCard = secondCard;
            if ([firstPlayingCard.suit isEqualToString:self.suit] && [secondPlayingCard.suit isEqualToString:self.suit]) {
                score = 2;
            } else if (firstPlayingCard.rank == self.rank && secondPlayingCard.rank == self.rank) {
                score = 8;
            }
        }
    }
    return score;
}

+ (NSArray *)validSuits
{
    return @[@"♠", @"♣", @"♥", @"♦"];
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank
{
    return [[PlayingCard rankStrings] count] - 1;
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}
- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) _suit = suit;
}
- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) _rank = rank;
}
@end