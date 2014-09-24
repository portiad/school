<?php $holdings = 0; $balance = 0; ?>

<table class="table table-striped">
    <thead>
        <tr>
            <th>Symbol</th>
            <th>Shares</th>
            <th>Price</th>
            <th>Total</th>
        </tr>
    </thead>

    <?php
        // print all the stocks the user owns
        $rows = query("SELECT symbol, shares FROM stocks WHERE id = ?", $_SESSION["id"]);
        
        foreach ($rows as $row)
        {
       	    $stock = lookup($row["symbol"]);
       	    $total = number_format($stock["price"] * $row["shares"],2);
            $price = number_format($stock["price"],2);
            $holdings += $stock["price"] * $row["shares"];
            
            print("<tr>");
            print("<td>{$row["symbol"]}</td>");
            print("<td>{$row["shares"]}</td>");
            print("<td>$ {$price}</td>");
            print("<td>$ {$total}</td>");
            print("<tr>");
        }
    ?>
    <tr>
        <td colspan="3" style="text-align:left">Cash</td>
            <?php
                // print the final cash balalnce
                $balance = query("SELECT cash FROM users WHERE id = ?", $_SESSION["id"]);
                $balance = $balance[0]["cash"];            
                $cash = number_format($balance, 2);
                print("<td>$ {$cash}</td>");
            ?>
    </tr>
    
    <tfoot>
        <tr>
            <td colspan="3" style="text-align:left"><b>Total</b></td>
            <?php
                $totalbalance = number_format($holdings + $balance,2);
                print("<td><b>$ {$totalbalance}</b></td>");
            ?>
        </tr>
    </tfoot>
</table>