//
//  SortModel.h
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/10/8.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKRSort.h"

NS_ASSUME_NONNULL_BEGIN

@interface JKRSortModel : NSObject<JKRSortCompare>

@property (nonatomic, assign) NSInteger score;
@property (nonatomic, assign) NSInteger age;

@end

NS_ASSUME_NONNULL_END
