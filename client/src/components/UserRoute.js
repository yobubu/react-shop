import React from "react";
import { Route, Redirect } from "react-router-dom";

const UserRoute = ({ user, render, ...rest }) => (
  <Route
    {...rest}
    render={props =>
      user.token && user.role === "user" ? render(props) : <Redirect to="/" />
    }
  />
);

export default UserRoute;
