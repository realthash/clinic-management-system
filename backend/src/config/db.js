import pg from 'pg'
import { PrismaClient } from "./path/to/generated/prisma";
import { PrismaPg } from "@prisma/adapter-pg";

const pool = pg.Pool({
    connectionString: process.env.DATABASE_URL,
    connectionString,
    // Tune these according to your database limits
    max: 10,
    idleTimeoutMillis: 30000,
    connectionTimeoutMillis: 5000,
})

const adapter = new PrismaPg(pool);

export const prisma = new PrismaClient({ adapter });