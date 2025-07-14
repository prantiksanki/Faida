const express = require('express');
const app = express();
const mongoose = require('mongoose');
const env = require('dotenv');

const port = process.env.PORT || 80;
env.config();




// Importing routes

const auth = require('./router/auth');
const stock = require('./router/stock');
const dashboard = require('./router/dashboard');
const invest = require('./router/invest');





// Importing database models

const User = require('./model/user');




// In build middleware

app.use(express.json());
app.use(express.urlencoded({ extended: true }));




// middleware for routes

app.use('/auth', auth);
app.use('/stocks', stock);
app.use('/dashboard', dashboard);
app.use('/investment', invest);







//Database connection

mongoose.connect(process.env.MONGO_URL)
.then(() => {
    console.log("Connected to MongoDB");
}).catch((err) => {
    console.error("Error connecting to MongoDB:", err);
});











app.listen(port, (req,res) =>
{
    console.log(`Server is running on http://localhost:${port}`);
})