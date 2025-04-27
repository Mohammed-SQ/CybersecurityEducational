const http = require('http');
const url = require('url');
const querystring = require('querystring');

// URL of the DbMicroservice (update after deployment)
const DB_MICROSERVICE_URL = 'http://localhost:5001'; // Replace with https://your-dbmicroservice.render.com after deployment

// Helper function to make HTTP POST requests to the microservice
const makePostRequest = (path, postData) => {
    return new Promise((resolve, reject) => {
        const options = {
            hostname: url.parse(DB_MICROSERVICE_URL).hostname,
            port: url.parse(DB_MICROSERVICE_URL).port || 80,
            path: path,
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
                'Content-Length': Buffer.byteLength(postData)
            }
        };

        const req = http.request(options, (res) => {
            let data = '';
            res.on('data', (chunk) => data += chunk);
            res.on('end', () => {
                resolve({ statusCode: res.statusCode, body: data });
            });
        });

        req.on('error', (err) => reject(err));
        req.write(postData);
        req.end();
    });
};

// Create the HTTP server
const server = http.createServer(async (req, res) => {
    const parsedUrl = url.parse(req.url, true);
    const path = parsedUrl.pathname;

    // Enable CORS manually
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
    res.setHeader('Access-Control-Allow-Headers', 'Content-Type');

    // Handle preflight OPTIONS request
    if (req.method === 'OPTIONS') {
        res.writeHead(204);
        res.end();
        return;
    }

    // Collect request body for POST requests
    let body = '';
    req.on('data', chunk => body += chunk);
    req.on('end', async () => {
        const postData = querystring.parse(body);

        // Registration endpoint
        if (req.method === 'POST' && path === '/api/register') {
            const { Username, Email, Password } = postData;

            // Basic validation
            if (!Username || !Email || !Password) {
                res.writeHead(400, { 'Content-Type': 'text/plain' });
                res.end('All fields are required.');
                return;
            }
            if (!/^[a-z]+$/.test(Username) || Username.length < 5 || Username.length > 20) {
                res.writeHead(400, { 'Content-Type': 'text/plain' });
                res.end('Username must be 5-20 lowercase letters only.');
                return;
            }
            if (!/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(Email)) {
                res.writeHead(400, { 'Content-Type': 'text/plain' });
                res.end('Invalid email format.');
                return;
            }
            if (!/^[a-zA-Z0-9]+$/.test(Password) || Password.length < 8) {
                res.writeHead(400, { 'Content-Type': 'text/plain' });
                res.end('Password must be at least 8 characters, letters and numbers only.');
                return;
            }

            try {
                const microserviceData = querystring.stringify({ Username, Email, Password });
                const result = await makePostRequest('/db/register', microserviceData);
                res.writeHead(result.statusCode, { 'Content-Type': 'application/json' });
                res.end(result.body);
            } catch (err) {
                res.writeHead(500, { 'Content-Type': 'text/plain' });
                res.end(`Error: ${err.message}`);
            }
        }
        // Login endpoint
        else if (req.method === 'POST' && path === '/api/login') {
            const { Email, Password } = postData;

            if (!Email || !Password) {
                res.writeHead(400, { 'Content-Type': 'text/plain' });
                res.end('All fields are required.');
                return;
            }
            if (!/^[^@\s]+@[^@\s]+\.[^@\s]+$/.test(Email)) {
                res.writeHead(400, { 'Content-Type': 'text/plain' });
                res.end('Invalid email format.');
                return;
            }
            if (!/^[a-zA-Z0-9]+$/.test(Password)) {
                res.writeHead(400, { 'Content-Type': 'text/plain' });
                res.end('Password must contain only letters and numbers.');
                return;
            }

            try {
                const microserviceData = querystring.stringify({ Email, Password });
                const result = await makePostRequest('/db/login', microserviceData);
                res.writeHead(result.statusCode, { 'Content-Type': 'application/json' });
                res.end(result.body);
            } catch (err) {
                res.writeHead(500, { 'Content-Type': 'text/plain' });
                res.end(`Error: ${err.message}`);
            }
        }
        // 2FA verification endpoint
        else if (req.method === 'POST' && path === '/api/verify2fa') {
            const { UserId, Code } = postData;

            if (!UserId || !Code) {
                res.writeHead(400, { 'Content-Type': 'text/plain' });
                res.end('All fields are required.');
                return;
            }
            if (!/^[0-9]{6}$/.test(Code)) {
                res.writeHead(400, { 'Content-Type': 'text/plain' });
                res.end('Invalid 6-digit code.');
                return;
            }

            try {
                const microserviceData = querystring.stringify({ UserId, Code });
                const result = await makePostRequest('/db/verify2fa', microserviceData);
                res.writeHead(result.statusCode, { 'Content-Type': 'application/json' });
                res.end(result.body);
            } catch (err) {
                res.writeHead(500, { 'Content-Type': 'text/plain' });
                res.end(`Error: ${err.message}`);
            }
        }
        // Payment endpoint
        else if (req.method === 'POST' && path === '/api/savepayment') {
            const { UserId, CardName, CardNumber, ExpiryMonth, ExpiryYear, CVV } = postData;

            if (!UserId || !CardName || !CardNumber || !ExpiryMonth || !ExpiryYear || !CVV) {
                res.writeHead(400, { 'Content-Type': 'text/plain' });
                res.end('All fields are required.');
                return;
            }
            if (!/^[0-9]{16}$/.test(CardNumber)) {
                res.writeHead(400, { 'Content-Type': 'text/plain' });
                res.end('Enter a valid 16-digit card number.');
                return;
            }
            if (!/^(0[1-9]|1[0-2])$/.test(ExpiryMonth)) {
                res.writeHead(400, { 'Content-Type': 'text/plain' });
                res.end('Enter a valid month (01-12).');
                return;
            }
            if (!/^[0-9]{4}$/.test(ExpiryYear)) {
                res.writeHead(400, { 'Content-Type': 'text/plain' });
                res.end('Enter a valid year (e.g., 2025).');
                return;
            }
            const year = parseInt(ExpiryYear);
            const month = parseInt(ExpiryMonth);
            const expiryDate = new Date(year, month - 1, new Date(year, month, 0).getDate());
            if (expiryDate < new Date()) {
                res.writeHead(400, { 'Content-Type': 'text/plain' });
                res.end('Card has expired.');
                return;
            }
            if (!/^[0-9]{3,4}$/.test(CVV)) {
                res.writeHead(400, { 'Content-Type': 'text/plain' });
                res.end('Enter a valid CVV (3 or 4 digits).');
                return;
            }

            try {
                const microserviceData = querystring.stringify({ UserId, CardName, CardNumber, ExpiryMonth, ExpiryYear, CVV });
                const result = await makePostRequest('/db/savepayment', microserviceData);
                res.writeHead(result.statusCode, { 'Content-Type': 'application/json' });
                res.end(result.body);
            } catch (err) {
                res.writeHead(500, { 'Content-Type': 'text/plain' });
                res.end(`Error: ${err.message}`);
            }
        }
        // Test endpoint
        else if (req.method === 'GET' && path === '/api/test') {
            res.writeHead(200, { 'Content-Type': 'text/plain' });
            res.end('Node.js Backend is working!');
        }
        else {
            res.writeHead(404, { 'Content-Type': 'text/plain' });
            res.end('Not Found');
        }
    });
});

const PORT = process.env.PORT || 3000;
server.listen(PORT, () => console.log(`Server running on port ${PORT}`));