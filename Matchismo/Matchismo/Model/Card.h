//
//  Card.h
//  Matchismo
//
//  Created by jianpx on 3/19/13.
//  Copyright (c) 2013 PS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong, nonatomic) NSString *contents;
@property (nonatomic) BOOL faceUp;
@property (nonatomic) BOOL unplayable;

- (int) match: (NSArray *)otherCards;
@end
