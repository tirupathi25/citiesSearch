//
//  LocationViewController.m
//  SearchCities
//
//  Created by Tirupathi Mandali on 1/26/19.
//  Copyright © 2019 Tirupathi Mandali. All rights reserved.
//

#import "LocationViewController.h"
#import <MapKit/MapKit.h>
@interface LocationViewController ()<MKMapViewDelegate>

@end

@implementation LocationViewController
{
    MKMapView *mapView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //mapview initialize
    mapView = [MKMapView new];
    mapView.showsUserLocation = YES;
    mapView.delegate = self;
    mapView.translatesAutoresizingMaskIntoConstraints = NO;

    
    self.title = [NSString stringWithFormat:@"%@, %@",[self.selectedCityAddress objectForKey:@"name"],[self.selectedCityAddress objectForKey:@"country"]];
    
    
    //create annotation to show selected city
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = CLLocationCoordinate2DMake([[[self.selectedCityAddress objectForKey:@"coord"] objectForKey:@"lat"] doubleValue], [[[self.selectedCityAddress objectForKey:@"coord"] objectForKey:@"lon"] doubleValue]);
    point.title = [NSString stringWithFormat:@"%@, %@",[self.selectedCityAddress objectForKey:@"name"],[self.selectedCityAddress objectForKey:@"country"]];
    
    [mapView addAnnotation:point];
    
    //CenterCoordinate to mapview
    [mapView setCenterCoordinate:CLLocationCoordinate2DMake([[[self.selectedCityAddress objectForKey:@"coord"] objectForKey:@"lat"] doubleValue], [[[self.selectedCityAddress objectForKey:@"coord"] objectForKey:@"lon"] doubleValue]) animated:YES];
    
    [self.view addSubview:mapView];
    
    //constraints for mapview
    NSDictionary *views = NSDictionaryOfVariableBindings(mapView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:
                               @"H:|[mapView]|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:
                               @"V:|-50-[mapView]|" options:0 metrics:nil views:views]];
    
    //navigation bar left button
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(handleGoBack)];
    
}
//method to close view
-(void)handleGoBack{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
