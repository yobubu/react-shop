import React from "react";
import _orderBy from "lodash/orderBy";
import GamesList from "./GamesList";
import GameForm from "./GameForm";

const games = [
  {
    _id: 1,
    publisher: 1,
    featured: true,
    name: "Monopoly",
    thumbnail:
      "https://www.londondrugs.com/on/demandware.static/-/Sites-londondrugs-master/default/dwd1b0f1a3/products/L0045117/large/L0045117.JPG",
    price: 3299,
    players: "2-5",
    duration: 240,
    description:
      "Suspendisse ac mauris ut lorem molestie ultricies in ut libero. Vivamus dictum purus nisi, eget imperdiet neque rhoncus id. In pulvinar sit amet metus ac aliquet. In at vehicula est. Sed est nisl, ullamcorper at quam non, varius varius ante. Fusce vel quam odio. Nulla purus diam, molestie ac arcu et, placerat semper nisi.",
    descriptionVisible: true
  },
  {
    _id: 2,
    publisher: 2,
    featured: false,
    name: "Uno",
    thumbnail:
      "https://i5.walmartimages.com/asr/1384aeab-ea7f-44d6-afe6-4fc34326d278_1.b0f6c200b9f3248524f2b2e43be9feea.jpeg",
    price: 1299,
    players: "2-4",
    duration: 60,
    description:
      "Suspendisse ac mauris ut lorem molestie ultricies in ut libero. Vivamus dictum purus nisi, eget imperdiet neque rhoncus id. In pulvinar sit amet metus ac aliquet. In at vehicula est. Sed est nisl, ullamcorper at quam non, varius varius ante. Fusce vel quam odio. Nulla purus diam, molestie ac arcu et, placerat semper nisi.",
    descriptionVisible: true
  },
  {
    _id: 3,
    publisher: 1,
    featured: false,
    name: "Scrabble",
    thumbnail:
      "https://images-na.ssl-images-amazon.com/images/I/81DxpxY-BaL._SX679_.jpg",
    price: 1599,
    players: "2-6",
    duration: 160,
    description:
      "Suspendisse ac mauris ut lorem molestie ultricies in ut libero. Vivamus dictum purus nisi, eget imperdiet neque rhoncus id. In pulvinar sit amet metus ac aliquet. In at vehicula est. Sed est nisl, ullamcorper at quam non, varius varius ante. Fusce vel quam odio. Nulla purus diam, molestie ac arcu et, placerat semper nisi.",
    descriptionVisible: true
  }
];

class App extends React.Component {
  state = {
    games: []
  };

  componentDidMount() {
    this.setState({ games: this.sortGames(games) });
  }

  sortGames(games) {
    return _orderBy(games, ["featured", "name"], ["desc", "asc"]);
  }

  toggleFeatured = gameID =>
    this.setState({
      games: this.sortGames(
        this.state.games.map(game =>
          gameID === game._id ? { ...game, featured: !game.featured } : game
        )
      )
    });

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

  render() {
    return (
      <div className="ui container">
        <GameForm publishers={publishers} />
        <GamesList
          games={this.state.games}
          toggleFeatured={this.toggleFeatured}
          descriptionToggle={this.descriptionToggle}
        />
      </div>
    );
  }
}

export default App;
