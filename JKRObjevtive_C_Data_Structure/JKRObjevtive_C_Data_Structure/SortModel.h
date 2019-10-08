//
//  SortModel.h
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/10/8.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SortModel : NSObject

@property (nonatomic, assign) NSInteger score;
@property (nonatomic, assign) NSInteger age;

- (NSComparisonResult)compare:(SortModel *)other;

@end

NS_ASSUME_NONNULL_END
