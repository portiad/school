<?php

    // configuration
    require("../includes/config.php");

    // if form was submitted
    if ($_SERVER["REQUEST_METHOD"] == "POST")
    {
        $stock = lookup($_POST["symbol"]);       
        
        if ($stock === false)
        {
            apologize("Symbol not found.");
        }
        else
        {
            render("stocks.php",["title" => "Highest Profit", 
            "symbol" => $stock["symbol"], 
            "low_price" => $stock["low_price"],
            "low_date" => $stock["low_date"],
            "high_date" => $stock["high_date"],
            "high_price" => $stock["high_price"],
            "profit" => $stock["profit"]] );
        }
    }
    else
    {
        // else render form
        render("stocks_form.php", ["title" => "Calculate Profit"]);
    }
?>