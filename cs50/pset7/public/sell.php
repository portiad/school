<?php

    // configuration
    require("../includes/config.php");

    // if form was submitted
    if ($_SERVER["REQUEST_METHOD"] == "POST")
    {
        $stock = lookup($_POST["symbol"]);

        
        if ($stock === false)
        {
            apologize("Please select a stock to sell.");
        }
        else //buy sell stock
        {
            //query if user already owns this stock
            $rowtrans = query("SELECT * FROM transactions WHERE id = ? and symbol = ?", $_SESSION["id"], $_POST["symbol"]);
            $shares = 0;

            foreach ($rowtrans as $rowtrans)
            {
                $shares = $shares + $rowtrans["shares"];
            }   

            $newshares = $shares - $_POST["shares"];

            if ($newshares < 0) // selling more stock than you own
            {
                apologize("You are selling more than the shares you own. You have " .  $shares . " shares to sell of " . $rowtrans["symbol"] . ".");
            }
            else
            {
                $rowuser = query("SELECT * FROM users WHERE id = ?", $_SESSION["id"]);
                $rowuser = $rowuser[0];
                $newcash = $rowuser["cash"] + ($stock["price"] * $_POST["shares"]);

                // insert into transaction table sell and update the cash amount in the users table
                $result = query("UPDATE stocks set shares = ? where id = ? ", $newshares, $_SESSION["id"]);
                $insert = query("INSERT INTO history (id, type, symbol, shares, price) VALUES(?, ?, ?, ?, ?)", $_SESSION["id"], "Sell", $_POST["symbol"], $_POST["shares"], $stock["price"]);
                $update = query("UPDATE users set cash = ? where id = ? ", $newcash, $_SESSION["id"]);

                redirect("/");
            }
        }
    }
    else
    {
        // else render form
        render("sell_form.php", ["title" => "Sell"]);
    }
