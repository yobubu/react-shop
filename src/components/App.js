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
import ModalPhoto from "../media/img/modal.png";

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
    modalIsOpen: true
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
    }
  }

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

  closeModal = () => this.setState({ modalIsOpen: false });

  render() {
    const { modalIsOpen } = this.state;
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
        <Modal open={modalIsOpen} onClose={this.closeModal}>
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
            <Image wrapped size="medium" src={ModalPhoto} />
            <Modal.Description>
              <Header>Thank you for coming to my app</Header>
              <p>Please read first about the features implemented.</p>
              <p>Later try to find some good vibes for yourself :)</p>
              <p>
                I will answer all your question about my skills with pleasure so
                don't forget to contact me after that :)
              </p>
              <p floated="right">Paweł</p>
              <Button positive floated="right" onClick={this.closeModal}>
                Explore
              </Button>
            </Modal.Description>
          </Modal.Content>
        </Modal>
      </div>
    );
  }
}

export default App;
