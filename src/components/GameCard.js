import React from "react";

const GameCard = ({ game }) => (
  <div className="ui card">
    <div className="image">
      <span className="ui green ribbon label">{game.price}</span>
      <img src={game.thumbnail} alt="Cover game " />
    </div>
    <div className="content">
      <a href="#" className="header">
        {game.name}
      </a>
      <i className="icon users" /> {game.players}&nbsp;
      <i className="icon wait" /> {game.duration} min.
    </div>
  </div>
);

export default GameCard;
