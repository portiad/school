//TODO!!

<?php

    // configuration
    require("../includes/config.php");

    // if form was submitted
    if ($_SERVER["REQUEST_METHOD"] == "POST")
    {
        //query for money in users account
        //determine the cost for buying the stocks
        //determine if user has enough to cover
        //buy stock
        
        $result = query("SELECT * FROM users WHERE username = ?", $_POST["username"]);
        
        if ($result === false)
        {
            apologize("Username is taken. Choose another one. ");
        }
        else
        {
            $rows = query("SELECT LAST_INSERT_ID() AS id");
            $id = $rows[0]["id"];

            $_SESSION["id"] = $id;

            redirect("/");
        }
    }
    else
    {
        // else render form
        render("buy_form.php", ["title" => "Register"]);
    }
