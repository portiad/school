//TODO!!!

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
    		//return back name, symbol and price and display to user an example of: A share of Limelight Network (LLNW) costs $2.45.
    		$stock["name"]
    		$stock["symbol"]
    		$stock["price"]
        }
    }
    else
    {
        // else render form
        render("quote_form.php", ["title" => "Get Quote"]);
    }

?>