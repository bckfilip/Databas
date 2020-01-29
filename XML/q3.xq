(: Returnerar lista med alla länder + dess sjöar:)
let $sjöland := for $countries in /mondial/country
let $country := data($countries/@car_code)
  for $lakes in /mondial/lake
    for $code in $lakes/located/@country
      where $code = $country
      group by $country
      order by count($lakes) descending  
return
<land namn="{$countries/name}" lakes="{distinct-values(count($lakes/name))}"></land>


(:Gruppera antal länder enligt ett visst antal sjöar:)
let $bla := for $lake in distinct-values($sjöland/@lakes)
  let  $count := count($sjöland[@lakes = $lake])
  order by $count descending
    
return <country amount="{$count}">, lakes="{$lake}"
</country>

(:Returnerar det första värdet:)
return $bla[1]