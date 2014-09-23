<form action="sell.php" method="post">
    <fieldset>
       <div class="form-group">
            <select class="form-control" name="symbol">
                <option value=""> </option>
            </select>
        </div>
        <div class="form-group">
            <input autofocus class="form-control" name="shares" placeholder="Shares" type="text"/>
        </div>
        <div class="form-group">
            <button type="sell" class="btn btn-default">Sell</button>
        </div>
    </fieldset>
</form>
