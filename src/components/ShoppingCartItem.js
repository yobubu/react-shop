/* eslint-disable jsx-a11y/anchor-is-valid */
import React from "react";
import PropTypes from "prop-types";
import { Link } from "react-router-dom";

class GameCard extends React.Component {
  state = {
    showConfirmation: false
  };

  showConfirmation = () => this.setState({ showConfirmation: true });
  hideConfirmation = () => this.setState({ showConfirmation: false });

  render() {
    const { game, user, addToCart } = this.props;

    const addToCartButton = (
      <div className="extra content">
        <a
          className="ui green basic button"
          data-tooltip="Coming up soon :)"
          onClick={() => addToCart({ user, game })}
        >
          Add to Cart
        </a>
      </div>
    );
    return (
      <div className="ui card">
        <div className="image">
          <img src={game.thumbnail} alt="Game cover" />
        </div>

        <div className="content">
          <Link to={`/game/${game._id}`} className="header">
            {game.name}
          </Link>
          <i className="icon users" /> {game.players}&nbsp;
          <i className="icon wait" /> {game.duration} min.
          <span className="right floated">
            <Link to={`/game/${game._id}`}>
              <i className="eye icon" />
            </Link>
          </span>
        </div>
        {user.token && user.role === "user" && addToCartButton}
      </div>
    );
  }
}

GameCard.propTypes = {
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

export default GameCard;
