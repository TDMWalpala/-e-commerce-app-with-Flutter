console.log("hello");
const express = require('express');
const app = express(); // Create an instance of the Express application

const PORT = 3000;

app.get("/",(req,res)=>{
    res.json({name:"Tharindu"});
})

app.get("/hello", (req, res) => {
    res.json({hi:"Hello-world"});
});

app.listen(PORT, "0.0.0.0", () => {
    console.log(`connected at port ${PORT}`);
});
