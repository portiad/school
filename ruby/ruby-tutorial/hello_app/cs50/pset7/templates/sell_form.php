<?php $stocks = query("SELECT * FROM stocks where id = ?", $_SESSION["id"]); 
?>

<form action="sell.php" method="post">
    <fieldset>
       <div class="form-group">
            <select autofocus class="form-control" name="symbol">
                <option value=""> </option>
                <?php foreach($stocks as $stock): ?>
                    <option value = "<?= $stock["symbol"] ?>" ><?= $stock["symbol"] ?></option>
                <? endforeach ?>
            </select>
        </div>
        <div class="form-group">
            <input class="form-control" name="shares" placeholder="Shares" type="text"/>
        </div>
        <div class="form-group">
            <button type="submit" class="btn btn-default">Sell</button>
        </div>
    </fieldset>
</form>