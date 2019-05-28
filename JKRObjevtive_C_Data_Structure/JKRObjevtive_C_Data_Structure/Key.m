//
//  Key.m
//  HashMapSet
//
//  Created by Joker on 2019/5/23.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "Key.h"

@implementation Key

- (instancetype)initWithValue:(NSInteger)value {
    self = [super init];
    self.value = value;
    return self;
}

- (NSUInteger)hash {
    return self.value / 10;
}

- (BOOL)isEqual:(id)object {
    if (object == self) {
        return true;
    }
    if (!object || ![object isKindOfClass:[Key class]]) {
        return false;
    }

    return [(Key *)object value] == self.value;
}

@end
