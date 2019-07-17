import React, { Component } from "react";
import { Route } from "react-router-dom";
import HomePage from "./HomePage";
import TopNavigation from "./TopNavigation";

class App extends Component {
  render() {
    return (
      <div className="ui container">
        <TopNavigation />

        <Route path="/" exact component={HomePage} />
      </div>
    );
  }
}

export default App;
