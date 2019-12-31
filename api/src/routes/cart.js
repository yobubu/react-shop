import express from "express";
import mongodb from "mongodb";
import authenticate from "../middlewares/authenticate";
import userOnly from "../middlewares/userOnly";

const router = express.Router();

router.get("/:_id", (req, res) => {
  const db = req.app.get("db");
  db.collection("users").findOne(
    { _id: new mongodb.ObjectId(req.params._id) },
    (err, cart) => {
      if (err) {
        res.status(500).json({ errors: { global: err } });
        return;
      }

      res.json({ cart });
    }
  );
});

router.put("/", authenticate, userOnly, (req, res) => {
  const _id = req.body.user._id;
  const game = req.body.game;
  const db = req.app.get("db");

  db.collection("users").findOneAndUpdate(
    { _id: new mongodb.ObjectId(_id) },
    {
      $push: { cart: game }
    },
    (err, r) => {
      if (err) {
        res.status(500).json({ errors: { global: err } });
        return;
      }

      res.json({ cart: r.value });
    }
  );
});

router.put("/:_id", authenticate, userOnly, (req, res) => {
  const _id = req.params._id;
  const _gameId = req.body.game;
  const db = req.app.get("db");
  db.collection("users").updateMany(
    { _id: new mongodb.ObjectId(_id) },
    { $pullAll: { cart: [_gameId] } },
    (err, cart) => {
      if (err) {
        res.status(500).json({ errors: { global: err } });
        return;
      }
      res.json({ cart });
    }
  );
});

export default router;
