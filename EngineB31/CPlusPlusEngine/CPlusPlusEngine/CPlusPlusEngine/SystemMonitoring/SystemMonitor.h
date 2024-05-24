//
//  SystemMonitor.h
//  CPlusPlusEngine
//
//  Created by Egor Zemlyanskiy on 24.05.2024.
//

#ifndef SystemMonitor_h
#define SystemMonitor_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef struct {
    unsigned int system;
    unsigned int user;
    unsigned int nice;
    unsigned int idle;
} CPUUsage;

@interface SystemMonitor: NSObject
+ (CPUUsage)cpuUsage;
+ (CGFloat)appCpuUsage;
@end

#endif /* SystemMonitor_h */
