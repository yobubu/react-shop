import axios from "axios";
import dotenv from "dotenv";
import path from "path";

dotenv.config({
  path: path.join(__dirname, ".env")
});

axios.defaults.baseURL = process.env.REACT_APP_BASE_URL;

export default {
  games: {
    fetchAll: () => axios.get("/api/authgames").then(res => res.data.games),
    fetchById: id =>
      axios.get(`/api/authgames/${id}`).then(res => res.data.game),
    create: game =>
      axios.post("/api/authgames", { game }).then(res => res.data.game),
    update: game =>
      axios
        .put(`/api/authgames/${game._id}`, { game })
        .then(res => res.data.game),
    delete: game => axios.delete(`/api/authgames/${game._id}`)
  },
  users: {
    create: user => axios.post(`/api/users`, { user }),
    login: credentials =>
      axios.post("/api/auth", { credentials }).then(res => res.data.token),
    addToCart: ({ user, game }) =>
      axios.put("/api/cart/", { user, game }).then(res => res.data.cart),
    fetchCart: id => axios.get(`/api/cart/${id}`).then(res => res.data.cart),
    removeFromCart: ({ user, game }) =>
      axios.put(`/api/cart/${user._id}`, { game }).then(res => res.data.cart)
  }
};
