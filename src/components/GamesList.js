import React from "react";
import GameCard from "./GameCard";
import PropTypes from "prop-types";

const GamesList = ({ games }) => (
  <div className="ui four cards">
    {games.length === 0 ? (
      <div class="ui icon message">
        <i class="icon info" />
        <div class="content">
          <div class="header">There are no games in your store!</div>
          <p>You should add some!</p>
        </div>
      </div>
    ) : (
      games.map(game => <GameCard game={game} key={game._id} />)
    )}
  </div>
);

GamesList.propTypes = {
  games: PropTypes.arrayOf(PropTypes.object).isRequired
};
GamesList.defaultProps = {
  games: []
};

export default GamesList;
