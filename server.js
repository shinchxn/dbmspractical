const http = require('http');
const fs = require('fs');
const path = require('path');

const PORT = 8000;
const HOST = '0.0.0.0';
const BASE_DIR = path.join(__dirname, 'DBMS_Flat_15');

const server = http.createServer((req, res) => {
    // Only accept GET and HEAD requests
    if (req.method !== 'GET' && req.method !== 'HEAD') {
        res.writeHead(405, { 'Content-Type': 'text/plain' });
        return res.end('Method Not Allowed\n');
    }

    const parsedUrl = new URL(req.url, `http://${req.headers.host || 'localhost'}`);
    let reqPath = decodeURIComponent(parsedUrl.pathname);

    // Root endpoint: Return index list of available files
    if (reqPath === '/' || reqPath === '') {
        fs.readdir(BASE_DIR, (err, files) => {
            if (err) {
                res.writeHead(500, { 'Content-Type': 'text/plain' });
                return res.end('Error reading directory\n');
            }
            const sqlFiles = files
                .filter(f => f.endsWith('.sql'))
                .sort((a, b) => {
                    const numA = parseInt(a);
                    const numB = parseInt(b);
                    return (!isNaN(numA) && !isNaN(numB)) ? numA - numB : a.localeCompare(b);
                });

            const body = [
                '=== DBMS Script Server ===',
                '',
                `Available files (${sqlFiles.length} total):`,
                ...sqlFiles.map(f => `  - ${f}`),
                '',
                'Usage examples:',
                '  curl -O http://<server-ip>:8000/<filename>.sql',
                '  curl http://<server-ip>:8000/<filename>.sql',
                ''
            ].join('\n');

            res.writeHead(200, { 'Content-Type': 'text/plain; charset=utf-8' });
            return res.end(body);
        });
        return;
    }

    // Extract requested filename (strip leading slash)
    let filename = reqPath.replace(/^\/+/, '');
    if (!filename.endsWith('.sql')) {
        if (fs.existsSync(path.join(BASE_DIR, `${filename}.sql`))) {
            filename = `${filename}.sql`;
        }
    }

    const safePath = path.resolve(BASE_DIR, filename);

    // Path traversal check
    if (!safePath.startsWith(path.resolve(BASE_DIR) + path.sep)) {
        res.writeHead(403, { 'Content-Type': 'text/plain' });
        return res.end('403 Forbidden: Access denied\n');
    }

    fs.stat(safePath, (err, stats) => {
        if (err || !stats.isFile()) {
            res.writeHead(404, { 'Content-Type': 'text/plain' });
            return res.end(`404 Not Found: File '${filename}' not found\n`);
        }

        res.writeHead(200, {
            'Content-Type': 'text/plain; charset=utf-8',
            'Content-Length': stats.size,
            'Content-Disposition': `inline; filename="${filename}"`
        });

        const readStream = fs.createReadStream(safePath);
        readStream.pipe(res);
    });
});

server.listen(PORT, HOST, () => {
    console.log(`DBMS Server running at http://${HOST}:${PORT}/`);
    console.log(`Serving SQL files from: ${BASE_DIR}`);
});

