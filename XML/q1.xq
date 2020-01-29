let $nice := <parent>{for $continent in (/mondial/continent)
let $continame := data($continent/@id)
return <continent name="{$continame}">{
  for $country in /mondial/country
  where data($country/encompassed/@continent) = $continame
    for $city in (/mondial/country/city, /mondial/country/province/city)
    let $land := data($country/name)
    let $year := max(data($city/population/@year))
      where data($city/@id) = data($country/@capital)
      and data($city/population[@year = $year]) >= 3000000
      return <country name="{$land}" capital="{data($city/name)}"> 
      </country>
}</continent>
}</parent>

return $nice