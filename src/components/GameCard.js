import React from "react";
import PropTypes from "prop-types";
import Price from "./price";
import Featured from "./Featured";

const GameCard = ({ game }) => (
  <div className="ui card">
    <div className="image">
      <Price cents={game.price} />
      <Featured featured={game.featured} />
      <img src={game.thumbnail} alt="Cover game " />
    </div>
    <div className="content">
      <a className="header">{game.name}</a>
      <i className="icon users" /> {game.players}&nbsp;
      <i className="icon wait" /> {game.duration} min.
    </div>
  </div>
);

GameCard.propTypes = {
  game: PropTypes.shape({
    name: PropTypes.string.isRequired,
    thumbnail: PropTypes.string.isRequired,
    players: PropTypes.string.isRequired,
    price: PropTypes.number.isRequired,
    duration: PropTypes.number.isRequired,
    featured: PropTypes.bool.isRequired
  }).isRequired
};

export default GameCard;
