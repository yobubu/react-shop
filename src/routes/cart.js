import express from "express";
import mongodb from "mongodb";
import authenticate from "../middlewares/authenticate";
import userOnly from "../middlewares/userOnly";

const router = express.Router();

router.put("/", authenticate, userOnly, (req, res) => {
  const _id = req.body.user._id;
  const gameId = req.body.game._id;
  const db = req.app.get("db");

  db.collection("users").findOneAndUpdate(
    { _id: new mongodb.ObjectId(_id) },
    {
      $push: { cart: gameId }
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

export default router;
