//
//  XTTry.m
//  XeeTourizm
//
//  Created by Morgan Collino on 01/09/13.
//  Copyright (c) 2013 Morgan Collino. All rights reserved.
//

#import "XTTry.h"

@implementation XTTry


+ (NSString *) tryGettingString: (NSDictionary *) dictionary forKey: (NSObject *)key defaultValue: (NSString *) defaultValue
{
    NSString *value = defaultValue;
    @try
    {
        value = [[NSString alloc] initWithString: (NSString *) [dictionary objectForKey: key]];
        if (value && ![value isEqualToString: @""])
            return value;
    }
    @catch (NSException *exception)
    {
        NSLog(@"XTTryGettingString-Exception: %@", exception.description);
    }
    
    return defaultValue;
}

+ (NSString *) tryGettingString: (NSDictionary *) dictionary forKey: (NSObject *)key
{
    NSString *value = @"";
    @try
    {
        value = [dictionary objectForKey: key];
        if (value && ![value isEqualToString: @""])
            return value;
    }
    @catch (NSException *exception)
    {
        NSLog(@"XTTryGettingString-Exception: %@ debug: Dictionary {%@}, Key: %@", exception.description, dictionary, key);
    }
    
    return @"";
}

+ (NSNumber *) tryGettingNumber: (NSDictionary *) dictionary forKey: (NSObject *)key defaultValue: (NSNumber *) defaultValue
{
    NSNumber *value = defaultValue;
    @try
    {
        value = [dictionary objectForKey: key];
        if (value)
            return value;
    }
    @catch (NSException *exception)
    {
        NSLog(@"XTTryGettingNumber-Exception: %@", exception.description);
    }
    
    return defaultValue;
}

+ (NSNumber *) tryGettingNumber: (NSDictionary *) dictionary forKey: (NSObject *)key
{
    NSNumber *value = [NSNumber numberWithInt:0];
    @try
    {
        value = [dictionary objectForKey: key];
        if (value)
            return value;
    }
    @catch (NSException *exception)
    {
        NSLog(@"XTTryGettingNumber-Exception: %@", exception.description);
    }
    
    return [NSNumber numberWithInt:0];
}

+ (double) tryGettingDouble: (NSDictionary *) dictionary forKey: (NSObject *)key defaultValue: (double) defaultValue
{
    @try
    {
        NSString *value = [dictionary objectForKey: key];
        if (!value)
            return defaultValue;
        double var = [value doubleValue];
        return var;
    }
    @catch (NSException *exception)
    {
        NSLog(@"XTTryGettingDouble-Exception: %@", exception.description);
    }
    
    return defaultValue;
}

+ (double) tryGettingDouble: (NSDictionary *) dictionary forKey: (NSObject *)key
{
    @try
    {
        NSString *value = [dictionary objectForKey: key];
        double var = [value doubleValue];
        return var;
    }
    @catch (NSException *exception)
    {
        NSLog(@"XTTryGettingDouble-Exception: %@", exception.description);
    }
    
    return 0.0;
}

+ (NSDictionary *) tryGettingDictionary: (NSDictionary *) dictionary forKey: (NSObject *)key defaultValue: (NSDictionary *) defaultValue
{
    @try
    {
        id value = [dictionary objectForKey: key];
        if ([value isKindOfClass: [NSDictionary class]])
            return value;
    }
    @catch (NSException *exception)
    {
        NSLog(@"XTTryGettingDictionary-Exception: %@", exception.description);
    }
    
    return defaultValue;
}

+ (NSDictionary *) tryGettingDictionary: (NSDictionary *) dictionary forKey: (NSObject *)key
{
    @try
    {
        id value = [dictionary objectForKey: key];
        if ([value isKindOfClass: [NSDictionary class]])
            return value;
    }
    @catch (NSException *exception)
    {
        NSLog(@"XTTryGettingDictionary-Exception: %@", exception.description);
    }
    
    return @{};
}


+ (NSArray *) tryGettingArray: (NSDictionary *) dictionary forKey: (NSObject *)key defaultValue: (NSArray *) defaultValue
{
    @try
    {
        id value = [dictionary objectForKey: key];
        if ([value isKindOfClass: [NSArray class]])
            return value;
    }
    @catch (NSException *exception)
    {
        NSLog(@"XTTryGettingArray-Exception: %@", exception.description);
    }
    
    return defaultValue;
}

+ (NSArray *) tryGettingArray: (NSDictionary *) dictionary forKey: (NSObject *)key
{
    @try
    {
        id value = [dictionary objectForKey: key];
        if ([value isKindOfClass: [NSArray class]])
            return value;
    }
    @catch (NSException *exception)
    {
        NSLog(@"XTTryGettingArray-Exception: %@", exception.description);
    }
    
    return @[];
}


@end
