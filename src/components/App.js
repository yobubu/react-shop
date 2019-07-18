import React, { Component } from "react";
import { Route } from "react-router-dom";
import HomePage from "./HomePage";
import TopNavigation from "./TopNavigation";
import GamesPage from "./GamesPage";
import ShowGamePage from "./ShowGamePage";

class App extends Component {
  state = {
    user: {
      token: "dummy"
    }
  };

  logout = () => this.setState({ user: { token: null } });
  render() {
    return (
      <div className="ui container">
        <TopNavigation
          isAuthenticated={!!this.state.user.token}
          logout={this.logout}
        />

        <Route path="/" exact component={HomePage} />
        <Route path="/games" component={GamesPage} />
        <Route path="/game/:_id" exact component={ShowGamePage} />
      </div>
    );
  }
}

export default App;
