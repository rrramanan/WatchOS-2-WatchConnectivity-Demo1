//
//  InterfaceController.m
//  watchContact WatchKit Extension
//
//  Created by Vinod Ramanathan on 19/08/15.
//  Copyright © 2015 Vinod Ramanathan. All rights reserved.
//

#import "InterfaceController.h"
#import <WatchConnectivity/WatchConnectivity.h>
#import "rowcontroller.h"


@interface InterfaceController()<WCSessionDelegate>

@end


@implementation InterfaceController
NSMutableArray *forName;
NSMutableArray *forNumber;


- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    
    
      NSLog(@"yes watchkit");
    
    forName = [[NSMutableArray alloc]init];
    forNumber = [[NSMutableArray alloc]init];
    
    if ([WCSession isSupported]) {
        
        WCSession *session = [WCSession defaultSession];
        session.delegate=self;
        [session activateSession];
        
    }
    
  
    
    NSDictionary *sendC = @{@"check":@"Contacts"};
    
    [[WCSession defaultSession]sendMessage:sendC replyHandler:^(NSDictionary *reply){
        
        NSLog(@"reply !!");
        
       // NSString *NameStr = [NSString stringWithFormat:@"%@",[reply objectForKey:@"Name"]];
        
      //  NSLog(@"%@",NameStr);
        
        forName =[reply objectForKey:@"Name"];
        
        NSLog(@"ARRAY Name %@",forName);
       
     //   NSString *NumStr = [NSString stringWithFormat:@"%@",[reply objectForKey:@"Phone"]];
       
    //    NSLog(@"%@",NumStr);
       
        forNumber =[reply objectForKey:@"Phone"];

        NSLog(@"ARRAY Number %@",forNumber);
      
        [_watch_Table setNumberOfRows:[forName count] withRowType:@"rowID"];
        
        
        for(int i=0 ; i < [forName count]; i++){
            
            NSString *name = [forName objectAtIndex:i];
            
            rowcontroller *rowvc = [_watch_Table rowControllerAtIndex:i];
            
            [rowvc.label_table setText:name];
            
        }

       
        
        
    }errorHandler:^(NSError *error){
        
    }];
    
    
    
}


-(void)table:(WKInterfaceTable *)table didSelectRowAtIndex:(NSInteger)rowIndex{
    
    
   // NSLog(@"Did Select");
    
    
    NSLog(@" %@ = %@",[forName objectAtIndex:rowIndex],[forNumber objectAtIndex:rowIndex]);
    
    NSDictionary *sendNumber = @{@"Number":[forNumber objectAtIndex:rowIndex],@"Name":[forName objectAtIndex:rowIndex]};
    
    
    
    [[WCSession defaultSession]sendMessage:sendNumber replyHandler:^(NSDictionary *reply){
        
    }errorHandler:^(NSError *error){
        
    }];
    
    
    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
   
    if ([WCSession isSupported]) {
        
        WCSession *session = [WCSession defaultSession];
        session.delegate=self;
        [session activateSession];
        
    }
    
    
    
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



