//
//  FTMessage.h
//  TeacherFieldTrip
//
//  Created by Morgan Collino on 16/11/2013.
//  Copyright (c) 2013 Morgan Collino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FTMessage : NSObject
{
    NSString *msg;
    BOOL fromMe;
    NSDate *date;
}

@property (nonatomic, copy) NSString *msg;
@property (nonatomic) BOOL fromMe;
@property (nonatomic, retain) NSDate *date;
- (instancetype) initWithDictionary: (NSDictionary *) dictionary;

@end
