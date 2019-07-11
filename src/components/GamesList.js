import React from "react";
import GameCard from "./GameCard";
import PropTypes from "prop-types";

const GamesList = ({
  games,
  toggleFeatured,
  descriptionToggle,
  editGame,
  deleteGame
}) => (
  <div className="ui four cards">
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
          editGame={editGame}
          deleteGame={deleteGame}
        />
      ))
    )}
  </div>
);

GamesList.propTypes = {
  games: PropTypes.arrayOf(PropTypes.object).isRequired,
  toggleFeatured: PropTypes.func.isRequired,
  descriptionToggle: PropTypes.func.isRequired,
  editGame: PropTypes.func.isRequired,
  deleteGame: PropTypes.func.isRequired
};
GamesList.defaultProps = {
  games: []
};

export default GamesList;
