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
	        render("quote.php",["title" => "Quote","price" => $stock["price"], "name" => $stock["name"], "symbol" => $stock["symbol"]] );
        }
    }
    else
    {
        // else render form
        render("quote_form.php", ["title" => "Get Quote"]);
    }

?>