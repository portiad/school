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
        $_POST["symbol"] = strtoupper($_POST["symbol"]);
        $stock = lookup($_POST["symbol"]);
        $cost = $stock["price"] * $_POST["shares"];
        $newcash = $rowuser["cash"] - $cost;

        $share = preg_match("/^\d+$/", $_POST["shares"]);
        
        if ($stock === false || $share === 0)
        {
            apologize("Symbol or shares you entered in are not correct.");
        }
        else if ($newcash < 0) //determine if user has enough to cover
        {
            apologize("You can't afford that.");
        }
        else //buy stock
        {
            $rowtrans = query("SELECT * FROM stocks WHERE id = ? and symbol = ?", $_SESSION["id"], $_POST["symbol"]);
            $rowtrans = $rowtrans[0];

            if ($rowtrans == false) // user does not own stock, insert it in
            {
                $result = query("INSERT INTO stocks (id, symbol, shares) VALUES(?, ?, ?)", $_SESSION["id"], $_POST["symbol"], $_POST["shares"]);
            }
            else // user does have the stock, update it
            {
                $newshares = $rowtrans["shares"] + $_POST["shares"];
                $result = query("UPDATE stocks set shares = ? where id = ? ", $newshares, $_SESSION["id"]);
            } 
            
            //update cash balance & insert into history
            $insert = query("INSERT INTO history (id, type, symbol, shares, price) VALUES(?, ?, ?, ?, ?)", $_SESSION["id"], "Buy", $_POST["symbol"], $_POST["shares"], $stock["price"]);
            $update = query("UPDATE users set cash = ? where id = ? ", $newcash, $_SESSION["id"]);

            redirect("/");

        }
    }
    else
    {
        // else render form
        render("buy_form.php", ["title" => "Buy"]);
    }
