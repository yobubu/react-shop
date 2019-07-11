/* eslint-disable jsx-a11y/anchor-is-valid */
import React from "react";
import PropTypes from "prop-types";
import Price from "./price";
import Featured from "./Featured";

class GameCard extends React.Component {
  state = {
    showConfirmation: false
  };

  showConfirmation = () => this.setState({ showConfirmation: true });
  hideConfirmation = () => this.setState({ showConfirmation: false });

  render() {
    const {
      game,
      toggleFeatured,
      descriptionToggle,
      gameID,
      editGame,
      deleteGame
    } = this.props;
    return (
      <div className="ui card">
        {game.descriptionVisible ? (
          <div className="image">
            <Price cents={game.price} />
            <Featured
              featured={game.featured}
              toggleFeatured={toggleFeatured}
              gameID={game._id}
            />
            <img src={game.thumbnail} alt="Game cover" />
          </div>
        ) : (
          <span> {game.description} </span>
        )}

        <div className="content">
          <a className="header">{game.name}</a>
          <i className="icon users" /> {game.players}&nbsp;
          <i className="icon wait" /> {game.duration} min.
          <span className="right floated">
            <a onClick={() => descriptionToggle(gameID)}>
              <i className="eye icon" />
            </a>
          </span>
        </div>
        <div className="extra content">
          {this.state.showConfirmation ? (
            <div className="ui two buttons">
              <a
                className="ui basic red button"
                onClick={() => deleteGame(game)}
              >
                <i className="ui icon check" />
                Yes
              </a>
              <a
                className="ui grey basic button"
                onClick={this.hideConfirmation}
              >
                <i className="ui icon close" />
                No
              </a>
            </div>
          ) : (
            <div className="ui two buttons">
              <a
                className="ui basic green button"
                onClick={() => editGame(game)}
              >
                <i className="ui icon edit" />
              </a>
              <a
                className="ui red basic button"
                onClick={this.showConfirmation}
              >
                <i className="ui icon trash" />
              </a>
            </div>
          )}
        </div>
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
  descriptionToggle: PropTypes.func.isRequired,
  editGame: PropTypes.func.isRequired,
  deleteGame: PropTypes.func.isRequired
};

export default GameCard;
