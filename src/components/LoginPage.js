import React, { Component } from "react";
import LoginForm from "./LoginForm";
import api from "../api";

export default class LoginPage extends Component {
  submit = data => api.users.login(data).then(token => console.log(token));
  render() {
    return (
      <div className="ui segment">
        <LoginForm submit={this.submit} />
      </div>
    );
  }
}
