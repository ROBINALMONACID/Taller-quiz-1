import app from './app/app.js';
import dotenv from 'dotenv';
import { dirname, join } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));
dotenv.config({ path: join(__dirname, '../.env') });
const PORT = process.env.PORT || 3000; // Allow dynamic port configuration
const HOST = process.env.HOST || '0.0.0.0';
// Log unexpected errors to the terminal
process.on('unhandledRejection', (reason) => {
 console.error('[UNHANDLED_REJECTION]', reason);
});
process.on('uncaughtException', (err) => {
 console.error('[UNCAUGHT_EXCEPTION]', err);
});
// Start the server
app.listen(PORT, HOST, () => {
 console.log(`Server running on http://${HOST}:${PORT}`);
});
