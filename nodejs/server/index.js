import express from 'express';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();
const PORT = process.env.PORT || {{api_port}};

// Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// API Routes
app.get('/api/test', (req, res) => {
    res.json({ message: 'Hello from Express.js backend!' });
});

// Serve static files from the dist directory in production
if (process.env.NODE_ENV === 'production') {
    app.use(express.static(path.join(__dirname, '../dist')));

    // Handle client-side routing
    app.get('*', (req, res) => {
        res.sendFile(path.join(__dirname, '../dist/index.html'));
    });
}

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
