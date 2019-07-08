import React, { Component } from "react";

export default class GameForm extends Component {
  state = {
    name: "",
    description: "",
    price: 0,
    duration: 0,
    players: ""
  };

  handleSubmit = e => {
    e.preventDefault();
    console.log(this.state);
  };

  handleChange = e =>
    this.setState({
      [e.target.name]:
        e.target.type === "number"
          ? parseInt(e.target.value, 10)
          : e.target.value
    });

  render() {
    return (
      <form className="ui form" onSubmit={this.handleSubmit}>
        <div className="field">
          <label htmlFor="name">Game Title</label>
          <input
            type="text"
            id="name"
            name="name"
            placeholder="Full game title"
            value={this.state.name}
            onChange={this.handleChange}
          />
        </div>
        <div className="field">
          <label htmlFor="description">Game Description</label>
          <textarea
            type="text"
            id="description"
            name="description"
            placeholder="Full game title"
            value={this.state.description}
            onChange={this.handleChange}
          />
        </div>

        <div className="three fields">
          <div className="field">
            <label htmlFor="price">Price (in cents) </label>
            <input
              type="number"
              id="price"
              name="price"
              value={this.state.price}
              onChange={this.handleChange}
            />
          </div>
          <div className="field">
            <label htmlFor="duration">Duration (in minutes)</label>
            <input
              type="number"
              id="duration"
              name="duration"
              value={this.state.duration}
              onChange={this.handleChange}
            />
          </div>
          <div className="field">
            <label htmlFor="players">Number of players</label>
            <input
              type="text"
              id="players"
              name="players"
              value={this.state.players}
              onChange={this.handleChange}
            />
          </div>
        </div>

        <button className="ui button" type="submit">
          Create
        </button>
      </form>
    );
  }
}
