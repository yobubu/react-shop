import React from "react";
import YouTube from "react-youtube";

const AboutMe = () => (
  <div>
    <div className="ui container">
      <div className="ui stackable grid">
        <div className="ui card four wide column">
          <div className="ui image">
            <img src="/media/img/aboutme.jpg" alt="" />
          </div>
          <div className="content">
            <div className="header">Paweł Frączyk</div>
            <div className="meta">
              <span className="date">Gdynia, Poland</span>
            </div>
            <div className="justified container">
              FrontEnd Developer, Tester, Dj, Traveller, Motorcyclist and Sailor
              in one. Also happy husband married to Thai wife - Purichaya.
              Always smiling and finding positives around.
            </div>
          </div>
        </div>
        <div className="twelve wide column">
          <h3 className="ui centered">
            Check out my vid from 100 lonely days in Asia in 2016!
          </h3>
          <YouTube
            className="ui stackable container"
            videoId="bu2snxddfdI"
            opts={{
              height: "400"
            }}
          />
        </div>
      </div>
    </div>
  </div>
);

export default AboutMe;
