import React from "react";
import _orderBy from "lodash/orderBy";
import GamesList from "./GamesList";

const games = [
  {
    _id: 1,
    featured: true,
    name: "Monopoly",
    thumbnail:
      "https://www.londondrugs.com/on/demandware.static/-/Sites-londondrugs-master/default/dwd1b0f1a3/products/L0045117/large/L0045117.JPG",
    price: 3299,
    players: "2-5",
    duration: 240
  },
  {
    _id: 2,
    featured: false,
    name: "Uno",
    thumbnail:
      "https://i5.walmartimages.com/asr/1384aeab-ea7f-44d6-afe6-4fc34326d278_1.b0f6c200b9f3248524f2b2e43be9feea.jpeg",
    price: 1299,
    players: "2-4",
    duration: 60
  },
  {
    _id: 3,
    featured: false,
    name: "Scrabble",
    thumbnail:
      "https://images-na.ssl-images-amazon.com/images/I/81DxpxY-BaL._SX679_.jpg",
    price: 1599,
    players: "2-6",
    duration: 160
  }
];

class App extends React.Component {
  state = {
    games: []
  };

  componentDidMount() {
    this.setState({
      games: _orderBy(games, ["featured", "name"], ["desc", "asc"])
    });
  }
  render() {
    return (
      <div class Name="ui container">
        <GamesList games={this.state.games} />
      </div>
    );
  }
}

export default App;
