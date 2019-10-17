//
//  SortModel.m
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/10/8.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "JKRSortModel.h"

@implementation JKRSortModel

- (NSComparisonResult)compare:(JKRSortModel *)other {
    if (self.age == other.age) {
        return NSOrderedSame;
    } else if (self.age > other.age) {
        return NSOrderedDescending;
    } else {
        return NSOrderedAscending;
    }
}

@end
