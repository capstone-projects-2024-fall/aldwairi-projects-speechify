const cmudict = require('@stdlib/datasets-cmudict');
const fs = require('fs');

// Retrieve CMUDict data
const data = cmudict();
console.log("CMUDict Data:", data);  // Log data to inspect its structure

// Check if data is loaded
if (!data) {
    console.error("Data could not be loaded. Check CMUDict installation or data structure.");
    process.exit(1);
}


// Initialize array for formatted notecards
const notecards = [];
let idCounter = 1;

// Format each entry according to the Notecard structure
for (const [word, phonetic] of Object.entries(data.dict)) {
    notecards.push({
        word: word,
        phonetic: phonetic,
        favorite: "false",
        audioPath: `/audio/${word}.mp3`,
        wordID: idCounter.toString()
    });
    idCounter++;
}

// Output formatted notecards to a JSON file
fs.writeFileSync("CMUDict_Notecards.json", JSON.stringify(notecards, null, 2));
console.log("CMUDict data formatted and saved as CMUDict_Notecards.json");
