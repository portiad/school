<?php

    // configuration
    require("../includes/config.php");

    // if form was submitted
    if ($_SERVER["REQUEST_METHOD"] == "POST")
    {
        //query for money in users account
        $rowuser = query("SELECT * FROM users WHERE id = ?", $_SESSION["id"]);
        $rowuser = $rowuser[0];

        //determine the cost for buying the stocks
        $stock = lookup($_POST["symbol"]);
        $cost = $stock["price"] * $_POST["shares"];
        $newcash = $rowuser["cash"] - $cost;
        
        if ($stock === false)
        {
            apologize("Symbol not found.");
        }
        else if ($newcash < 0) //determine if user has enough to cover
        {
            apologize("You can't afford that.");
        }
        else //buy stock
        {
            //query if user already owns this stock
            $rowtrans = query("SELECT * FROM transactions WHERE id = ? and symbol = ?", $_SESSION["id"], $_POST["symbol"]);
            $rowtrans = $rowtrans[0];
            $newshares = $rowtrans["shares"] + $_POST["shares"];

            if ($rowtrans == false) // user does not own stock, insert it in
            {
                $result = query("INSERT INTO transactions (id, symbol, shares) VALUES(?, ?, ?)", $_SESSION["id"], $_POST["symbol"], $_POST["shares"]);
            }
            else // user does have the stock, update it
            {
                $result = query("UPDATE transactions set shares = ? where id = ? ", $newshares, $_SESSION["id"]);
            }

            //update cash balance
            $update = query("UPDATE users set cash = ? where id = ? ", $newcash, $_SESSION["id"]);

            redirect("/");
        }
    }
    else
    {
        // else render form
        render("buy_form.php", ["title" => "Buy"]);
    }
