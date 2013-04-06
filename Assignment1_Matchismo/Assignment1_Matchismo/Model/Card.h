//
//  Card.h
//  Assignment1_Matchismo
//
//  Created by jianpx on 3/25/13.
//  Copyright (c) 2013 PS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (nonatomic, strong) NSString *contents;
@property (nonatomic, getter = isFaceup) BOOL faceUp;
@property (nonatomic, getter = isUnplayable) BOOL unplayable;

- (int)match:(NSArray *)otherCards;
@end