/* eslint-disable jsx-a11y/anchor-is-valid */
import React from "react";
import PropTypes from "prop-types";
import { Link } from "react-router-dom";

class ShoppingCartItem extends React.Component {
  state = {
    inCart: this.props.game.inCart
  };

  decrementInCart = () => {
    this.setState({ inCart: this.state.inCart - 1 });
  };

  incrementInCart = () => {
    this.setState({ inCart: this.state.inCart + 1 });
  };

  render() {
    const { game, user, removeFromCart } = this.props;

    return (
      <div className="ui item">
        <img
          className="tiny ui avatar image"
          src={game.thumbnail}
          alt="Game cover"
        />
        <div className="ui container">
          <Link to={`/game/${game._id}`}>{game.name}</Link>
          <div className="right floated">
            <i className="minus icon" onClick={this.decrementInCart} />
            {this.state.inCart}
            <i className="plus icon" onClick={this.incrementInCart} />
            <a
              className="ui red basic button"
              onClick={() => removeFromCart({ user, game })}
            >
              <i className="ui icon trash" />
            </a>
            <button>Update cart</button>
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
