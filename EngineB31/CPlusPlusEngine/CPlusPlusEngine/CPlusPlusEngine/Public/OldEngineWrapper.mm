//
//  HelloWorldWrapper.m
//  EngineB31
//
//  Created by Egor Zemlyanskiy on 23.05.2024.
//

#import <Foundation/Foundation.h>
#import "OldEngineWrapper.h"
#import "OldEngine.hpp"
#import <CPlusPlusEngine/SystemMonitor.h>
@implementation OldEngineWrapper
- (NSString *) wroom {
    OldEngine oldEngine = OldEngine(100);
    
    CPUUsage usage = SystemMonitor.cpuUsage;
    NSLog(@"Current CPU usage/n");
    NSLog(@"System -> %d ", usage.system);
    NSLog(@"User -> %d ", usage.user);
    NSLog(@"Idle -> %d ", usage.idle);

    std::string oldEngineMessage = oldEngine.wrooom();
    return [NSString
            stringWithCString:oldEngineMessage.c_str()
            encoding:NSUTF8StringEncoding];
}
@end
