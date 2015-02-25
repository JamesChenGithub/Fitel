//
//  MKMapView+ZoomLevel.h
//  iLunch
//
//  Created by James on 14-11-17.
//  Copyright (c) 2014年 James Chen. All rights reserved.
//

#import <MapKit/MapKit.h>

#define kMKMapViewMaxZoomLevel 19
#define kMKMapViewMinZoomLevel 3

@interface MKMapView (ZoomLevel)

//@property (nonatomic, assign) NSUInteger zoomLevel;

- (void)setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate zoomLevel:(NSUInteger)zoomLevel animated:(BOOL)animated;

- (void)setZoomLevel:(NSUInteger)zoomLevel animated:(BOOL)animated;

- (void)setZoomLevel:(NSUInteger)zoomLevel;

@end
