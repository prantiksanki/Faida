const mongoose = require('mongoose');

const mutualFundSchemeSchema = new mongoose.Schema({
    mfName: {
        type: String,
        required: true,
        trim: true
    },
    mfCode: {
        type: String,
        required: true,
        unique: true,
        trim: true
    },
    amcName: {
        type: String,
        required: true,
        trim: true
    },
    category: {
        type: String,
        enum: ['Equity', 'Debt', 'Hybrid', 'Others'],
        required: true
    },
    subcategory: {
        type: String,
        trim: true
    },
    riskLevel: {
        type: String,
        enum: ['Low', 'Moderate', 'High'],
        required: true
    },
    currentNAV: {
        type: Number,
        required: true
    },
    navDate: {
        type: Date,
        required: true
    },
    expenseRatio: {
        type: Number, // in percentage
        required: true
    },
    aum: {
        type: Number, // in crores
        required: true
    },
    launchDate: {
        type: Date
    },
    minInvestment: {
        type: Number,
        required: true
    },
    growthType: {
        type: String,
        enum: ['Growth', 'Dividend'],
        required: true
    },
    isOpenEnded: {
        type: Boolean,
        default: true
    },
    rating: {
        type: Number,
        min: 0,
        max: 5,
        default: 0
    },
    description: {
        type: String,
        trim: true
    },
    imageUrl: {
        type: String,
        trim: true
    },
    status: {
        type: String,
        enum: ['Active', 'Inactive', 'Merged'],
        default: 'Active'
    },
    returns: {
        oneYear: { type: Number, default: 0 },
        threeYear: { type: Number, default: 0 },
        fiveYear: { type: Number, default: 0 }
    },
    lastUpdated: {
        type: Date,
        default: Date.now
    }, 
    category:
    {
        type: String,
        default: 'Mutual Funds',
    }
}, { timestamps: true }); // adds createdAt and updatedAt automatically

module.exports = mongoose.model('MutualFundScheme', mutualFundSchemeSchema);




/*

| Field Name      | Type             | Purpose                                                        |
| --------------- | ---------------- | -------------------------------------------------------------- |
| `_id`           | ObjectId         | MongoDB’s primary ID                                           |
| `mfName`        | String           | Name of the mutual fund scheme (e.g., "Axis Bluechip Fund")    |
| `mfCode`        | String           | AMFI or internal scheme code                                   |
| `amcName`       | String           | AMC (Asset Management Company) name (e.g., "Axis Mutual Fund") |
| `category`      | String           | Category (e.g., "Equity", "Debt", "Hybrid")                    |
| `subcategory`   | String           | Subcategory (e.g., "Large Cap", "ELSS", "Short Term Debt")     |
| `riskLevel`     | String           | "Low", "Moderate", "High"                                      |
| `currentNAV`    | Number (Decimal) | Latest NAV of the scheme                                       |
| `navDate`       | Date             | Date of NAV update                                             |
| `expenseRatio`  | Number (Decimal) | Annual expense ratio (%)                                       |
| `aum`           | Number (Decimal) | Assets Under Management (in crores)                            |
| `launchDate`    | Date             | Scheme launch date                                             |
| `minInvestment` | Number (Decimal) | Minimum investment amount                                      |
| `growthType`    | String           | "Growth", "Dividend"                                           |
| `isOpenEnded`   | Boolean          | Open-ended status                                              |
| `rating`        | Number (Decimal) | Optional: External rating (e.g., 4.2/5)                        |
| `description`   | String           | Short description for the app card                             |
| `imageUrl`      | String           | Image/icon URL for scheme card                                 |
| `status`        | String           | "Active", "Inactive", "Merged"                                 |
| `lastUpdated`   | Date             | Last update timestamp                                          |


*/