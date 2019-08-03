/* eslint-disable jsx-a11y/anchor-is-valid */
import React from "react";
import PropTypes from "prop-types";
import { Link } from "react-router-dom";

class ShoppingCartItem extends React.Component {
  state = {
    inCart: 1
  };

  decrementInCart = () => {
    this.setState({ inCart: this.state.inCart - 1 });
  };

  incrementInCart = () => {
    this.setState({ inCart: this.state.inCart + 1 });
  };

  render() {
    const { game, user } = this.props;

    return (
      <div className="ui item">
        <img
          className="mini ui avatar image"
          src={game.thumbnail}
          alt="Game cover"
        />
        <div className="ui content container">
          <Link to={`/game/${game._id}`}>{game.name}</Link>
          <div className="right floated">
            <button
              className="circular ui button"
              onClick={this.decrementInCart}
            >
              -
            </button>
            {this.state.inCart}
            <button
              className="circular ui button"
              onClick={this.incrementInCart}
            >
              +
            </button>
          </div>
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
