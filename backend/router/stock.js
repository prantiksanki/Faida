const express = require('express');
const axios = require('axios');
const dotenv = require('dotenv');
dotenv.config();
const router = express.Router();
const API_KEY = process.env.ALPHA_VANTAGE_KEY;

// Endpoint: GET /stocks/price?ticker=TSLA
router.get('/price', async (req, res) => {
    const { ticker } = req.query;

    if (!ticker) {
        return res.status(400).json({ error: 'Ticker symbol is required' });
    }

    try {
        const response = await axios.get('https://www.alphavantage.co/query', {
            params: {
                function: 'TIME_SERIES_INTRADAY',
                symbol: ticker,
                interval: '5min',
                apikey: API_KEY
            }
        });

        const data = response.data;
        if (data.Note) {
            return res.status(429).json({ error: 'Rate limit exceeded. Please wait.' });
        }

        const timeSeries = data['Time Series (5min)'];
        if (!timeSeries) {
            return res.status(404).json({ error: 'Data not found for the ticker.' });
        }

        // const latestTime = Object.keys(timeSeries)[0];
        // const latestData = timeSeries[latestTime];

        // res.json({
        //     ticker,
        //     price: latestData['1. open'],
        //     high: latestData['2. high'],
        //     low: latestData['3. low'],
        //     volume: latestData['5. volume'],
        //     timestamp: latestTime
        // });

        res.json({
            data,
            data: timeSeries
        });

    } catch (error) {
        console.error('Error fetching stock price:', error.message);
        res.status(500).json({ error: 'Internal server error' });
    }
});


router.get('/currency', async (req, res) => {
    const { from, to } = req.query;

    if (!from || !to) {
        return res.status(400).json({ error: 'Both "from" and "to" currency codes are required.' });
    }

    try {
        const response = await axios.get('https://www.alphavantage.co/query', {
            params: {
                function: 'CURRENCY_EXCHANGE_RATE',
                from_currency: from,
                to_currency: to,
                apikey: API_KEY
            }
        });

        const data = response.data['Realtime Currency Exchange Rate'];
        if (!data) {
            return res.status(404).json({ error: 'Forex data not found.' });
        }

        res.json({
            from_currency: data['1. From_Currency Code'],
            to_currency: data['3. To_Currency Code'],
            exchange_rate: data['5. Exchange Rate'],
            last_refreshed: data['6. Last Refreshed'],
            time_zone: data['7. Time Zone']
        });

    } catch (error) {
        console.error('Error fetching forex data:', error.message);
        res.status(500).json({ error: 'Internal server error.' });
    }
});


module.exports = router;
