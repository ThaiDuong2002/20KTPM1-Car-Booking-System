import express from 'express';
import dotenv from 'dotenv';
import morgan from 'morgan';
import winston from 'winston';
import fs from 'fs';

const app = express();

dotenv.config();

app.use(express.json());

// Create a Winston logger and configure it to log to a .log file
const logFileName = process.env.LOGFILENAME;
const logger = winston.createLogger({
    format: winston.format.combine(
        winston.format.timestamp(),
        winston.format.json()
    ),
    transports: [
        new winston.transports.File({ filename: logFileName })
    ],
});

// Define a custom token for morgan to log req and res objects
morgan.token('request', (req, res) => {
    // Serialize the request object to a JSON string
    return JSON.stringify({
        method: req.method,
        url: req.protocol + '://' + req.get('host') + req.originalUrl,
        headers: req.headers,
        reqBody: req.body,
    });
});

morgan.token('response', (req, res) => {
    // Serialize the response object to a JSON string
    return JSON.stringify({
        resBody: res.body,
        statusCode: res.statusCode,
    });
});

// Custom format for morgan that includes the custom request and response tokens
const customMorganFormat = '-Request::request -Response::response';

// Custom middleware to intercept and store morgan log messages
const createMorganLogger = (log_level) => {
    return morgan(customMorganFormat, {
        stream: {
            write: (message) => {
                // Log to Winston and remove leading/trailing whitespace
                logger[log_level](message.trim());
            },
        },
    });
};

app.post('/log/info', createMorganLogger('info') ,(req, res) => {
    const { message } = req.body;
    console.log(message);
    res.status(200).json({
        status: 200,
        message: "Info log created successfully",
    });
});

app.post('/log/error', createMorganLogger('error'), (req, res) => {
    const { message } = req.body;
    console.log(message);
    res.status(200).json({
        status: 200,
        message: "Error log created successfully",
    });
});

// Retrieve the logs from the app.log file
app.get('/logs', createMorganLogger('info'), (req, res) => {
    try {
        const logFileContent = fs.readFileSync(logFileName, 'utf8');
        const logEntries = logFileContent.split('\n').filter((entry) => entry.trim() !== '');

        const logs = logEntries.map((entry) => JSON.parse(entry));
        res.status(200).json({
            status: 200,
            message: "Logs retrieved successfully",
            logs: logs,
        });
    } catch (error) {
        console.error('Error reading log file:', error);
        res.status(500).json({
            status: 500,
            message: "Error retrieving logs",
        });
    }
});

const port = process.env.PORT;
app.listen(port, () => {
    console.log(`Logging services is running on port ${port}`);
});