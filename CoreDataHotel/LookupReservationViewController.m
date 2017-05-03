//
//  LookupReservationViewController.m
//  CoreDataHotel
//
//  Created by A Cahn on 4/26/17.
//  Copyright © 2017 A Cahn. All rights reserved.
//

#import "LookupReservationViewController.h"
#import "AutoLayout.h"
#import "AppDelegate.h"
#import "Reservation+CoreDataClass.h"
#import "Reservation+CoreDataProperties.h"
#import "Guest+CoreDataClass.h"
#import "Guest+CoreDataProperties.h"
#import "Hotel+CoreDataClass.h"
#import "Hotel+CoreDataProperties.h"
#import "Room+CoreDataClass.h"
#import "Room+CoreDataProperties.h"
#import "DatePickerViewController.h"

@interface LookupReservationViewController ()<UITableViewDataSource, UISearchBarDelegate>

@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)NSArray *allReservations;
@property(strong, nonatomic)NSMutableArray *filteredReservations;
@property(strong, nonatomic)UISearchBar *searchBar;

@end

@implementation LookupReservationViewController

BOOL isSearching;

-(void)loadView{
    [super loadView];
    
    [self setupSearchBar];
    
    [self setupTableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.dataSource = self;
    
    self.searchBar.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    [self.searchBar resignFirstResponder];
}

-(void)setupTableView{
    
    self.tableView = [[UITableView alloc]init];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Reservation"];
    [self.view addSubview:self.tableView];
    [self.tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [AutoLayout offset:0 fromViewTop:self.tableView toViewBottom:self.searchBar];
    [AutoLayout leadingConstraintFrom:self.tableView toView:self.view];
    [AutoLayout trailingConstraintFrom:self.tableView toView:self.view];
    [AutoLayout bottomConstraintFrom:self.tableView toView:self.view];
    
    self.tableView.estimatedRowHeight = 50;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}

-(void)setupSearchBar{
    
    self.searchBar = [[UISearchBar alloc]init];
    [self.view addSubview:self.searchBar];
    [self.searchBar setTranslatesAutoresizingMaskIntoConstraints:NO];

    [AutoLayout height:40 forView:self.searchBar];
    [AutoLayout leadingConstraintFrom:self.searchBar toView:self.view];
    [AutoLayout trailingConstraintFrom:self.searchBar toView:self.view];
    [AutoLayout offset:0 fromViewTop:self.searchBar toViewBottom:self.topLayoutGuide];
    
}

-(NSArray *)allReservations{
    
    if(!_allReservations){
        
        AppDelegate *appDelegate        = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
        
        NSFetchRequest *request         = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];
        
        NSError *fetchError;
        
        NSArray *reservations           = [context executeFetchRequest:request error:&fetchError];
        
        if(fetchError){
            NSLog(@"There was an error fetching reservations from core data.");
        }
        
        _allReservations                = reservations;
    }
    return _allReservations;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (isSearching) {
        return self.filteredReservations.count;
    }
    else {
        return self.allReservations.count;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell     = [tableView dequeueReusableCellWithIdentifier:@"Reservation" forIndexPath:indexPath];
    
    Reservation *reservation;
    if (self.filteredReservations == nil) {
        reservation = self.allReservations[indexPath.row];
    } else {
        reservation = self.filteredReservations[indexPath.row];
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@ has reserved Room: %i at %@ from %@ to %@", reservation.guest.firstName, reservation.guest.lastName, reservation.room.number, reservation.room.hotel.name, [dateFormatter stringFromDate: reservation.startDate], [dateFormatter stringFromDate: reservation.endDate]];
    
    cell.textLabel.numberOfLines = 0;
    return cell;
}

#pragma mark - UISearchBar

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    [searchBar setShowsCancelButton:YES animated:NO];
    
    isSearching = YES;
    
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

    isSearching = YES;
    
    if ([searchText isEqualToString:@""]) {
        
        isSearching = NO;
        
        self.filteredReservations = nil;
    } else {
        
        self.filteredReservations = [[NSMutableArray alloc]init];
        
        self.filteredReservations = [[self.allReservations filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"guest.firstName CONTAINS %@ OR guest.lastName CONTAINS %@", searchText, searchText]]mutableCopy];
    }
    [self.tableView reloadData];
}


-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    searchBar.text = @"";
    
    self.filteredReservations = nil;
    
    [self.tableView reloadData];
    
    [self resignFirstResponder];
    
    isSearching = NO;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if (searchBar.text != nil) {
        
        [self dismissKeyboard];
        
        self.filteredReservations = [[NSMutableArray alloc]init];
        
        self.filteredReservations = [[self.allReservations filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"guest.firstName CONTAINS %@ OR guest.lastName CONTAINS %@", searchBar.text, searchBar.text]] mutableCopy];
    }
    
    isSearching = NO;
}

@end
