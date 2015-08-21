//
//  ViewController.m
//  watchContact
//
//  Created by Vinod Ramanathan on 19/08/15.
//  Copyright © 2015 Vinod Ramanathan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

NSString *home_mobile;
NSString *Fname;

NSMutableArray *name;
NSMutableArray *number;
NSMutableArray *allarray;
NSMutableArray *allkey;

NSMutableDictionary *loadall;

NSMutableArray *ForTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"didload yea");
    
    
    if ([WCSession isSupported]) {
        
        WCSession *session = [WCSession defaultSession];
        session.delegate=self;
        [session activateSession];
        
    }
    
    [_contact_table setDataSource:self];
    [_contact_table setDelegate:self];
    
    name=[[NSMutableArray alloc]init];
    number=[[NSMutableArray alloc ]init];
    
    allarray =[[NSMutableArray alloc ]init];

    allkey=[[NSMutableArray alloc ]initWithObjects:@"Name",@"Phone", nil];
    
    ForTable =[[NSMutableArray alloc ]init];

    
   // ABAddressBookRef *******
   ABAddressBookRef  addressBook  = ABAddressBookCreateWithOptions(NULL, NULL);
    
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
        if (error) {
            NSLog(@"error %@", error);
        }else if (granted){
            // Do what you want with the Address Book
            
            
            CFArrayRef allSources = ABAddressBookCopyArrayOfAllPeople( addressBook );
            for (CFIndex i = 0; i < ABAddressBookGetPersonCount( addressBook ); i++)
            {
                ABRecordRef aSource = CFArrayGetValueAtIndex(allSources,i);
                ABMultiValueRef phones =(__bridge ABMultiValueRef)((__bridge NSString*)ABRecordCopyValue(aSource, kABPersonPhoneProperty));
                NSString* mobileLabel;
               
                NSString* namestr = (__bridge_transfer NSString*)ABRecordCopyValue(aSource,
                                                                                   kABPersonFirstNameProperty);
                
              //  NSLog(@"NAME %@",namestr);
                
                [name addObject:namestr];
               // NSLog(@"array name %@",name);
                
                for(CFIndex i = 0; i < ABMultiValueGetCount(phones); i++) {
                    
                    mobileLabel = (__bridge NSString*)ABMultiValueCopyLabelAtIndex(phones, i);
                    
                    if([mobileLabel isEqualToString:(NSString *)kABPersonPhoneMobileLabel])  //kABPersonPhoneMobileLabel
                    {
                        home_mobile = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phones, i) ;
                      //  NSLog(@"home mobile %@",home_mobile);
                        
                    }
                    
                    
                    
                }//for
                [number addObject:home_mobile];
              //  NSLog(@"array number %@",number);
                
                
                
            }//for
            
            [allarray insertObject:name atIndex:0];
            [allarray insertObject:number atIndex:1];
          //  NSLog(@"allarray %@",allarray);
            
            [ForTable addObjectsFromArray:name];
          //  NSLog(@"TAble Array %@",ForTable);
            
            
        
           loadall=[NSMutableDictionary dictionaryWithObjects:allarray forKeys:allkey];
            NSLog(@"thedict %@",loadall);

            
            
            NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
            
            [userdefault setObject:loadall forKey:@"watch"];
            
            
            [userdefault synchronize];
            
            
            [_contact_table reloadData];
            
            
            
        }else{
            NSLog(@"permission denied");
        }
        
        CFRelease(addressBook);
    });

   
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)session:(nonnull WCSession *)session didReceiveMessage:(nonnull NSDictionary<NSString *,id> *)message replyHandler:(nonnull void (^)(NSDictionary<NSString *,id> * __nonnull))replyHandler{
    
    
    if ([[message objectForKey:@"check"]isEqualToString:@"Contacts"]) {
        
        NSLog(@"Dict match");
       
       
        
        NSMutableDictionary *dii;
        
        NSUserDefaults *ret = [NSUserDefaults standardUserDefaults];
        
        dii   =  [[ret objectForKey:@"watch"]mutableCopy];
        
        NSLog(@"DICT RET %@'",dii);
        
        replyHandler(dii);
        
        
    }
       
    
    
    // After didSelect from Watch Table **
    NSString *get = [message valueForKey:@"Number"];
    NSLog(@"GET IS %@",get);
    
    NSString *getname = [message valueForKey:@"Name"];
    NSLog(@"GET Name %@",getname);
    
    NSString *namestr =[NSString stringWithFormat:@"Call %@",getname];
    
    
    
    if ([[message objectForKey:@"Number"]isEqualToString:get]) {
        
       
        UIAlertAction *act1 = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
            
            
        }];
        
        UIAlertAction *act2 = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action){
            
            
        }];
        
        UIAlertController *alert =[UIAlertController alertControllerWithTitle:namestr message:get preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addAction:act1];
        [alert addAction:act2];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
        
    }
    
    
    
}

//Table *****

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [ForTable count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    
    
    NSString *object = ForTable[indexPath.row ]; //here
    cell.textLabel.text = [object description];
    return cell;
    
}



@end
