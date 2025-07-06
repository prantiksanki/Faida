const mongoose = require('mongoose');


const userSchema = new mongoose.Schema(
    {
        id:
        {
            type: Number,
            required: true,
            unique: true
        }, 
        username :
        {
            type: String,
            required: true,
            unique: true
        }, 
        email :
        {
            type: String,
            required: true,
            unique: true
        },
        password :
        {
            type: String,
            required: true
        },
        createdAt :
        {
            type: Date,
            default: Date.now
        }

    }, 
    {timestamps: true}
)

const User = mongoose.model('User', userSchema);
module.exports = User;