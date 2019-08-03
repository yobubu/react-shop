/* eslint-disable jsx-a11y/anchor-is-valid */
import React from "react";
import PropTypes from "prop-types";
import { Link } from "react-router-dom";

class ShoppingCartItem extends React.Component {
  render() {
    const { game, user, addToCart } = this.props;

    const addToCartButton = (
      <a
        className="mini ui green basic right floated button"
        data-tooltip="Finally working :)"
        onClick={() => addToCart({ user, game })}
      >
        Add to Cart
      </a>
    );
    return (
      <div className="ui item">
        <img
          className="mini ui avatar image"
          src={game.thumbnail}
          alt="Game cover"
        />
        <div className="ui content container">
          <Link to={`/game/${game._id}`}>{game.name}</Link>

          {/* {user.token && user.role === "user" && addToCartButton} */}
        </div>
      </div>
    );
  }
}

ShoppingCartItem.propTypes = {
  game: PropTypes.shape({
    name: PropTypes.string.isRequired,
    thumbnail: PropTypes.string.isRequired,
    players: PropTypes.string.isRequired,
    price: PropTypes.number.isRequired,
    duration: PropTypes.number.isRequired,
    featured: PropTypes.bool.isRequired,
    description: PropTypes.string.isRequired
  }).isRequired,
  user: PropTypes.shape({
    token: PropTypes.string,
    role: PropTypes.string.isRequired
  }).isRequired
};

export default ShoppingCartItem;
