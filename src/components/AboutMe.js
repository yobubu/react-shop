import React from "react";
import AboutMePhoto from "../media/img/aboutme.jpg";
import AWSCertified from "../media/img/aws-certified-logo_color-horz_180x30.jpg";
import CloudPractitioner from "../media/img/cloud-practitioner-tag_180x16.jpg"
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
              Junior AWS DevOps Engineer, Dj, Traveller, Motorcyclist and Sailor
              in one. Passionate about life and people. Always smiling and easy-going.
            
            </div>
              
          </div>
          <img src={AWSCertified} alt="AWS Certified" />
              <img src={CloudPractitioner} alt="Cloud Practitioner" />
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
