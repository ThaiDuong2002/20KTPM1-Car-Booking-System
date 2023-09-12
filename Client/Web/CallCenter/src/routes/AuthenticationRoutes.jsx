import React from "react";

//Project import
import Loadable from "ui-component/Loadable";
import AnthenLayout from "../layout/AuthenLayout/AuthenLayout";
import { lazy } from "react";

// login option  routing
const AuthLogin3 = Loadable(
  lazy(() => import("../views/pages/authentication/authentication3/Login3"))
);
const AuthRegister3 = Loadable(
  lazy(() => import("../views/pages/authentication/authentication3/Register3"))
);

const AuthenRoutes = {
  path: "/",
  element: <AnthenLayout />,
  children: [
    {
      path: "login",
      element: <AuthLogin3 />,
    },
    {
      path: "register",
      element: <AuthRegister3 />,
    },
  ],
};

export default AuthenRoutes;
