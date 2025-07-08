const router = require('express').Router();
const axios = require('axios');
const dotenv = require('dotenv');
dotenv.config();



router.get('/tips-news' , async (req, res) => {
    try {
        const response = await axios.get('https://newsapi.org/v2/top-headlines', {
            params: {
                category: 'business',
                country: 'us',
                apiKey: process.env.NEWS_API_KEY
            }
        });

        if (response.data.status !== 'ok') {
            return res.status(500).json({ error: 'Failed to fetch news' });
        }

        res.json(response.data.articles);
    } catch (error) {
        console.error('Error fetching news:', error.message);
        res.status(500).json({ error: 'Internal server error' });
    }
});






module.exports = router;