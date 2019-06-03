//
//  Person.m
//  Hash
//
//  Created by Joker on 2019/5/21.
//  Copyright © 2019 Joker. All rights reserved.
//

#import "Person.h"
#import "JKRArray.h"

@interface Person ()

@property (nonatomic, strong) JKRArray *array;

@end

@implementation Person

+ (instancetype)personWithAge:(NSInteger)age {
    Person *p = [Person new];
    p.age = age;
    return p;
}

- (instancetype)init {
//    NSLog(@"Person init");
    self = [super init];
    return self;
}

/// 作为key，hash冲突时，key是否相等，哈希值相等的两个Person对象，isEqual不一定返回YES
- (BOOL)isEqual:(id)object {
    if (self == object) return YES;
    if (!object || ![object isMemberOfClass:[Person class]])return NO;
    return self.age == ((Person *)object).age && (self.name ? [self.name isEqualToString:((Person *)object).name] : !((Person *)object).name);
}

/// 作为key，决定哈希表中的索引值，如果两个Person对象isEqual返回YES，那么哈希值必然相等
- (NSUInteger)hash {
    NSUInteger hashCode = self.age;
    // 奇素数 hashCode * 31 == (hashCode<<5) - hashCode
    hashCode = (hashCode<<5) - hashCode + [self.name hash];
    return hashCode;
}

- (void)dealloc {
//    NSLog(@"%@ dealloc", self);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%zd", self.age];
}

@end
