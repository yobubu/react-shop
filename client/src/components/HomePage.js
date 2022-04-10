import React from "react";
import YouTube from "react-youtube";

class HomePage extends React.Component {
  render() {
    return (
      <div className="ui stackable">
        <h1>Welcome to yobubu.</h1>

        <h2>
          My free time
        </h2>

        <YouTube
          className="ui stackable container"
          videoId="cyJSZ0u24gc"
          onReady={this._onReady}
        />
      </div>
    );
  }
}

export default HomePage;
