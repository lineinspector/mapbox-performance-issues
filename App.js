import React from 'react';
import {Text, View} from 'react-native';
import MapboxGL from '@react-native-mapbox-gl/maps';

import Bubble from './Bubble';

const styleMatchParent = {flex: 1};

class App extends React.Component {
  static propTypes = {};

  constructor(props) {
    super(props);

    this.state = {
      timestamp: 0,
      latitude: 0.0,
      longitude: 0.0,
      altitude: 0.0,
      heading: 0.0,
      accuracy: 0.0,
      speed: 0.0,
    };

    this.onUserLocationUpdate = this.onUserLocationUpdate.bind(this);
    MapboxGL.setAccessToken(
      'your key',
    );
  }

  onUserLocationUpdate(location) {
    if (!location) {
      return;
    }

    this.setState({
      timestamp: location.timestamp,
      latitude: location.coords.latitude,
      longitude: location.coords.longitude,
      altitude: location.coords.altitude,
      heading: location.coords.heading,
      accuracy: location.coords.accuracy,
      speed: location.coords.speed,
    });
  }

  onUserLocationPress () {

  }

  renderLocationInfo() {
    return (
      <Bubble>
        <Text>Timestamp: {this.state.timestamp}</Text>
        <Text>Latitude: {this.state.latitude}</Text>
        <Text>Longitude: {this.state.longitude}</Text>
        <Text>Altitude: {this.state.altitude}</Text>
        <Text>Heading: {this.state.heading}</Text>
        <Text>Accuracy: {this.state.accuracy}</Text>
        <Text>Speed: {this.state.speed}</Text>
      </Bubble>
    );
  }

  render() {
    return (
      <View style={styleMatchParent}>
        <MapboxGL.MapView style={styleMatchParent}>
        <MapboxGL.Camera
            zoomLevel={16}
            followUserMode={'normal'}
            followUserLocation
          />
          {/* */}
          <MapboxGL.UserLocation
            ref={(ref) => {
              this.userLocation = ref;
            }}
            onPress={this.onUserLocationPress}
            onUpdate={this.onUserLocationUpdate}
            visible={true}
            belowLayerID="placeholderlayer-userlocation"
            showsUserHeadingIndicator
            renderMode='native'
          /> 
        </MapboxGL.MapView>
        {this.renderLocationInfo()}
      </View>
    );
  }
}

export default App;
