import React from "react";

import { lazy } from "react";
import Loadable from "ui-component/Loadable";

import MainLayout from "../layout/MainLayout/MainLayout";
import DetailBooking from "views/utilities/HistoryBookingDetail/DetailBooking";
import Map from "views/utilities/HistoryBookingDetail/Map";

const MyProfile = Loadable(lazy(() => import("views/account/MyProfile")));
const UtilsBooking = Loadable(
  lazy(() => import("views/utilities/Booking/Booking"))
);
const UtilsHistoryBooking = Loadable(
  lazy(() => import("views/utilities/HistoryBookingList/HistoryBooking"))
);
const DashboardHome = Loadable(
  lazy(() => import("views/dashboard/DashboardHome"))
);

const MainRoutes = {
  path: "/",
  element: <MainLayout />,
  children: [
    {
      path: "my-profile",
      element: <MyProfile />,
    },
    {
      path: "dashboard",
      children: [
        {
          path: "home",
          element: <DashboardHome />,
        },
      ],
    },
    {
      path: "utils",
      children: [
        {
          path: "booking",
          element: <UtilsBooking />,
        },
        {
          path: "history-booking/:id",
          element: <DetailBooking />,
        },

        {
          path: "history-booking",
          element: <UtilsHistoryBooking />,
        },
        {
          path: "map",
          element: <Map />,
        },
      ],
    },
  ],
};

export default MainRoutes;
