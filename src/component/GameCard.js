import React from "react";

const GameCard = () => (
  <div className="ui card">
    <div className="image">
      <span className="ui green ribbon label">$32.99</span>
      <img
        src="https://image.ceneostatic.pl/data/products/43634209/i-rebel-quadropolis.jpg"
        alt="alternative"
      />
    </div>
    <div className="content">
      <a href="#" className="header">
        Quadropolis
      </a>
      <i className="icon users" /> 2-4&nbsp;
      <i className="icon wait" /> 60 min.
    </div>
  </div>
);

export default GameCard;
