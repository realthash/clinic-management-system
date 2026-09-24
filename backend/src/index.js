import 'dotenv/config'
import app from "./server.js";
import chalk from 'chalk'

const PORT = process.env.PORT || 5000
app.listen(PORT, () => {
    console.log(chalk.yellow.bold(`\nserver started to listen on port: ${PORT}`))
    console.log(chalk.yellow.bold.underline(`http://localhost:${PORT}\n`))
})