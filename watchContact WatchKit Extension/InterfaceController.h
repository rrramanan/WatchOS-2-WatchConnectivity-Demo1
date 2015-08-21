//
//  InterfaceController.h
//  watchContact WatchKit Extension
//
//  Created by Vinod Ramanathan on 19/08/15.
//  Copyright © 2015 Vinod Ramanathan. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import <Contacts/Contacts.h>


@interface InterfaceController : WKInterfaceController
@property (strong, nonatomic) IBOutlet WKInterfaceTable *watch_Table;

@end
