import React from "react";
import GameCard from "./GameCard";
import PropTypes from "prop-types";

const GamesList = ({
  games,
  toggleFeatured,
  descriptionToggle,
  user,
  deleteGame
}) => (
  <div className="ui four cards stackable grid">
    {games.length === 0 ? (
      <div className="ui icon message">
        <i className="icon info" />
        <div className="content">
          <div className="header">There are no games in your store!</div>
          <p>You should add some!</p>
        </div>
      </div>
    ) : (
      games.map(game => (
        <GameCard
          game={game}
          key={game._id}
          toggleFeatured={toggleFeatured}
          descriptionToggle={descriptionToggle}
          gameID={game._id}
          deleteGame={deleteGame}
          user={user}
        />
      ))
    )}
  </div>
);

GamesList.propTypes = {
  games: PropTypes.arrayOf(PropTypes.object).isRequired,
  toggleFeatured: PropTypes.func.isRequired,
  deleteGame: PropTypes.func.isRequired,
  user: PropTypes.shape({
    token: PropTypes.string,
    role: PropTypes.string.isRequired
  }).isRequired
};
GamesList.defaultProps = {
  games: []
};

export default GamesList;
