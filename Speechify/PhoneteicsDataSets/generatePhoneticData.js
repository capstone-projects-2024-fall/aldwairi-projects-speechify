const fs = require('fs');
const cmudict = require('@stdlib/datasets-cmudict');

// Load the CMU Pronouncing Dictionary data
const data = cmudict({ data: 'dict' });

// Filter out only the words and their phonetic spellings
const phoneticData = Object.entries(data).map(([word, phonetic]) => ({
  word,
  phonetic
}));

// Save as JSON file
fs.writeFileSync('cmu_phonetic_data.json', JSON.stringify(phoneticData, null, 2));
console.log('Phonetic data saved to cmu_phonetic_data.json');
