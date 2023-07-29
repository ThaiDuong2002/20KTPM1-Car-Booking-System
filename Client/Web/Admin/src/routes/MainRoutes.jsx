import React from "react";
import { lazy } from "react";

import MainLayout from "../layout/MainLayout/MainLayout";
import Loadable from "ui-component/Loadable";

//utilities routing
const UtilsCustomer = Loadable(
  lazy(() => import("../views/utilities/Customer"))
);
const UtilsDriver = Loadable(lazy(() => import("../views/utilities/Driver")));
const UtilsConsultant = Loadable(
  lazy(() => import("../views/utilities/Consultant"))
);

const MainRoutes = {
  path: "/",
  element: <MainLayout />,
  children: [
    {
      path: "utils",
      children: [
        {
          path: "customer",
          element: <UtilsCustomer />,
        },
      ],
    },
    {
      path: "utils",
      children: [
        {
          path: "driver",
          element: <UtilsDriver />,
        },
      ],
    },
    {
      path: "utils",
      children: [
        {
          path: "consultant",
          element: <UtilsConsultant />,
        },
      ],
    },
  ],
};

export default MainRoutes;
