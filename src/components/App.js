import React, { Component } from "react";
import { Route } from "react-router-dom";
import axios from "axios";
import HomePage from "./HomePage";
import TopNavigation from "./TopNavigation";
import GamesPage from "./GamesPage";
import ShowGamePage from "./ShowGamePage";
import SignupPage from "./SignupPage.js";
import LoginPage from "./LoginPage.js";

const setAuthorizationHeader = (token = null) => {
  if (token) {
    axios.defaults.headers.common.Authorization = `Bearer ${token}`;
  } else {
    delete axios.defaults.headers.common.Authorization;
  }
};
class App extends Component {
  state = {
    user: {
      token: null
    },
    message: ""
  };

  componentDidMount() {
    if (localStorage.bgshopToken) {
      this.setState({ user: { token: localStorage.bgshopToken } });
      setAuthorizationHeader(localStorage.bgshopToken);
    }
  }

  setMessage = message => this.setState({ message });

  logout = () => {
    this.setState({ user: { token: null } });
    setAuthorizationHeader();
    localStorage.removeItem("bgshopToken");
  };
  login = token => {
    this.setState({ user: { token } });
    localStorage.bgshopToken = token;
    setAuthorizationHeader(token);
  };
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
        <Route
          path="/login"
          render={props => <LoginPage {...props} login={this.login} />}
        />
        <Route path="/game/:_id" exact component={ShowGamePage} />
      </div>
    );
  }
}

export default App;
