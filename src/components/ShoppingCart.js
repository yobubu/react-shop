import React from "react";
import PropTypes from "prop-types";
import ShoppingCartItem from "./ShoppingCartItem";
import api from "../api";

class ShoppingCart extends React.Component {
  state = {
    cartItems: [],
    loading: true
  };

  componentDidMount() {
    api.users
      .fetchCart(this.props.match.params._id)
      .then(cart => this.setState({ cartItems: cart.cart, loading: false }));
  }

  render() {
    const { user, addToCart } = this.props;

    const FilteredCart = this.state.cartItems.filter(
      (s => ({ _id }) => !s.has(_id) && s.add(_id))(new Set())
    );

    return (
      <div className="doubling stackable four cards ui grid container">
        {this.state.cartItems.length === 0 ? (
          <div className="ui icon message">
            <i className="icon info" />
            <div className="content">
              <div className="header">There are no games in your cart!</div>
              <p>You should add some!</p>
            </div>
          </div>
        ) : (
          <div className="ui container">
            <h1>Your shopping cart</h1>
            <div className="ui large alligned animated divided list">
              {FilteredCart.map(game => (
                <ShoppingCartItem
                  game={game}
                  key={game._id}
                  user={user}
                  addToCart={addToCart}
                />
              ))}
            </div>
          </div>
        )}
      </div>
    );
  }
}

ShoppingCart.propTypes = {
  user: PropTypes.shape({
    _id: PropTypes.string,
    token: PropTypes.string,
    role: PropTypes.string.isRequired
  }).isRequired
};

export default ShoppingCart;
