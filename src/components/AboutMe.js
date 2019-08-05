import React from "react";
import AboutMePhoto from "../media/img/aboutme.jpg";
import YouTube from "react-youtube";

const AboutMe = () => (
  <div>
    <div className="ui container">
      <div className="ui stackable grid">
        <div className="ui card four wide column">
          <div className="ui image">
            <img src={AboutMePhoto} alt="Hire me Paweł Frączyk" />
          </div>
          <div className="content">
            <div className="header">
              Paweł Frączyk
              <a href="https://www.linkedin.com/in/pawel-fraczyk/">
                <i className="right floated linkedin icon" />
              </a>
              <a href="https://m.me/pozzeetywny">
                <i className="right floated facebook messenger icon" />
              </a>
              <a href="tel:+48790290124">
                <i className="right floated phone icon" />
              </a>
            </div>
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
