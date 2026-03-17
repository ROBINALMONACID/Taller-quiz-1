import express from 'express';
import morgan from 'morgan';
import userRoutes from '../routes/user.routes.js';
import userStatusRoutes from '../routes/userStatus.routes.js';
import roleRoutes from '../routes/role.routes.js';
import userApiRoutes from '../routes/apiUser.routes.js';


const app = express();

// CORS básico para desarrollo (útil para Flutter Web / apps en otro origen).
app.use((req, res, next) => {
  const origin = process.env.CORS_ORIGIN || '*';
  res.setHeader('Access-Control-Allow-Origin', origin);
  res.setHeader('Vary', 'Origin');
  res.setHeader(
    'Access-Control-Allow-Headers',
    'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  );
  res.setHeader('Access-Control-Allow-Methods', 'GET,POST,PUT,DELETE,OPTIONS');
  if (req.method === 'OPTIONS') {
    return res.sendStatus(204);
  }
  next();
});

app.get('/health', (req, res) => {
  res.json({ ok: true });
});

// Middleware to handle JSON
app.use(express.json());
// Request logging (method, path, status, response time)
app.use(morgan('dev'));
// Prefix for all profile routes, facilitating scalability
app.use('/api_v1', userRoutes);
app.use('/api_v1', userStatusRoutes);
app.use('/api_v1', roleRoutes);
app.use('/api_v1', userApiRoutes);
app.use((rep, res, nex) => {
 res.status(404).json({
 message: 'Endpoint losses'
 });
});
// Error logging middleware
app.use((err, req, res, next) => {
 console.error('[ERROR]', err);
 res.status(500).json({ error: 'Internal Server Error' });
});
export default app;
