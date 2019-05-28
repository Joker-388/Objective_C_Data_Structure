//
//  SubKey2.m
//  HashMapSet
//
//  Created by Joker on 2019/5/23.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "SubKey2.h"

@implementation SubKey2

- (BOOL)isEqual:(id)object {
    if (object == self) {
        return true;
    }
    if (!object || ![object isKindOfClass:[Key class]]) {
        return false;
    }
    return [(Key *)object value] == self.value;
}

- (void)dealloc {
//    NSLog(@"<%@, %p>: dealloc", self.class, self);
}

@end
