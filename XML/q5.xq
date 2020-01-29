declare function local:population($lat as xs:decimal?) as xs:double?
{
let $c1 := for $cities in (
  db:open("mondial")/mondial/country/city, 
  db:open("mondial")/mondial/country/province/city)
where $cities[latitude >= $lat]
  let $year := max(data($cities/population/@year))      
  let $sum := $cities/population[@year = $year]
return data($sum)

let $c2 := for $cities in (
  db:open("mondial")/mondial/country/city, 
  db:open("mondial")/mondial/country/province/city)
where $cities[latitude >= 0] and $cities[latitude < $lat]
  let $year := max(data($cities/population/@year))      
  let $sum := $cities/population[@year = $year]
return data($sum)

let $pop1 := sum($c1)
let $pop2 := sum($c2)
let $ratio := $pop1 div $pop2
return $ratio
};

let $ratios := for $lat in (1 to 90)
let $ratio := local:population($lat)
return <value lat="{$lat}" ratio="{abs($ratio -1)}"></value>

return $ratios[@ratio = min($ratios/@ratio)]