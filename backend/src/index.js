import 'dotenv/config'
import app from "./server.js";
import chalk from 'chalk'

import { connectDB } from './config/db.js';

const PORT = process.env.PORT || 5000


const startServer = async () => {

    try {
        await connectDB()

        app.listen(PORT, () => {
            console.log(chalk.yellow.bold(`\nserver started to listen on port: ${PORT}`));
            console.log(chalk.yellow.bold.underline(`http://localhost:${PORT}\n`));
        });

    } catch (err) {
        console.error(chalk.red('Server startup aborted due to DB error: '), err)
    }

}


startServer()