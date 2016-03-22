//
//  GeocodeDemoViewController.mm
//  BaiduMapApiDemo
//
//  Copyright 2011 Baidu Inc. All rights reserved.
//

#import "GeocodeDemoViewController.h"
#import "BaseNavigationController.h"
#import <MapKit/MKMapView.h>

@interface GeocodeDemoViewController ()<BMKGeneralDelegate>
{
    bool isGeoSearch;
    float zoomLevel;
    
    UIButton *_zoomLaunch;
    UIButton *_zoomOut;
    NSString *_sendAddress;
}

@end



@implementation GeocodeDemoViewController


- (void)viewWillAppear:(BOOL)animated {

    [_mapView viewWillAppear];
    _mapView.delegate = self;       // 此处记得不用的时候需要置nil，否则影响内存的释放
    _geocodesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    
    [self onClickReverseGeocode];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;        // 不用时，置nil
    _geocodesearch.delegate = nil; // 不用时，置nil
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
	_geocodesearch = [[BMKGeoCodeSearch alloc]init];
    _zoomLaunch = [UIButton buttonWithType:UIButtonTypeCustom];
    _zoomLaunch.tag = 100;
    _zoomLaunch.frame = CGRectMake(Main_Screen_Width - 30 - 25, Main_Screen_Height-150, 30, 30);
    [_zoomLaunch setBackgroundImage:[UIImage imageNamed:@"map-big.png"] forState:UIControlStateNormal];
    [_zoomLaunch setBackgroundImage:[UIImage imageNamed:@"map-big-press.png"] forState:UIControlStateHighlighted];
    [_zoomLaunch addTarget:self action:@selector(zoomLevelClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_zoomLaunch];
    
    _zoomOut = [UIButton buttonWithType:UIButtonTypeCustom];
    _zoomOut.tag = 200;
    _zoomOut.frame = CGRectMake(Main_Screen_Width - 30 - 25, Main_Screen_Height-110, 30, 30);
    [_zoomOut setBackgroundImage:[UIImage imageNamed:@"map-small.png"] forState:UIControlStateNormal];
    [_zoomOut setBackgroundImage:[UIImage imageNamed:@"map-small-press.png"] forState:UIControlStateHighlighted];
    [_zoomOut addTarget:self action:@selector(zoomLevelClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_zoomOut];
    
    _mapView.mapType = BMKMapTypeStandard;
    _mapView.zoomLevel = 18;  //地图一开始放大的倍数
    
    //地图中心默认是登录进来的地区中心
    _mapView.centerCoordinate = (CLLocationCoordinate2D){[DataCenterManager.lat floatValue], [DataCenterManager.lng floatValue]};
}



- (void)zoomLevelClick:(UIButton *)btn
{
    zoomLevel = _mapView.zoomLevel;
    if (btn.tag == 100) {
        [_mapView zoomIn];
        zoomLevel ++;
        if (zoomLevel >= 19.0f) {
            _zoomLaunch.enabled = NO;
        }
        if (zoomLevel >= 1.0f) {
            _zoomOut.enabled = YES;
        }
    } else {
        [_mapView zoomOut];
        zoomLevel --;
        if (zoomLevel <= 18.0f) {
            _zoomLaunch.enabled = YES;
        }
        if (zoomLevel <= 3.0f) {
            _zoomOut.enabled = NO;
        }
    }
}

//根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{	
    NSString *AnnotationViewID = @"annotationViewID";
	//根据指定标识查找一个可被复用的标注View，一般在delegate中使用，用此函数来代替新申请一个View
    BMKAnnotationView *annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
		((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
		((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
    }
	
	annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
	annotationView.canShowCallout = TRUE;
    return annotationView;
}


- (void)onClickReverseGeocode
{
    isGeoSearch = false;
	CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
	if (_lat != nil && _lng != nil) {
		pt = (CLLocationCoordinate2D){[_lat floatValue], [_lng floatValue]};
	}
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}


- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    
    if (error == 0) {
        BMKPointAnnotation *item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = _address;
        
        [_mapView addAnnotation:item];
        _mapView.centerCoordinate = result.location;
        
        //标题和子标题自动显示
        [_mapView selectAnnotation:item animated:YES];
        
        
        NSString* titleStr;
        NSString* showmeg;
        titleStr = @"反向地理编码";
        showmeg = [NSString stringWithFormat:@"%@",item.title];
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:titleStr message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
        [myAlertView show];
    }
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    
    if (_geocodesearch != nil) {
        _geocodesearch = nil;
    }
    if (_mapView) {
        _mapView = nil;
    }
}

@end
