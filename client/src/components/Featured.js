/* eslint-disable jsx-a11y/anchor-is-valid */
import React from "react";
import PropTypes from "prop-types";

const Featured = ({ featured, toggleFeatured, gameID }) => (
  <span>
    {featured ? (
      <a
        onClick={() => toggleFeatured(gameID)}
        className="ui right yellow corner label"
      >
        <i className="heart icon" />
      </a>
    ) : (
      <a
        onClick={() => toggleFeatured(gameID)}
        className="ui right corner label"
      >
        <i className="heart outline icon" />
      </a>
    )}
  </span>
);

Featured.propTypes = {
  featured: PropTypes.bool.isRequired,
  toggleFeatured: PropTypes.func.isRequired,
  gameID: PropTypes.string.isRequired
};

export default Featured;
