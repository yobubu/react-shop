import express from "express";
import mongodb from "mongodb";
import authenticate from "../middlewares/authenticate";
import userOnly from "../middlewares/userOnly";

const router = express.Router();

// router.post("/", authenticate, userOnly, (req, res) => {
//   const db = req.app.get("db");

//   db.collection("users").insertOne(req.body.game, (err, r) => {
//     if (err) {
//       res.status(500).json({ errors: { global: err } });
//       return;
//     }

//     res.json({ game: r.ops[0] });
//   });
// });

router.put("/", authenticate, userOnly, (req, res) => {
  const db = req.app.get("db");
  const { _id, email, password, role, ...game } = req.body.game;

  if (Object.keys(errors).length === 0) {
    db.collection("users").findOneAndUpdate(
      { _id: new mongodb.ObjectId(req.params._id) },
      { $set: game },
      { returnOriginal: false },
      (err, r) => {
        if (err) {
          res.status(500).json({ errors: { global: err } });
          return;
        }

        // res.json({ game: r.value });
      }
    );
  } else {
    res.status(400).json({ errors });
  }
});

router.delete("/:_id", authenticate, userOnly, (req, res) => {
  const db = req.app.get("db");

  db.collection("games").deleteOne(
    { _id: new mongodb.ObjectId(req.params._id) },
    err => {
      if (err) {
        res.status(500).json({ errors: { global: err } });
        return;
      }

      res.json({});
    }
  );
});

export default router;
