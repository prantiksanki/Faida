const express = require('express');
const router = express.Router();
const MutualFundScheme = require('../model/mfSchema');



router.get('/mf' , (req,res) =>
{
MutualFundScheme.find()
    .then(schemes => {
        if (!schemes || schemes.length === 0) {
            return res.status(404).json({ message: 'No mutual fund schemes found' });
        }

        // Add `category: 'Mutual Funds'` to each scheme before sending
        const schemesWithCategory = schemes.map(scheme => {
            // Convert Mongoose document to plain JS object
            const schemeObj = scheme.toObject();
            // Add your additional field
            schemeObj.category = 'Mutual Funds';
            return schemeObj;
        });

        // Return the modified list
        res.json(schemesWithCategory);
    })
    .catch(err => {
        console.error(err);
        res.status(500).json({ message: 'Server error' });
    });



})



router.post('/mf' , (req,res) =>
    {
        const newScheme = new MutualFundScheme(req.body);
        newScheme.save()
        .then(() => {
            res.status(201).json({ message: 'Mutual Fund Scheme created successfully' });
        })
        .catch(err => {
            console.error(err);
            res.status(500).json({ error: 'Internal server error' });
        });
    }
);




module.exports = router;