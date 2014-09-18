<?php

    // configuration
    require("../includes/config.php");

    // if form was submitted
    if ($_SERVER["REQUEST_METHOD"] == "POST")
    {
        $result = query("INSERT INTO users (username, hash, cash) VALUES(?, ?, 10000.00)", $_POST["username"], crypt($_POST["password"]));
        
        if ($result === true)
        {
            apologize("Username is taken. Choose another one. ");
        }
        else
        {
            $rows = query("SELECT LAST_INSERT_ID() AS id");
            $id = $rows[0]["id"];
            
            $_SESSION["id"] = $row["id"];

            redirect("/");

        }
    }
    else
    {
        // else render form
        render("register_form.php", ["title" => "Register"]);
    }

?>