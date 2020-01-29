(: All seas with its borders(>0:)
let $seaNborders := for $seas in /mondial/sea
let $numbOfBorders := count(tokenize(data(/$seas/@bordering), "\s+"))
  
return <sea name="{$seas/name}" borders="{$numbOfBorders}">
</sea>

let $max := max(data($seaNborders/@borders))
return $seaNborders[data(@borders) = $max]
