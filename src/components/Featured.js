import React from "react";
import PropTypes from "prop-types";

const Featured = ({ featured }) => (
  <span>
    {featured ? (
      <a class="ui right yellow corner label">
        <i class="star icon" />
      </a>
    ) : (
      <a class="ui right corner label">
        <i class="empty star icon" />
      </a>
    )}
  </span>
);

Featured.propTypes = {
  featured: PropTypes.bool.isRequired
};

export default Featured;
