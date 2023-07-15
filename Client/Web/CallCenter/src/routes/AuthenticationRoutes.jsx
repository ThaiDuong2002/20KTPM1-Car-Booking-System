import React from "react";

//Project import
import Loadable from "ui-component/Loadable";
import AnthenLayout from "../layout/AuthenLayout/AuthenLayout";
import { lazy } from "react";

// login option  routing
const AuthLogin3 = Loadable(
  lazy(() => import("../views/pages/authentication/authentication3/Login3"))
);

const AuthenRoutes = {
  path: "/",
  element: <AnthenLayout />,
  children: [
    {
      path: "/pages/login/login3",
      element: <AuthLogin3 />,
    },
    {
      path: "/pages/register/register3",
      element: "",
    },
  ],
};

export default AuthenRoutes;
