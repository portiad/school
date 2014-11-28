<form action="deposit.php" method="post">
    <fieldset>
       <div class="form-group">
            <select autofocus class="form-control" name="bank">
                <option value=""> </option>
                <option value = "bofa">Bank of America</option>
                <option value = "capone" >Capital One</option> 
                <option value = "chase">Chase</option>
                <option value = "wells">Wells Fargo</option>
            </select>
        </div>
        <div class="form-group">
            <input class="form-control" name="deposit" placeholder="Deposit Amount" type="text"/>
        </div>
        <div class="form-group">
            <button type="submit" class="btn btn-default">Deposit</button>
        </div>
    </fieldset>
</form>
