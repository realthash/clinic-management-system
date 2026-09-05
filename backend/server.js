import 'dotenv/config';
import express from 'express';
import cors from 'cors';
import { supabase } from './superbaseClient.js';

const app = express();
const PORT = process.env.PORT || 5000;

// Middlewares
app.use(cors());
app.use(express.json()); // replaces body-parser

// Health check route
app.get('/api/v1', (req, res) => {
    res.status(200).json({ status: 'ok', message: 'Clinic API is running' });
});

app.get("/api/v1/hospitals", async (req, res) => {
    const { data, error } = await supabase
        .from("hospital")
        .select("*");

    if (error) return res.status(500).json({ error: error.message });
    res.json(data);
});


// Import & mount routes (e.g. app.use('/api/patients', patientRoutes))

// Global error handler
app.use((err, req, res, next) => {
    console.error(err.stack);
    res.status(err.status || 500).json({
        error: {
            message: err.message || 'Internal Server Error'
        }
    });
});

app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});
