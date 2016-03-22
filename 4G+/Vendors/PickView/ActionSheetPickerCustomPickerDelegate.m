//
//  ActionSheetPickerCustomPickerDelegate.m
//  ActionSheetPicker
//
//  Created by  on 13/03/2012.
//  Copyright (c) 2012 Club 15CC. All rights reserved.
//

#import "ActionSheetPickerCustomPickerDelegate.h"

@implementation ActionSheetPickerCustomPickerDelegate

//- (id)init
//{
//    if (self = [super init]) {
//        
//        NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city_province.json" ofType:nil]];
//        _provinces = [NSJSONSerialization JSONObjectWithData:data
//                                                      options:NSJSONReadingAllowFragments
//                                                        error:nil];
//        _cities = [[_provinces objectAtIndex:0] objectForKey:@"cityList"];
//    }
//    return self;
//}

- (id)initwithProvince:(NSString *)tProvince andCity:(NSString *)tCity isRegisterType:(BOOL)isRegisterVC{
    
//    provinces = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ProvincesAndCities.plist" ofType:nil]];
    
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:isRegisterVC ? @"city_province_register.json" : @"city_province.json" ofType:nil]];
    _provinces = [NSJSONSerialization JSONObjectWithData:data
                                                options:NSJSONReadingAllowFragments
                                                  error:nil];
    
    BOOL existInJson = NO;
    for(int index=0;index < _provinces.count;index++){
        
        NSDictionary *dicP = _provinces[index];
        
        if([tProvince isEqualToString:[dicP objectForKey:@"name"]]) {
            
            _pIndex = index;
            
            NSArray *citys = [dicP objectForKey:@"cityList"];
            
            for(int indexC=0;indexC<citys.count;indexC++) {
                
                NSDictionary *dicC = citys[indexC];
                
                if([tCity isEqualToString:[dicC objectForKey:@"name"]]) {
                    _cIndex = indexC;
                    existInJson = YES;
                    break;
                }
            }
            
            if (existInJson == YES) {
                break;
            }
        }
    }
    
    _cities = [[_provinces objectAtIndex:_pIndex] objectForKey:@"cityList"];
    return self;
    
}

/////////////////////////////////////////////////////////////////////////
#pragma mark - ActionSheetCustomPickerDelegate Optional's
/////////////////////////////////////////////////////////////////////////
- (void)configurePickerView:(UIPickerView *)pickerView
{
    // Override default and hide selection indicator
    pickerView.showsSelectionIndicator = NO;
}

- (void)actionSheetPickerDidSucceed:(AbstractActionSheetPicker *)actionSheetPicker origin:(id)origin
{
    if (nil != _delegate && [_delegate respondsToSelector:@selector(theCitySelect:andCity:andOriginArr:)])
    {
        [_delegate theCitySelect:_pIndex andCity:_cIndex andOriginArr:_provinces];
    }
}

/////////////////////////////////////////////////////////////////////////
#pragma mark - UIPickerViewDataSource Implementation
/////////////////////////////////////////////////////////////////////////

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [_provinces count];
            break;
        case 1:
            return [_cities count];
            break;
        default:
            return 0;
            break;
    }
}

/////////////////////////////////////////////////////////////////////////
#pragma mark UIPickerViewDelegate Implementation
/////////////////////////////////////////////////////////////////////////

//// returns width of column and height of row for each component.
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
//{
//    switch (component) {
//        case 0: return 60.0f;
//        case 1: return 260.0f;
//        default:break;
//    }
//
//    return 0;
//}
/*- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
 {
 return
 }
 */
// these methods return either a plain UIString, or a view (e.g UILabel) to display the row for the component.
// for the view versions, we cache any hidden and thus unused views and pass them back for reuse.
// If you return back a different object, the old one will be released. the view will be centered in the row rect
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [[_provinces objectAtIndex:row] objectForKey:@"name"];
            break;
        case 1:
            return [[_cities objectAtIndex:row] objectForKey:@"name"];
            break;
        default:
            return nil;
            break;
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            _cities = [[_provinces objectAtIndex:row] objectForKey:@"cityList"];
            [pickerView selectRow:0 inComponent:1 animated:NO];
            [pickerView reloadComponent:1];
            _pIndex = row;
            _cIndex = 0;
            
            break;
        case 1:
            _cIndex = row;
            break;
        default:
            break;
    }
}


@end
