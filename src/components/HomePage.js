import React from "react";
import YouTube from "react-youtube";

class HomePage extends React.Component {
  render() {
    return (
      <div className="ui stackable">
        <h1>Before you start.</h1>

        <h2>
          Please take a look at this short video presenting functionality of app
        </h2>

        <YouTube
          className="ui stackable container"
          videoId="Wk3vtXJgr-I"
          onReady={this._onReady}
        />
      </div>
    );
  }
}

export default HomePage;
