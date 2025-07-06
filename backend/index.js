const express = require('express');
const app = express();
const auth = require('./router/auth');
const mongoose = require('mongoose');
const env = require('dotenv');
const User = require('./model/user');
const port = process.env.PORT || 80;
env.config();


mongoose.connect(process.env.MONGO_URL)
.then(() => {
    console.log("Connected to MongoDB");
}).catch((err) => {
    console.error("Error connecting to MongoDB:", err);
});



app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use('/auth', auth);









app.listen(port, (req,res) =>
{
    console.log(`Server is running on http://localhost:${port}`);
})