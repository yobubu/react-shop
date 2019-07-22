import React, { Component } from "react";
import { Route } from "react-router-dom";
import axios from "axios";
import jwtDecode from "jwt-decode";
import { Button, Header, Image, Modal, times, Icon } from "semantic-ui-react";
import HomePage from "./HomePage";
import TopNavigation from "./TopNavigation";
import AboutMe from "./AboutMe";
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
      token: null,
      role: "user"
    },
    message: "",
    modalIsOpen: false
  };

  componentDidMount() {
    if (localStorage.bgshopToken) {
      this.setState({
        user: {
          token: localStorage.bgshopToken,
          role: jwtDecode(localStorage.bgshopToken).user.role
        }
      });
      setAuthorizationHeader(localStorage.bgshopToken);
      this.setState({
        modalIsOpen: true
      });
    }
  }
  componentWillMount() {}

  setMessage = message => this.setState({ message });

  logout = () => {
    this.setState({ user: { token: null, role: "user" } });
    setAuthorizationHeader();
    localStorage.removeItem("bgshopToken");
  };
  login = token => {
    this.setState({
      user: {
        token,
        role: jwtDecode(token).user.role
      },
      modal: null
    });
    localStorage.bgshopToken = token;
    setAuthorizationHeader(token);
  };

  closeModal = () => this.setState({ modalIsOpen: !this.state.modalIsOpen });

  render() {
    return (
      <div className="ui container">
        <TopNavigation
          isAuthenticated={!!this.state.user.token}
          logout={this.logout}
          isAdmin={!!this.state.user.token && this.state.user.role === "admin"}
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
          render={props => <GamesPage {...props} user={this.state.user} />}
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
        <Route path="/game/:_id" exact component={ShowGamePage} />
        <Modal open={this.state.modalIsOpen}>
          <Modal.Header>
            <span>Welcome!</span>
            <Button
              icon="times"
              floated="right"
              size="mini"
              onClick={this.closeModal}
            />
          </Modal.Header>

          <Modal.Content image>
            <Image
              wrapped
              size="medium"
              src="https://react.semantic-ui.com/images/avatar/large/rachel.png"
            />
            <Modal.Description>
              <Header>Default Profile Image</Header>
              <p>
                We've found the following gravatar image associated with your
                e-mail address.
              </p>
              <p>Is it okay to use this photo?</p>
              <Button onClick={this.closeModal}>Close Modal</Button>
            </Modal.Description>
          </Modal.Content>
        </Modal>
      </div>
    );
  }
}

export default App;
