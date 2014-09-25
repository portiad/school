<?php

    // configuration
    require("../includes/config.php");

    // if form was submitted
    if ($_SERVER["REQUEST_METHOD"] == "POST")
    {
        //query for money in users account
        $rowuser = query("SELECT * FROM users WHERE id = ?", $_SESSION["id"]);
        $rowuser = $rowuser[0];

        $share = preg_match("/^\d+$/", $_POST["deposit"]);

        if ($share == 0 || is_null($_POST["bank"]))
        {
            apologize("Please select a bank and enter in the amount of money to deposit");
        }
        else //buy stock
        {
            $newcash = $rowuser["cash"] + $_POST["deposit"];

            $update = query("UPDATE users set cash = ? where id = ? ", $newcash, $_SESSION["id"]);

            redirect("/");

        }
    }
    else
    {
        // else render form
        render("deposit_form.php", ["title" => "Buy"]);
    }
