import React from "react";
import GameCard from "./GameCard";
import PropTypes from "prop-types";

const GamesList = ({ games }) => (
  <div className="ui four cards">
    {games.map(game => (
      <GameCard game={game} key={game._id} />
    ))}
  </div>
);

GamesList.propTypes = {
  games: PropTypes.arrayOf(PropTypes.object).isRequired
};

export default GamesList;
