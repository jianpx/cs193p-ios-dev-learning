//
//  Deck.h
//  Assignment1_Matchismo
//
//  Created by jianpx on 3/26/13.
//  Copyright (c) 2013 PS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

@property (nonatomic, strong) NSMutableArray *cards;

- (Card *)drawRandomCard;
- (void)addCard:(Card *) card atTop:(BOOL) atTop;
@end
