import React from "react";
import PropTypes from "prop-types";
import ShoppingCartItem from "./ShoppingCartItem";

const ShoppingCart = ({ user }) => (
  <div className="doubling stackable four cards ui grid container">
    {user.cart.length === 0 ? (
      <div className="ui icon message">
        <i className="icon info" />
        <div className="content">
          <div className="header">There are no games in your cart!</div>
          <p>You should add some!</p>
        </div>
      </div>
    ) : (
      user.cart.map(game => (
        <ShoppingCartItem
          game={game}
          key={game._id}
          gameID={game._id}
          user={user}
        />
      ))
    )}
  </div>
);

ShoppingCart.propTypes = {
  user: PropTypes.shape({
    _id: PropTypes.string,
    token: PropTypes.string,
    role: PropTypes.string.isRequired
  }).isRequired
};

export default ShoppingCart;
