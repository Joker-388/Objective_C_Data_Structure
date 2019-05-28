//
//  Key.h
//  HashMapSet
//
//  Created by Joker on 2019/5/23.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Key : NSObject

@property (nonatomic, assign) NSInteger value;

- (instancetype)initWithValue:(NSInteger)value;

@end

NS_ASSUME_NONNULL_END
