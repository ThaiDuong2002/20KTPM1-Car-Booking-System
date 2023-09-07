import React from "react";
import { useLocation } from "react-router-dom";
import { useMemo } from "react";

import {
  GoogleMap,
  useLoadScript,
  Marker,
  useJsApiLoader,
} from "@react-google-maps/api";

import { Typography } from "@mui/material";

const Map = () => {
  const location = useLocation();
  const { state: booking } = location;
  const bookingInfo = booking;

  //   // Sử dụng các props được truyền vào từ trang hiện tại
  //   console.log("prop1:", bookingInfo);

  const center = {
    lat: -34.397,
    lng: 150.644,
  };

  const { isLoaded } = useLoadScript({
    googleMapsApiKey: "AIzaSyCMLT-TdypxBr0EYYuEvVIQTt1-zBWoQWg",
  });

  if (!isLoaded) return <div>Loading...</div>;
  return <MapDisplay />;
};

function MapDisplay() {
  const center = useMemo(() => ({ lat: 44, lng: -80 }), []);

  return (
    <GoogleMap zoom={10} center={center} mapContainerClassName="map-container">
      <Marker position={center} />
    </GoogleMap>
  );
}

export default Map;
