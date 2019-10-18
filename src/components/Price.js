import React from "react";

const Price = ({ cents }) => (
  <span>
    ${cents / 100} {cents < 3000 && "!"}
  </span>
);

export default Price;
