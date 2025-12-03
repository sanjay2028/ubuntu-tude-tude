
const express = require('express');
const path = require('path');

const app = express();
app.use(express.urlencoded({ extended: true }));

const PORT = process.env.PORT || 8000;
const SERVER_URL = process.env.SERVER_URL || "http://127.0.0.1:5000"

// Set EJS as the template engine
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

// Middleware to serve static files
app.use(express.static(path.join(__dirname, 'public')));

// Routes
app.post('/', async (req, res) => {
    const { name, age } = req.body
    const formData = { name, age }
    const submission_output = {
        status: null,
        success: null,
        validationErrors: {},
        errorMessage: ""
    }
    try{
        const response = await fetch(
            `${SERVER_URL}/add`, 
            { 
                method: 'POST', 
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(formData)                
            }
        )       

        responseMessage = await response.json()

        if(response.ok){
            submission_output.success = true
        } else {
            if(response.status == "422"){
                submission_output.validationErrors = responseMessage
                submission_output.errorMessage = "Please check the form for errors:"
            } else {
                submission_output.errorMessage = responseMessage
            }
            submission_output.status = response.status,
            submission_output.success = false
            
        }
    } catch(error){
        console.log("Error", error)
    }
    res.redirect('/?success=true');
});

app.get('/', (req, res) => {

    const success = req.query.success === 'true';

    res.render('index', { 
        title: 'Registration form', 
        submission: success,
        formData: { name: "", age: ""},
        submission_output: { success }
    });
});


app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});
