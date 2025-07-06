const router = require('express').Router();
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const mongoose = require('mongoose');
const env = require('dotenv');
const User = require('../model/user');
env.config();




router.post('/signup', async (req, res) => {
    const { username, email, password } = req.body;

    try {
        // Check if the user already exists
        const existingUser = await User.findOne({ email: email });
        if (existingUser) {
            return res.status(400).json({ message: "User already exists" });
        }

        // Hash the password
        const hashedPassword = await bcrypt.hash(password, 10);

        // Create and save the new user
        const newUser = new User({
            username,
            email,
            password: hashedPassword, 
            id:Date.now() + Math.floor(Math.random() * 1000) // Simple uniques ID generation
        });

        await newUser.save();

        res.status(201).json({ message: "Signup successful", userId: newUser.id });
    } catch (err) {
        console.error(err);
        res.status(500).json({ message: "Server error", error: err.message });
    }
});


router.post('/login', async (req, res) => {
const { email, password } = req.body;

try {
    const user = await User.findOne({ email: email });
    if (!user) {
        return res.status(400).json({ message: "User not found" });
    }

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) {
        return res.status(400).json({ message: "Invalid credentials" });
    }

    const token = jwt.sign({ userId: user.id }, process.env.JWT_SECRET);

    res.json({ message: "Login successful", token, userId: user.id });
} catch (err) {
    return res.status(500).json({ message: "Server error", error: err.message });
}

    
});


module.exports = router;