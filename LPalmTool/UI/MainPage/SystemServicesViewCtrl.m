//
//  SystemServicesViewCtrl.m
//  LPalmTool
//
//  Created by 林述灿 on 15/10/21.
//  Copyright © 2015年 LSC. All rights reserved.
//

#import "SystemServicesViewCtrl.h"
#import "SystemServices.h"

#include <ifaddrs.h>
#include <sys/socket.h>
#include <net/if.h>

@interface SystemServicesViewCtrl ()

@property (nonatomic, retain) UILabel *lblMemoryRAM;
@property (nonatomic, retain) UILabel *lblUsedMemory;
@property (nonatomic, retain) UILabel *lblWiredMemory;
@property (nonatomic, retain) UILabel *lblActiveMemory;
@property (nonatomic, retain) UILabel *lblInactiveMemory;
@property (nonatomic, retain) UILabel *lblFreeMemory;
@property (nonatomic, retain) UILabel *lblPurgeableMemory;

@end

@implementation SystemServicesViewCtrl

- (id)init{
    self = [super init];
    if (self) {
        [self getInterfaceBytes];
    }
    
    return self;
}

- (void) getInterfaceBytes
{
    struct ifaddrs *ifa_list = 0, *ifa;
    if (getifaddrs(&ifa_list) == -1)
    {
        return;
    }
    
    uint32_t iBytes = 0;
    uint32_t oBytes = 0;
    
    for (ifa = ifa_list; ifa; ifa = ifa->ifa_next)
    {
        if (AF_LINK != ifa->ifa_addr->sa_family)
            continue;
        
        if (!(ifa->ifa_flags & IFF_UP) && !(ifa->ifa_flags & IFF_RUNNING))
            continue;
        
        if (ifa->ifa_data == 0)
            continue;
        
        /* Not a loopback device. */
//         en应该是wifi, pdp_ip大概是3g或者gprs, lo是环回接口
        if (strncmp(ifa->ifa_name, "lo", 2))
        {
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
            struct IF_DATA_TIMEVAL lastChange = if_data->ifi_lastchange;
            __int32_t second = lastChange.tv_sec;
            
//            NSString *str=@"1368082020";//时间戳
//            NSTimeInterval time=[str doubleValue]+28800;//因为时差问题要加8小时 == 28800 sec
            NSTimeInterval time = second;
            NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
            NSLog(@"date:%@",[detaildate description]);
          
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
            NSLog(currentDateStr);
            NSLog(@"%s", ifa->ifa_name);
            
            iBytes += if_data->ifi_ibytes;
            oBytes += if_data->ifi_obytes;
        }
    }
    
    NSLog(@"");
    
    freeifaddrs(ifa_list);
}

- (void)loadView{
    [super loadView];
    
    UIView* bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgView];
    [bgView release];
    
    UIButton* refleshBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [refleshBtn setTitle:@"刷新" forState:UIControlStateNormal];
    [refleshBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [refleshBtn addTarget:self action:@selector(refleshBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    refleshBtn.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds)/2, 50);
    [self.view addSubview:refleshBtn];
    
    UIButton* addMemoryBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [addMemoryBtn setTitle:@"增加内存" forState:UIControlStateNormal];
    [addMemoryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addMemoryBtn addTarget:self action:@selector(addMemoryClick:) forControlEvents:UIControlEventTouchUpInside];
    addMemoryBtn.frame = CGRectMake(CGRectGetWidth(self.view.bounds)/2, 0, CGRectGetWidth(self.view.bounds)/2, 50);
    [self.view addSubview:addMemoryBtn];
    
    [self initMemoryView];
}

- (void) initMemoryView{
    self.lblMemoryRAM = [[[UILabel alloc] initWithFrame:CGRectMake(0, 100, CGRectGetWidth(self.view.bounds), 50)] autorelease];
    self.lblMemoryRAM.textColor = [UIColor blackColor];
    self.lblMemoryRAM.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.lblMemoryRAM];
    
    self.lblUsedMemory = [[[UILabel alloc] initWithFrame:CGRectMake(0, 100+50, CGRectGetWidth(self.view.bounds), 50)] autorelease];
    self.lblUsedMemory.textColor = [UIColor redColor];
    self.lblUsedMemory.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.lblUsedMemory];
    
    self.lblFreeMemory = [[[UILabel alloc] initWithFrame:CGRectMake(0, 100+100, CGRectGetWidth(self.view.bounds), 50)] autorelease];
    self.lblFreeMemory.textColor = [UIColor greenColor];
    self.lblFreeMemory.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.lblFreeMemory];
    
    self.lblWiredMemory = [[[UILabel alloc] initWithFrame:CGRectMake(0, 100+150, CGRectGetWidth(self.view.bounds), 50)] autorelease];
    self.lblWiredMemory.textColor = [UIColor blackColor];
    self.lblWiredMemory.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.lblWiredMemory];
    
    self.lblActiveMemory = [[[UILabel alloc] initWithFrame:CGRectMake(0, 100+200, CGRectGetWidth(self.view.bounds), 50)] autorelease];
    self.lblActiveMemory.textColor = [UIColor blackColor];
    self.lblActiveMemory.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.lblActiveMemory];
    
    self.lblInactiveMemory = [[[UILabel alloc] initWithFrame:CGRectMake(0, 100+250, CGRectGetWidth(self.view.bounds), 50)] autorelease];
    self.lblInactiveMemory.textColor = [UIColor blueColor];
    self.lblInactiveMemory.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.lblInactiveMemory];
    
    self.lblPurgeableMemory = [[[UILabel alloc] initWithFrame:CGRectMake(0, 100+300, CGRectGetWidth(self.view.bounds), 50)] autorelease];
    self.lblPurgeableMemory.textColor = [UIColor orangeColor];
    self.lblPurgeableMemory.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.lblPurgeableMemory];
    
    [self getAllMemoryInformation];
}

- (void)refleshBtnClick:(id)sender{
    [self getAllMemoryInformation];
}

- (void)addMemoryClick:(id)sender{
//    uint8_t *buffer = malloc(1024*10000);
//    memset(buffer, '\0', 1024*10000);
//    free(buffer);
    
    for (int i = 0; i < 1024*100; i++) {
        UILabel* lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 50)];
    }
}

- (void)getAllMemoryInformation {
    // Amount of Memory (RAM)
    self.lblMemoryRAM.text = [NSString stringWithFormat:@"Memory (RAM): (±)%.2f MB",[[SystemServices sharedServices] totalMemory]];
    
    // Used Memory
    self.lblUsedMemory.text = [NSString stringWithFormat:@"Used Memory: %.2f MB %.0f%%", [[SystemServices sharedServices] usedMemoryinRaw], [[SystemServices sharedServices] usedMemoryinPercent]];
    
    // Wired Memory
    self.lblWiredMemory.text = [NSString stringWithFormat:@"Wired Memory: %.2f MB %.0f%%", [[SystemServices sharedServices] wiredMemoryinRaw], [[SystemServices sharedServices] wiredMemoryinPercent]];
    
    // Active Memory
    self.lblActiveMemory.text = [NSString stringWithFormat:@"Active Memory: %.2f MB %.0f%%", [[SystemServices sharedServices] activeMemoryinRaw], [[SystemServices sharedServices] activeMemoryinPercent]];
    
    // Inactive Memory
    self.lblInactiveMemory.text = [NSString stringWithFormat:@"Inactive Memory: %.2f MB %.0f%%", [[SystemServices sharedServices] inactiveMemoryinRaw], [[SystemServices sharedServices] inactiveMemoryinPercent]];
    
    // Free Memory
    self.lblFreeMemory.text = [NSString stringWithFormat:@"Free Memory: %.2f MB %.0f%%", [[SystemServices sharedServices] freeMemoryinRaw], [[SystemServices sharedServices] freeMemoryinPercent]];
    
    // Purgeable Memory
    self.lblPurgeableMemory.text = [NSString stringWithFormat:@"Purgeable Memory: %.2f MB %.0f%%", [[SystemServices sharedServices] purgableMemoryinRaw], [[SystemServices sharedServices] purgableMemoryinPercent]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"=====didReceiveMemoryWarning=======") ;
}

@end
