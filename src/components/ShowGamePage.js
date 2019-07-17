import React, { Component } from "react";
import api from "../api";
import GameDetails from "./GameDetails";

class ShowGamePage extends Component {
  state = {
    game: {},
    loading: true
  };

  componentDidMount() {
    api.games.fetchById(this.props.match.params._id).then(game =>
      this.setState({
        game,
        loading: false
      })
    );
  }

  render() {
    return (
      <div>
        {this.state.loading ? (
          <p>Loading...</p>
        ) : (
          <GameDetails game={this.state.game} />
        )}
      </div>
    );
  }
}

export default ShowGamePage;
