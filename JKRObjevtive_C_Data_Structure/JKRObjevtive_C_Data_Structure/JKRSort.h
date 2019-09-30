//
//  JKRSort.h
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/9/29.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JKRArrayList.h"

NS_ASSUME_NONNULL_BEGIN

@interface JKRSort<__covariant ObjectType> : NSObject {
@private
    NSInteger _compareCount;
    NSInteger _swapCount;
    CFAbsoluteTime _time;
    
@protected
    JKRArrayList<ObjectType> *_array;
}

- (NSComparisonResult)compare:(JKRSort *)otherSort;
- (void)sortWithArray:(JKRArrayList<ObjectType> *)array;
- (NSComparisonResult)compareWithIndex0:(NSUInteger)index0 index1:(NSUInteger)index1;
- (NSComparisonResult)compareWithObject0:(ObjectType)object0 object1:(ObjectType)object1;
- (void)swapWithIndex0:(NSUInteger)index0 index1:(NSUInteger)index1;

@end

@interface JKRSort<__covariant ObjectType> (JKRSort)

- (void)sort;

@end

NS_ASSUME_NONNULL_END
