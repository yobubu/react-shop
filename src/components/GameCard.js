/* eslint-disable jsx-a11y/anchor-is-valid */
import React from "react";
import PropTypes from "prop-types";
import Price from "./price";
import Featured from "./Featured";

const GameCard = ({ game, toggleFeatured, descriptionToggle, gameID }) => (
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
  </div>
);

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
  descriptionToggle: PropTypes.func.isRequired
};

export default GameCard;
