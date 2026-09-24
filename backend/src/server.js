import express from 'express';
import morgan from 'morgan';

// Routes
// import authRoutes from './routes/authRoutes.js
const app = express();

app.use(morgan('dev'))
// app.use('/auth', authRoutes)

app.get('/', (req, res) => {
    res.status(200).json({
        status: "success",
        message: "API is running..."
    })
})

export default app;