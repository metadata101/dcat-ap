import { defineConfig } from "cypress";
import { setupNodeEvents } from "./cypress/plugins";

export default defineConfig({
  e2e: {
    baseUrl: "http://localhost:8080",
    setupNodeEvents,
  },
  video: true,
});
