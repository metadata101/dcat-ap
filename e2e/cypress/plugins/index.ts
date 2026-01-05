/// <reference types="cypress" />
import * as fs from "fs";
import { Client, ClientConfig } from "pg";

type DbEnv = {
  db_host?: string;
  db_port?: string | number;
  db_user?: string;
  db_password?: string;
  db_name?: string;
};

async function getDbClient(env: DbEnv): Promise<Client> {
  const dbConfig = {
    host: env.db_host,
    port: env.db_port ? Number(env.db_port) : undefined,
    user: env.db_user,
    password: env.db_password,
    database: env.db_name,
  } satisfies ClientConfig;

  const client = new Client(dbConfig);
  await client.connect();
  return client;
}

async function runSQLFile(env: DbEnv, file: string) {
  const client = await getDbClient(env);
  const sqlSetupFile = fs.readFileSync(`cypress/sql/${file}`, "utf-8");
  await client.query(sqlSetupFile);
  await client.end();
  return true;
}

export function setupNodeEvents(
  on: Cypress.PluginEvents,
  config: Cypress.PluginConfigOptions,
) {
  on("task", {
    resetDB() {
      return Promise.all([
        runSQLFile(config.env, "reset.sql"),
        runSQLFile(config.env, "records.sql")
      ])
    },
  });

  return config;
}
