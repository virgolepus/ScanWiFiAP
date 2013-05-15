//
//  ScanWiFiAPAppDelegate.m
//  ScanWiFiAP
//
//  Created by Hongfu Sun on 2013-05-15.
//  Copyright (c) 2013 University of Calgary. All rights reserved.
//

#import "ScanWiFiAPAppDelegate.h"

@interface AP : ScanWiFiAPAppDelegate

@property NSString *ssid;
@property NSString *bssid;
@property NSInteger rssi;

@end

@implementation ScanWiFiAPAppDelegate

- (NSArray *)ScanWiFi: (const char *) interfacename
{
    NSString * ifName = [NSString stringWithUTF8String:interfacename];
    CWInterface * interface = [CWInterface interfaceWithName:ifName];
    
    NSError * error = nil;
    NSArray * scanResult = [[interface scanForNetworksWithSSID:nil error:&error] allObjects];
    
    if (error)
    {
        NSLog(@"%@ (%ld)", [error localizedDescription], [error code]);
    }
    
    NSMutableArray * result = [[NSMutableArray alloc] init];
    for (CWNetwork * network in scanResult)
    {
        AP *m_AP;
        m_AP.ssid = [network ssid];
        m_AP.bssid = [network bssid];
        m_AP.rssi = [network rssiValue];
        [result addObject:[NSValue value:&m_AP withObjCType:@encode(AP)]];
    }
    
    return result;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    char interface[] = "en1";
    NSArray * scanRS = [self ScanWiFi:interface];
}


@end
