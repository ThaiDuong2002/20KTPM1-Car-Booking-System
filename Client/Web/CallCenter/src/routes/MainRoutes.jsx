import React from "react";

import { lazy } from "react";
import Loadable from "ui-component/Loadable";

import MainLayout from "../layout/MainLayout/MainLayout";
import DetailBooking from "views/utilities/HistoryBookingDetail/DetailBooking";

const MyProfile = Loadable(lazy(() => import("views/account/MyProfile")));
const UtilsBooking = Loadable(
  lazy(() => import("views/utilities/Booking/Booking"))
);
const UtilsHistoryBooking = Loadable(
  lazy(() => import("views/utilities/HistoryBookingList/HistoryBooking"))
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
      ],
    },
  ],
};

export default MainRoutes;
