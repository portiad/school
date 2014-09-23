//TODO!!

<?php

    // configuration
    require("../includes/config.php");

    // if form was submitted
    if ($_SERVER["REQUEST_METHOD"] == "POST")
    {


        //query for money in users account
        $row = query("SELECT * FROM users WHERE id = ?", $_SESSION["id"]);
        $row = $row[0];

        //determine the cost for buying the stocks
        $stock = lookup($_POST["symbol"]);
        $cost = $stock["price"] * $_POST["share"];
        $test = $row["cash"] - $cost;
        //determine if user has enough to cover
        //buy stock
        
        if ($stock === false)
        {
            apologize("Symbol not found.");
        }

        else if ($test < 0)
        {

            apologize("You can't afford that.");
        }
        else
        {

           $result = query("INSERT INTO transactions (id, symbol, shares) VALUES(?, ?, ?)", $_SESSION["id"], $_POST["symbol"], $_POST["share"]);
           $update = query("UPDATE users where id = ? (cash) VALUES(?)", $_SESSION["id"], $test);

            redirect("/");
        }
    }
    else
    {
        // else render form
        render("buy_form.php", ["title" => "Buy"]);
    }
