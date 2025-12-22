import { defineConfig } from "cypress";
import { setupNodeEvents } from "./cypress/plugins";

export default defineConfig({
  e2e: {
    baseUrl: "http://localhost:8080",
    setupNodeEvents,
    defaultCommandTimeout: 10000,
  },
  video: true,
  env: {
    db_host: "localhost",
    db_port: "5432",
    db_name: "geonetwork",
    db_user: "geonetwork",
    db_password: "geonetwork",
  }
});
