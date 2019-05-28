//
//  Person.h
//  Hash
//
//  Created by Joker on 2019/5/21.
//  Copyright © 2019 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;

+ (instancetype)personWithAge:(NSInteger)age;

@end

NS_ASSUME_NONNULL_END
