/* eslint-disable jsx-a11y/anchor-is-valid */
import React from "react";
import PropTypes from "prop-types";
import Price from "./Price";
import Featured from "./Featured";
import { Link } from "react-router-dom";

class GameCard extends React.Component {
  state = {
    showConfirmation: false
  };

  showConfirmation = () => this.setState({ showConfirmation: true });
  hideConfirmation = () => this.setState({ showConfirmation: false });

  render() {
    const { game, toggleFeatured, deleteGame, user } = this.props;
    const adminActions = (
      <div className="extra content">
        {this.state.showConfirmation ? (
          <div className="ui two buttons">
            <a className="ui basic red button" onClick={() => deleteGame(game)}>
              <i className="ui icon check" />
              Yes
            </a>
            <a className="ui grey basic button" onClick={this.hideConfirmation}>
              <i className="ui icon close" />
              No
            </a>
          </div>
        ) : (
          <div className="ui two buttons">
            <Link
              to={`/games/edit/${game._id}`}
              className="ui basic green button"
            >
              <i className="ui icon edit" />
            </Link>
            <a className="ui red basic button" onClick={this.showConfirmation}>
              <i className="ui icon trash" />
            </a>
          </div>
        )}
      </div>
    );

    const addToCart = (
      <div className="extra content">
        <a className="ui green basic button">Add to Cart</a>
      </div>
    );
    return (
      <div className="ui card">
        <div className="image">
          <div className="ui green ribbon label">
            <Price cents={game.price} />
          </div>
          <Featured
            featured={game.featured}
            toggleFeatured={toggleFeatured}
            gameID={game._id}
          />
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
        {user.token && user.role === "user" && addToCart}
        {user.token && user.role === "admin" && adminActions}
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
  toggleFeatured: PropTypes.func.isRequired,
  deleteGame: PropTypes.func.isRequired,
  user: PropTypes.shape({
    token: PropTypes.string,
    role: PropTypes.string.isRequired
  }).isRequired
};

export default GameCard;
