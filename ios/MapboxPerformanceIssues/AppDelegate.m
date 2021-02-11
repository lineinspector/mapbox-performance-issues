#import "AppDelegate.h"

#import <React/RCTBridge.h>
#import <React/RCTBundleURLProvider.h>
#import <React/RCTRootView.h>

#ifdef FB_SONARKIT_ENABLED
#import <FlipperKit/FlipperClient.h>
#import <FlipperKitLayoutPlugin/FlipperKitLayoutPlugin.h>
#import <FlipperKitUserDefaultsPlugin/FKUserDefaultsPlugin.h>
#import <FlipperKitNetworkPlugin/FlipperKitNetworkPlugin.h>
#import <SKIOSNetworkPlugin/SKIOSNetworkAdapter.h>
#import <FlipperKitReactPlugin/FlipperKitReactPlugin.h>

static void InitializeFlipper(UIApplication *application) {
  FlipperClient *client = [FlipperClient sharedClient];
  SKDescriptorMapper *layoutDescriptorMapper = [[SKDescriptorMapper alloc] initWithDefaults];
  [client addPlugin:[[FlipperKitLayoutPlugin alloc] initWithRootNode:application withDescriptorMapper:layoutDescriptorMapper]];
  [client addPlugin:[[FKUserDefaultsPlugin alloc] initWithSuiteName:nil]];
  [client addPlugin:[FlipperKitReactPlugin new]];
  [client addPlugin:[[FlipperKitNetworkPlugin alloc] initWithNetworkAdapter:[SKIOSNetworkAdapter new]]];
  [client start];
}
#endif

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#ifdef FB_SONARKIT_ENABLED
  InitializeFlipper(application);
#endif

  RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];
  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge
                                                   moduleName:@"MapboxPerformanceIssues"
                                            initialProperties:nil];

  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];

  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view = rootView;
  self.window.rootViewController = rootViewController;
  [self.window makeKeyAndVisible];

  
  if ([CLLocationManager locationServicesEnabled]) {
    self.myLocationManger = [[CLLocationManager alloc] init];
    self.myLocationManger.delegate = self;
    self.myLocationManger.allowsBackgroundLocationUpdates = YES;
    [self.myLocationManger startUpdatingLocation];
  }else{
    //Location Services are available we will need software to ask to turn this On
    //The user is SOL if they refuse to turn on Location Services
    NSLog(@"Location Services not enabled");
}


  return YES;
}

 -(void)locationManager:(CLLocationManager *)manager
      didUpdateToLocation:(CLLocation *)newLocation
      fromLocation:(CLLocation *)oldLocation
  {
      //This method will show us that we recieved the new location
      NSLog(@"Latitude = %f",newLocation.coordinate.latitude );
      NSLog(@"Longitude =%f",newLocation.coordinate.longitude);

  }

  -(void)locationManager:(CLLocationManager *)manager
   didFinishDeferredUpdatesWithError:(NSError *)error{
      NSLog(@"Error with Updating");
  }



  -(void)locationManager:(CLLocationManager *)manager
  didFailWithError:(NSError *)error
  {
//Failed to recieve user's location
NSLog(@"failed to recived user's location");
  }

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

@end
