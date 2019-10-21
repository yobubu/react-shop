import React from "react";
import { Button, Header, Image, Modal } from "semantic-ui-react";
import ModalPhoto from "../media/img/modal.png";

const ModalPage = ({ open, onClose }) => (
  <div>
    <Modal open={open} onClose={onClose}>
      <Modal.Header>
        <span>Welcome!</span>
        <Button
          icon="times"
          floated="right"
          size="mini"
          onClick={() => onClose()}
        />
      </Modal.Header>

      <Modal.Content image>
        <Image wrapped size="medium" src={ModalPhoto} />
        <Modal.Description>
          <Header>Thank you for coming to my app</Header>
          <p>
            This website was developed by myself using JS & React.
          </p>
          <p>
            I also practice automation tools in DevOps culture within. You can
            check my repo in BitBucket to check Jenkinsfile and DockerFile. You can also
            clone the repo and run this app in localhost using Docker Compose file. It will
            run also mongodb container with init data of sample game and admin account to 
            create more games in shop.</p>
            <p>
            (credentials: admin@admin.com pass: adminadmin)</p>
            <p><a href="https://bitbucket.org/pozzee/practice-react/">
            BitBucket repo
          </a></p>
          <p>
            I will answer all your question about my skills with pleasure so
            don't forget to contact me after that :)
          </p>
          <p floated="right">Paweł</p>
          <Button positive floated="right" onClick={() => onClose()}>
            Explore
          </Button>
        </Modal.Description>
      </Modal.Content>
    </Modal>
  </div>
);

export default ModalPage;
