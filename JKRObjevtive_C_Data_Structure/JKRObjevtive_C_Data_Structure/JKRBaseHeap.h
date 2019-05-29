//
//  JKRBaseHeap.h
//  JKRObjevtive_C_Data_Structure
//
//  Created by Joker on 2019/5/29.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JKRBaseHeap<ObjectType> : NSObject {
@protected
    NSUInteger _size;
}

@end

@interface JKRBaseHeap<ObjectType> (JKRBaseHeap)

- (NSUInteger)count;
- (void)removeAllObjects;
- (void)addObject:(nonnull ObjectType)anObject;
- (void)removeTop;
- (nullable ObjectType)top;
- (void)replaceTop:(nonnull ObjectType)anObject;

@end

NS_ASSUME_NONNULL_END
