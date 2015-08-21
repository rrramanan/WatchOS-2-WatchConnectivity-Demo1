//
//  ViewController.h
//  watchContact
//
//  Created by Vinod Ramanathan on 19/08/15.
//  Copyright © 2015 Vinod Ramanathan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <WatchConnectivity/WatchConnectivity.h>

@interface ViewController : UIViewController<WCSessionDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *contact_table;


@end

