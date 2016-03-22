//
//  GeocodeDemoViewController.h
//  BaiduMapApiDemo
//
//  Copyright 2011 Baidu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import "BaseViewController.h"

@interface GeocodeDemoViewController : BaseViewController <BMKMapViewDelegate, BMKGeoCodeSearchDelegate> {
    
	IBOutlet BMKMapView *_mapView;
	BMKGeoCodeSearch* _geocodesearch;
}


@property (nonatomic,strong) NSString *lng;
@property (nonatomic,strong) NSString *lat;
@property (nonatomic,strong) NSString *address;

@end
