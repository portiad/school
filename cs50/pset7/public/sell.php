<?php

    // configuration
    require("../includes/config.php");

    // if form was submitted
    if ($_SERVER["REQUEST_METHOD"] == "POST")
    {
        $stock = lookup($_POST["symbol"]);
        $share = preg_match("/^\d+$/", $_POST["shares"]);
        
        if ($stock === false || $share ===false || $_POST["shares"] < 1)
        {
            apologize("Please select a stock and number of shares to sell");
        }
        else //buy sell stock
        {
            //query if user already owns this stock
            $rowtrans = query("SELECT * FROM stocks WHERE id = ? and symbol = ?", $_SESSION["id"], $stock["symbol"]);
            $rowtrans = $rowtrans[0];
            $newshares = $rowtrans["shares"] - $_POST["shares"];

            if ($newshares < 0) // selling more stock than you own
            {
                apologize("You are selling more than the shares you own. You have " .  $rowtrans["shares"] . " shares to sell of " . $rowtrans["symbol"] . ".");
            }
            else if ($newshares == 0) // remove stocks that become 0
            {
                $delete = query("DELETE FROM stocks WHERE id = ? and symbol = ?", $_SESSION["id"], $stock["symbol"]);
            }
            else // update stock amount if gt 0
            {
                $result = query("UPDATE stocks set shares = ? where id = ? and symbol = ?", $newshares, $_SESSION["id"], $stock["symbol"]);
            }

            $rowuser = query("SELECT * FROM users WHERE id = ?", $_SESSION["id"]);
            $rowuser = $rowuser[0];
            $newcash = $rowuser["cash"] + ($stock["price"] * $_POST["shares"]);

            // insert into transaction table sell and update the cash amount in the users table
            $insert = query("INSERT INTO history (id, type, symbol, shares, price) VALUES(?, ?, ?, ?, ?)", $_SESSION["id"], "Sell", $stock["symbol"], $_POST["shares"], $stock["price"]);
            $update = query("UPDATE users set cash = ? where id = ? ", $newcash, $_SESSION["id"]);

            redirect("/");
        }
    }
    else
    {
        // else render form
        render("sell_form.php", ["title" => "Sell"]);
    }
