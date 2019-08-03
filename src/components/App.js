import React, { Component } from "react";
import { Route } from "react-router-dom";
import axios from "axios";
import jwtDecode from "jwt-decode";
import api from "../api";
import HomePage from "./HomePage";
import TopNavigation from "./TopNavigation";
import AboutMe from "./AboutMe";
import GamesPage from "./GamesPage";
import ShowGamePage from "./ShowGamePage";
import SignupPage from "./SignupPage";
import LoginPage from "./LoginPage.js";
import ModalPage from "./ModalPage";
import ShoppingCart from "./ShoppingCart";
import UserRoute from "./UserRoute";

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
      _id: null,
      token: null,
      role: "user"
    },
    message: "",
    modalIsOpen: true
  };

  componentDidMount() {
    if (localStorage.bgshopToken) {
      this.setState({
        user: {
          _id: jwtDecode(localStorage.bgshopToken).user._id,
          token: localStorage.bgshopToken,
          role: jwtDecode(localStorage.bgshopToken).user.role
        }
      });
      setAuthorizationHeader(localStorage.bgshopToken);
    }
  }

  setMessage = message => this.setState({ message });

  logout = () => {
    this.setState({ user: { _id: null, token: null, role: "user" } });
    setAuthorizationHeader();
    localStorage.removeItem("bgshopToken");
  };
  login = token => {
    this.setState({
      user: {
        _id: jwtDecode(token).user._id,
        token,
        role: jwtDecode(token).user.role
      }
    });
    localStorage.bgshopToken = token;
    setAuthorizationHeader(token);
  };

  closeModal = () => this.setState({ modalIsOpen: false });

  addToCart = ({ user, game }) => {
    api.users.addToCart({ user, game });
  };

  render() {
    const { modalIsOpen } = this.state;
    return (
      <div className="ui container">
        <TopNavigation
          isAuthenticated={!!this.state.user.token}
          logout={this.logout}
          isAdmin={!!this.state.user.token && this.state.user.role === "admin"}
          user={this.state.user}
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
        <Route path="/me" exact component={AboutMe} />
        <Route
          path="/games"
          render={props => (
            <GamesPage
              {...props}
              user={this.state.user}
              addToCart={this.addToCart}
            />
          )}
        />
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
        <UserRoute
          path="/cart/:_id"
          user={this.state.user}
          render={props => (
            <ShoppingCart
              {...props}
              user={this.state.user}
              addToCart={this.addToCart}
            />
          )}
        />
        <Route path="/game/:_id" exact component={ShowGamePage} />
        <ModalPage open={modalIsOpen} onClose={this.closeModal} />
      </div>
    );
  }
}

export default App;
