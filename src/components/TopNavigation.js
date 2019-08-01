/* eslint-disable jsx-a11y/anchor-is-valid */
import React from "react";
import PropTypes from "prop-types";

import { NavLink } from "react-router-dom";

const TopNavigation = ({ isAuthenticated, logout, isAdmin }) => (
  <div className="ui secondary pointing menu">
    <NavLink exact to="/" className="item">
      Main
    </NavLink>
    <NavLink exact to="/me" className="item">
      Hire me
    </NavLink>
    <NavLink exact to="/games" className="item">
      Games
    </NavLink>
    {isAdmin && (
      <NavLink exact to="/games/new" className="item">
        <i className="icon plus" />
        Add New Game
      </NavLink>
    )}
    {isAuthenticated ? (
      <div className="right menu">
        <NavLink exact to="/cart" className="item">
          <i className="icon shopping cart" />
        </NavLink>
        <a onClick={logout} className="item">
          Logout
        </a>
      </div>
    ) : (
      <div className="right menu">
        <NavLink to="/signup" className="item">
          Sign up
        </NavLink>
        <NavLink to="/login" className="item">
          Login
        </NavLink>
      </div>
    )}
  </div>
);

TopNavigation.propTypes = {
  isAuthenticated: PropTypes.bool.isRequired,
  isAdmin: PropTypes.bool.isRequired,
  logout: PropTypes.func.isRequired
};

export default TopNavigation;
