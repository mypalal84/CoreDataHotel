//
//  RoomsViewController.m
//  CoreDataHotel
//
//  Created by A Cahn on 4/24/17.
//  Copyright © 2017 A Cahn. All rights reserved.
//

#import "RoomsViewController.h"
#import "AppDelegate.h"
#import "Room+CoreDataClass.h"
#import "Room+CoreDataProperties.h"
#import "AutoLayout.h"

@interface RoomsViewController ()<UITableViewDataSource>

@property(strong, nonatomic)NSArray *allRooms;

@property(strong, nonatomic)UITableView *tableView;

@end

@implementation RoomsViewController

-(void)loadView{
    [super loadView];

    self.tableView                  = [[UITableView alloc]init];
    [self.view addSubview:self.tableView];
    
    [AutoLayout fullScreeenConstraintsWithVFLForView:self.tableView];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.allRooms             = [[self.selectedHotel rooms]allObjects];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"RoomCell"];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_allRooms count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell     = [tableView dequeueReusableCellWithIdentifier:@"RoomCell" forIndexPath:indexPath];

    Room *room                = self.allRooms[indexPath.row];

    cell.textLabel.text       = [NSString stringWithFormat:@"%d", room.number];

    return cell;
}




@end
