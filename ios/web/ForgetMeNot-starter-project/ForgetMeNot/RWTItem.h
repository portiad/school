//
//  RWTItem.h
//  ForgetMeNot
//
//  Created by Chris Wagner on 1/29/14.
//  Copyright (c) 2014 Ray Wenderlich Tutorial Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWTItem : NSObject <NSCoding>

@property (strong, nonatomic, readonly) NSString *name;
@property (strong, nonatomic, readonly) NSUUID *uuid;
@property (assign, nonatomic, readonly) uint16_t majorValue;
@property (assign, nonatomic, readonly) uint16_t minorValue;

- (instancetype)initWithName:(NSString *)name
                        uuid:(NSUUID *)uuid
                       major:(uint16_t)major
                       minor:(uint16_t)minor;


@end
