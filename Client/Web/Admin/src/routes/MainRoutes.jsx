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
const UtilsSalary = Loadable(lazy(() => import("../views/utilities/Salary")));
const UtilsUnitPrice = Loadable(
  lazy(() => import("../views/utilities/UnitPrice"))
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
    // {
    //   path: "utils",
    //   children: [
    //     {
    //       path: "salary",
    //       element: <UtilsSalary />,
    //     },
    //   ],
    // },
    {
      path: "utils",
      children: [
        {
          path: "unit-price",
          element: <UtilsUnitPrice />,
        },
      ],
    },
  ],
};

export default MainRoutes;
