import React, { Component } from "react";
import { Route } from "react-router-dom";
import HomePage from "./HomePage";
import TopNavigation from "./TopNavigation";
import GamesPage from "./GamesPage";
import ShowGamePage from "./ShowGamePage";
import SignupPage from "./SignupPage.js";
import LoginPage from "./LoginPage.js";

class App extends Component {
  state = {
    user: {
      token: null
    },
    message: ""
  };

  setMessage = message => this.setState({ message });

  logout = () => this.setState({ user: { token: null } });
  render() {
    return (
      <div className="ui container">
        <TopNavigation
          isAuthenticated={!!this.state.user.token}
          logout={this.logout}
        />

        {this.state.message && (
          <div className="ui info message">
            <i
              className="close icon"
              onClick={() => this.setState({ message: "" })}
            />
            {this.state.message}
          </div>
        )}

        <Route path="/" exact component={HomePage} />
        <Route path="/games" component={GamesPage} />
        <Route
          path="/signup"
          render={props => (
            <SignupPage {...props} setMessage={this.setMessage} />
          )}
        />
        <Route path="/login" component={LoginPage} />
        <Route path="/game/:_id" exact component={ShowGamePage} />
      </div>
    );
  }
}

export default App;
