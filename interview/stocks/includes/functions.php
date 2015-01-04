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
        $start = explode('-', date('m-d-Y', strtotime("-6 months");
        $end = explode('-', date('m-d-Y');

        $start_day = $start[1];
        $start_month = $start[0] - 1;
        $start_year = $start[2];

        $end_day = $end[1];
        $end_month = $end[0] - 1;
        $end_year = $end[2];

        // open connection to Yahoo
        $handle = @fopen("http://ichart.finance.yahoo.com/table.csv?s=$symbol&a=$start_month&b=$start_day&c=$start_year&d=$end_month&e=$end_month&f=$end_year&g=d&ignore=.csv", "r");
//TODO how to read and store each line of the file

        if ($handle === false){
            // trigger (big, orange) error
            trigger_error("Could not connect to Yahoo!", E_USER_ERROR);
            exit;
        }

        // download header of CSV file
        $header = fgetcsv($handle);

        // values to track for highest profit
        $low_price = NULL;
        $low_date = NULL;
        $high_price = NULL;
        $high_date = NULL;
        $profit = NULL;

        while ($line = fgetcsv($handle)){
	        if ($data === false || count($data) == 1){
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
        		$profit = $line[2] - $low_price
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
            "low price" => $low_price,
            "low date" => $low_date,
            "high price" => $high_price,
            "high date" => $high_date,
            "profit" => $profit,
        ];
    }