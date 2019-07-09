import React, { Component } from "react";
import PropTypes from "prop-types"

const tags = [
  { _id: 1, name: "dice" },
  { _id: 2, name: "economic" },
  { _id: 3, name: "family" }
]

const genres = [
  { _id: 1, name: "abstract" },
  { _id: 2, name: "euro" },
  { _id: 3, name: "ameritrash" }
]

const publishers = [
  {
    _id: 1,
    name: "Days of Wonder"
  },
  {
    _id: 2,
    name: "Rio Grande Games"
  }
]

export default class GameForm extends Component {
  state = {
    name: "",
    description: "",
    price: 0,
    duration: 0,
    players: "",
    featured: false,
    tags: [],
    genres: 1,
    publisher: 0
  };

  handleSubmit = e => {
    e.preventDefault();
    console.log(this.state);
  };

  handleStringChange = e =>
    this.setState({
      [e.target.name]:
        e.target.value
    });

  handleNumberChange = e =>
    this.setState({
      [e.target.name]:
        e.target.type === "number"
          ? parseInt(e.target.value, 10)
          : e.target.value
    });

  handleCheckboxChange = e =>
    this.setState({
      [e.target.name]:
        e.target.checked
    });

  toggleTag = tag =>
    this.state.tags.includes(tag._id)
      ? this.setState({ tags: this.state.tags.filter(id => id !== tag._id) })
      : this.setState({ tags: [...this.state.tags, tag._id] })

  handleGenreChange = genre => this.setState({ genre: genre._id })

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
            onChange={this.handleStringChange}
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
            onChange={this.handleStringChange}
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
              onChange={this.handleNumberChange}
            />
          </div>
          <div className="field">
            <label htmlFor="duration">Duration (in minutes)</label>
            <input
              type="number"
              id="duration"
              name="duration"
              value={this.state.duration}
              onChange={this.handleNumberChange}
            />
          </div>
          <div className="field">
            <label htmlFor="players">Number of players</label>
            <input
              type="text"
              id="players"
              name="players"
              value={this.state.players}
              onChange={this.handleStringChange}
            />
          </div>
        </div>

        <div className="inline field">
          <input id="featured"
            name="featured"
            type="checkox"
            checked={this.state.featured}
            onChange={this.handleCheckboxChange} />
          <label htmlFor="featured">Featured?</label>
        </div>

        < div className="field">
          <label>Tags</label>
          {
            tags.map(tag => (
              <div key={tag._id} className="inline field">
                <input id={`tag-${tag._id}`}
                  type="checkbox"
                  checked={this.state.tags.includes(tag._id)}
                  onChange={() => this.toggleTag(tag)}
                />
                <label htmlFor={`tag-${tag._id}`}>{tag.name}</label>
              </div>
            )
            )
          }
        </div>

        <div className="field">
          <label>Genres</label>
          {
            genres.map(genre => (
              <div key={genre._id} className="inline field">
                <input
                  id={`genre-${genre._id}`}
                  type="radio"
                  checked={this.state.genre === genre._id}
                  onChange={() => this.handleGenreChange(genre)} />
                <label htmlFor={`genre-${genre._id}`}>{genre.name}</label>
              </div>
            ))
          }
        </div>

        <div className="field">
          <label>Publishers</label>
          <select
            name="publishers"
            value={this.state.publisher}
            onChange={this.handleNumberChange}>
            <option value="0">Choose Publisher</option>
            {this.props.publishers.map(publisher => (
              <option value={publisher._id} key={publishher._id}>
                {publisher.name}
              </option>
            ))}
          </select>
        </div>

        <button className="ui button" type="submit">
          Create
        </button>
      </form>
    );
  }
}

GameForm.propTypes = {
  publishers: PropTypes.arrayOf(PropTypes.shape({
    _id: PropTypes.number.isRequired,
    name: PropTypes.string.isRequired
  })).isRequired
}
GameForm.defaultProps = {
  publishers: []
}