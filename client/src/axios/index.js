import axios from "axios";

export default axios.create({
  baseURL: `http://${process.env.VUE_APP_SERVER_HOST}:${process.env.VUE_APP_SERVER_PORT}/api`,
  headers: {
    "Content-type": "application/json"
  }
});
