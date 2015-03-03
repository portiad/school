<?php

    function lookup($symbol)
    {
        // reject symbols that start with ^
        if (preg_match("/^\^/", $symbol)){
            return false;
        }

        // reject symbols that contain commas
        if (preg_match("/,/", $symbol)){
            return false;
        }

        //parse out and get today's date and 6 months from today's date
        date_default_timezone_set('America/Los_Angeles');
        $start = explode('-', date('m-d-Y', strtotime("-6 months")));
        $end = explode('-', date('m-d-Y'));

        $start_day = $start[1];
        $start_month = $start[0] - 1;
        $start_year = $start[2];

        $end_day = $end[1];
        $end_month = $end[0] - 1;
        $end_year = $end[2];

        // open connection to Yahoo
        $handle = @fopen("http://ichart.finance.yahoo.com/table.csv?s=$symbol&a=$start_month&b=$start_day&c=$start_year&d=$end_month&e=$end_day&f=$end_year&g=d&ignore=.csv", "r");


        if ($handle === false){
            // trigger (big, orange) error
            trigger_error("Could not connect to Yahoo!", E_USER_ERROR);
            exit;
        }

        // download header of CSV file
        $header = fgetcsv($handle);

        // values to track for highest profit
        $initial = fgetcsv($handle);
        $low_price = $initial[3];
        $low_date = $high_date = $initial[0];
        $high_price = $initial[2];
        $profit = $initial[2] - $initial[3]; 

        while ($line = fgetcsv($handle)){
	        if ($line === false || count($line) == 1){
	            return false;
	        }
        	if ($high_price - $line[3] > $profit){
        		$low_price = $line[3];
        		$low_date = $line[0];
        		$profit = $high_price - $line[3];
        	}
        	if ($line[2] - $low_price > $profit){
        		$high_price = $line[2];
        		$high_date = $line[0];
        		$profit = $line[2] - $low_price;
        	}
        	if ($line[2] - $line[3] > $profit){
        		$low_price = $line[3];
        		$low_date = $high_date = $line[0];
        		$high_price = $line[2];
        		$profit = $line[2] - $line[3]; 
        	}
        }

        // close connection to Yahoo
        fclose($handle);

        // return stock as an associative array
        return [
            "symbol" => $symbol,
            "low_price" => $low_price,
            "low_date" => date("m/d/Y", strtotime($low_date)),
            "high_date" => date("m/d/Y", strtotime($high_date)),
            "high_price" => $high_price,
            "profit" => $profit,
            /* testing data
            "start_day" => $start_day,
            "start_month" => $start_month,
            "start_year" => $start_year,
            "end_day" => $end_day,
            "end_month" => $end_month,
            "end_year" => $end_year,
            */
        ];
    }

    function render($template, $values = [])
    {
        // if template exists, render it
        if (file_exists("../templates/$template"))
        {
            // extract variables into local scope
            extract($values);

            // render header
            require("../templates/header.php");

            // render template
            require("../templates/$template");
        }

        // else err
        else
        {
            trigger_error("Invalid template: $template", E_USER_ERROR);
        }
    }
?>