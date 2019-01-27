//
//  SearchCitiesViewContoller.m
//  SearchCities
//
//  Created by Tirupathi Mandali on 1/26/19.
//  Copyright © 2019 Tirupathi Mandali. All rights reserved.
//

#import "SearchCitiesViewContoller.h"
#import "LocationViewController.h"
#import "CitiesListCell.h"
@interface SearchCitiesViewContoller ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@end

@implementation SearchCitiesViewContoller
{
    UITableView *citiesTableview;
    UITextField *citySearchField;
    UILabel *titleLabel;
    NSArray *cities;
    NSMutableArray *filteredCitiesList;
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    //initialize filteredCitiesList
    filteredCitiesList = [NSMutableArray new];
    
    //view setup
    [self setupView];
    
    //get cities json file
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cities" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name"
                                                                 ascending:YES];
    //get sorted cities list
    cities = [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil] sortedArrayUsingDescriptors:@[descriptor]];
    
    [filteredCitiesList addObjectsFromArray:cities];
    
}
//Method for view setup
-(void)setupView{
    
    //Title label properties
    titleLabel = [UILabel new];
    titleLabel.text = @"Search Cities";
    titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    //city search field set properties
    citySearchField = [UITextField new];
    citySearchField.borderStyle = UITextBorderStyleNone;
    citySearchField.delegate = self;
    citySearchField.backgroundColor = [UIColor whiteColor];
    citySearchField.layer.borderColor = [UIColor grayColor].CGColor;
    citySearchField.layer.borderWidth = 1;
    citySearchField.layer.cornerRadius = 2;
    citySearchField.layer.shadowOffset = CGSizeMake(0.0, 3.0);
    citySearchField.layer.shadowRadius = 2.0;
    citySearchField.layer.shadowOpacity = 0.3;
    citySearchField.placeholder = @"Search your location..";
    citySearchField.autocorrectionType = UITextAutocorrectionTypeNo;
    citySearchField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    citySearchField.leftViewMode = UITextFieldViewModeAlways;
    citySearchField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    
    citiesTableview = [UITableView new];
    
    //tableview cell registration
    [citiesTableview registerClass:[CitiesListCell self] forCellReuseIdentifier:@"citycell"];
    citiesTableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    citiesTableview.translatesAutoresizingMaskIntoConstraints = NO;
    citySearchField.translatesAutoresizingMaskIntoConstraints = NO;
    
    citiesTableview.delegate = self;
    citiesTableview.dataSource = self;
    
    [self.view addSubview:titleLabel];
    [self.view addSubview:citySearchField];
    [self.view addSubview:citiesTableview];
    
    
    //set constraints for title label , search field and tableview
    NSDictionary *views =
    NSDictionaryOfVariableBindings(titleLabel,citySearchField,citiesTableview);
    
    //horizonal constraonts for title label
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:
                               @"H:|-10-[titleLabel]-10-|" options:0 metrics:nil views:views]];
    //horizonal constraonts for city search field
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:
                               @"H:|-10-[citySearchField]-10-|" options:0 metrics:nil views:views]];
    //horizonal constraonts for city list tableview
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:
                               @"H:|-10-[citiesTableview]-10-|" options:0 metrics:nil views:views]];
    //vertical constraints for title label , search field and tableview
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:
                               @"V:|-23-[titleLabel(50)]-10-[citySearchField(50)]-10-[citiesTableview]-10-|" options:0 metrics:nil views:views]];
}
#pragma UITextFieldDelegate methods

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
        NSString *searchText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    //Search criteria for cities
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(name BEGINSWITH[c] %@) OR (country BEGINSWITH[c] %@)", searchText,searchText];
    
        NSArray *resultSearch = [cities filteredArrayUsingPredicate:predicate];
        
        [filteredCitiesList removeAllObjects];
        [filteredCitiesList addObjectsFromArray:searchText.length != 0 ? resultSearch :cities];
    
    
        [citiesTableview reloadData];
    
    return YES;
}

-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view endEditing:YES];
        [textField resignFirstResponder];
    });
    [filteredCitiesList removeAllObjects];
    [filteredCitiesList addObjectsFromArray:cities];
    
    
    [citiesTableview reloadData];
    
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view endEditing:YES];
        [textField resignFirstResponder];
    });
    
    return YES;
}
#pragma UITableview Delegate methods and UITableData source methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return filteredCitiesList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CitiesListCell *cityCell = [tableView dequeueReusableCellWithIdentifier:@"citycell"];
    
    if (!cityCell) {
        cityCell = [[CitiesListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"citycell"];
    }
    NSDictionary *cityDict = [filteredCitiesList objectAtIndex:indexPath.row];
    cityCell.textLabel.text = [NSString stringWithFormat:@"%@, %@",[cityDict objectForKey:@"name"],[cityDict objectForKey:@"country"]];
    
    return cityCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *selectedCityObject = [filteredCitiesList objectAtIndex:indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //Navigate to location view
    LocationViewController *locationView = [LocationViewController new];
    locationView.selectedCityAddress = selectedCityObject;
    UINavigationController *naviCtr = [[UINavigationController alloc] initWithRootViewController:locationView];
    [self presentViewController:naviCtr animated:YES  completion:nil];
}
@end
