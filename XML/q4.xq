(:all cities with <900 000 inhabs:)
let $cities := for $city in (/mondial/country/city, /mondial/country/province/city)
let $year := max(data($city/population/@year))
  where data($city/population[@year = $year]) >= 900000
return $city

(:variables for calculation :)
let $R := 6371
let $pi := 0.017453292519943295 (:3.14 / 180:)

let $distances :=(
for $one at $pos in $cities
let $latiOne := $one/latitude
let $longiOne := $one/longitude
for $two in subsequence($cities, $pos)
let $latiTwo := $two/latitude
let $longiTwo := $two/longitude

let $a := 0.5 - math:cos(($latiTwo - $latiOne)*$pi) div 2 + math:cos($latiOne*$pi) * math:cos($latiTwo*$pi) * (1 - math:cos(($longiTwo - $longiOne)*$pi)) div 2
let $dis := 12742 * math:asin(math:sqrt($a))

return <point>
{$one}
{$two}
<distance>{$dis}</distance>
</point>
)

let $max := max($distances/distance)
for $furthest in $distances
where $furthest/distance = $max

return $furthest


