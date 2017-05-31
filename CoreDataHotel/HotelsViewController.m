//
//  HotelsViewController.m
//  CoreDataHotel
//
//  Created by A Cahn on 4/24/17.
//  Copyright © 2017 A Cahn. All rights reserved.
//

#import "HotelsViewController.h"
#import "AppDelegate.h"
#import "Hotel+CoreDataClass.h"
#import "Hotel+CoreDataProperties.h"
#import "AutoLayout.h"
#import "RoomsViewController.h"

@interface HotelsViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(strong, nonatomic)NSArray *allHotels;

@property(strong, nonatomic)UITableView *tableView;

@property(strong, nonatomic)NSArray *images;

@property(strong, nonatomic)UIImage *okayMotel;
@property(strong, nonatomic)UIImage *solidStay;
@property(strong, nonatomic)UIImage *decentInn;
@property(strong, nonatomic)UIImage *fancyEstates;


@end

@implementation HotelsViewController

-(void)loadView{
    [super loadView];

    self.tableView                  = [[UITableView alloc]init];
    [self.view addSubview:self.tableView];
    self.okayMotel = [UIImage imageNamed:@"okay_motel"];
    self.solidStay = [UIImage imageNamed:@"solid_stay"];
    self.decentInn = [UIImage imageNamed:@"decent_inn"];
    self.fancyEstates = [UIImage imageNamed:@"fancy_estates"];
    
    self.images = [[NSArray alloc]initWithObjects:self.okayMotel, self.solidStay, self.decentInn, self.fancyEstates, nil];

    [AutoLayout fullScreeenConstraintsWithVFLForView:self.tableView];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self allHotels];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.delegate         = self;
    self.tableView.dataSource       = self;

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"HotelCell"];

}

-(NSArray *)allHotels{

    if(!_allHotels){

    AppDelegate *appDelegate        = (AppDelegate *)[[UIApplication sharedApplication]delegate];

    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;

    NSFetchRequest *request         = [NSFetchRequest fetchRequestWithEntityName:@"Hotel"];

    NSError *fetchError;

    NSArray *hotels                 = [context executeFetchRequest:request error:&fetchError];

        if(fetchError){
            NSLog(@"There was an error fetching hotels from core data.");
        }

    _allHotels                      = hotels;
    }
    return _allHotels;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_allHotels count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell           = [tableView dequeueReusableCellWithIdentifier:@"HotelCell" forIndexPath:indexPath];
    
    

    NSArray *hotels                 = _allHotels;
    Hotel *currentHotel             = hotels[indexPath.row];
    cell.textLabel.text             = currentHotel.name;
    cell.imageView.image = self.images[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{


    RoomsViewController *roomsVC    = [[RoomsViewController alloc]init];
    roomsVC.selectedHotel           = self.allHotels[indexPath.row];
    [self.navigationController pushViewController:roomsVC animated:YES];

}


@end
