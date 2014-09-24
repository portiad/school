<table class="table table-striped">
    <thead>
        <tr>
            <th>Transaction</th>
            <th>Date/Time</th>
            <th>Symbol</th>
            <th>Shares</th>
            <th>Price</th>
        </tr>
    </thead>

    <?php
        foreach ($rows as $row)
        {
            $datetime = date("m-d-Y H:m", strtotime($row["datetime"]));
            $price = number_format($row["price"],2);
            
            print("<tr>");
            print("<td>{$row["type"]}</td>");
            print("<td>{$datetime}</td>");
            print("<td>{$row["symbol"]}</td>");
            print("<td>{$row["shares"]}</td>");
            print("<td>$ {$price}</td>");
            print("</tr>");
        }
	?>
</table>