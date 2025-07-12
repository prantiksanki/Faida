const mongoose  = require('mongoose');

const confidentialSchema = new mongoose.Schema(
    {
        userId : {
            type: mongoose.Schema.Types.ObjectId,
            ref: 'User',
            required: true
        },
        pan :
        {
            type: String,
            required: true,
            unique: true
        }, 
        isPanVerified :
        {
            type: Boolean,
            default: false
        },
        aadhaar :
        {
            type: String,
            required: true,
            unique: true
        },
        isAadhaarVerified :
        {
            type: Boolean,
            default: false
        }, 
        bankAccount :
        {
            type: String,
            required: true,
            unique: true
        },
        isBankAccountVerified :
        {
            type: Boolean,
            default: false
        }, 
        passportPhotoUrl :
        {
            type: String,
            required: true,
            unique: true
        } , 
        signatureUrl :  
        {
            type: String,
            required: true,
            unique: true
        }
    }, 

    {timestamps: true}
)

const Confidential = mongoose.model('Confidential', confidentialSchema);
module.exports = Confidential;