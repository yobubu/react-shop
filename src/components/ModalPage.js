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
            Please watch first video about the admin priviliges of adding,
            updating and removing games.
          </p>
          <p>
            Later try to sign up and login as regular user. At this moment I'm
            working on shopping cart that will be avaiable for users.
          </p>
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
