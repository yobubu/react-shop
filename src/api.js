import axios from "axios";

export default {
  games: {
    fetchAll: () => axios.get("/api/unsafegames").then(res => res.data.games),
    create: game =>
      axios.post("/api/unsafegames", { game }).then(res => res.data.game)
  }
};
