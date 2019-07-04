import React from "react";
import PropTypes from "prop-types";

const Featured = ({ featured, toggleFeatured, gameID }) => (
  <span>
    {featured ? (
      <a
        onClick={() => toggleFeatured(gameID)}
        className="ui right yellow corner label"
      >
        <i className="star icon" />
      </a>
    ) : (
      <a
        onClick={() => toggleFeatured(gameID)}
        className="ui right corner label"
      >
        <i className="empty star icon" />
      </a>
    )}
  </span>
);

Featured.propTypes = {
  featured: PropTypes.bool.isRequired,
  toggleFeatured: PropTypes.func.isRequired,
  gameID: PropTypes.number.isRequired
};

export default Featured;
