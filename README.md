# React Native MapBox performance issues
This project illustrates the performance issue with the UserLocation component when the CLLocationManager is used 
to track location updates in background.

With this example we've seen the CPU spike from 80% usage while the app is in foreground to 160% usage when the app is in background.


## Project Contents
1. App.js - Sample usage of react-native-mapbox-gl with user location
2. AppDelegate.m - CLLocationManager is used to log the location while the app is in background.
