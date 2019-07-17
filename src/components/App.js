import React from "react";
import _orderBy from "lodash/orderBy";
import _find from "lodash/find";
import TopNavigation from "./TopNavigation";
import GamesList from "./GamesList";
import GameForm from "./GameForm";
import api from "../api";

const publisher = [
  {
    _id: "1",
    name: "Days of Wonder"
  },
  {
    _id: "2",
    name: "Rio Grande Games"
  }
];

class App extends React.Component {
  state = {
    games: [],
    showGameForm: false,
    selectedGame: {}
  };

  componentDidMount() {
    api.games
      .fetchAll()
      .then(games => this.setState({ games: this.sortGames(games) }));
  }

  sortGames(games) {
    return _orderBy(games, ["featured", "name"], ["desc", "asc"]);
  }

  toggleFeatured = gameID => {
    const game = _find(this.state.games, { _id: gameID });
    return this.updateGame({
      ...game,
      featured: !game.featured
    });
  };

  descriptionToggle = gameID =>
    this.setState({
      games: this.sortGames(
        this.state.games.map(game =>
          gameID === game._id
            ? { ...game, descriptionVisible: !game.descriptionVisible }
            : game
        )
      )
    });

  showGameForm = () => this.setState({ showGameForm: true, selectedGame: {} });
  hideGameForm = () => this.setState({ showGameForm: false, selectedGame: {} });

  saveGame = game => (game._id ? this.updateGame(game) : this.addGame(game));

  addGame = gameData =>
    api.games.create(gameData).then(game =>
      this.setState({
        games: this.sortGames([...this.state.games, game]),
        showGameForm: false
      })
    );

  updateGame = gameData =>
    api.games.update(gameData).then(game =>
      this.setState({
        games: this.sortGames(
          this.state.games.map(item => (item._id === game._id ? game : item))
        ),
        showGameForm: false
      })
    );

  selectGameForEditing = game =>
    this.setState({ selectedGame: game, showGameForm: true });

  deletingGame = game =>
    this.setState({
      games: this.state.games.filter(item => item._id !== game._id)
    });

  render() {
    const numberOfColumns = this.state.showGameForm ? "ten" : "sixteen";

    return (
      <div className="ui container">
        <TopNavigation showGameForm={this.showGameForm} />

        <div className="ui stackable grid">
          {this.state.showGameForm && (
            <div className="six wide column">
              <GameForm
                publisher={publisher}
                cancel={this.hideGameForm}
                submit={this.saveGame}
                game={this.state.selectedGame}
              />
            </div>
          )}
          <div className={`${numberOfColumns} wide column`}>
            <GamesList
              games={this.state.games}
              toggleFeatured={this.toggleFeatured}
              descriptionToggle={this.descriptionToggle}
              editGame={this.selectGameForEditing}
              deleteGame={this.deletingGame}
            />
          </div>
        </div>
      </div>
    );
  }
}

export default App;
