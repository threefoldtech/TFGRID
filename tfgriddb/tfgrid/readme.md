# TF Grid DB client

## Usage

```v
// Create a new instance of the client
mut tfgrid := tfgrid.tfgrid_new() ?
```

## List entities

```
entities := tfgrid.entity_list()?
println(entities)
```

## Get Entity by ID

```
entity := tfgrid.entity_get_by_id(1) ?
print(entity)
```

## List twins

```
twins := tfgrid.twin_list()?
println(twins)
```

## Get Twin by ID

```
twin := tfgrid.twin_get_by_id(1) ?
print(twin)
```

## List nodes

```
nodes := tfgrid.nodes_list()?
println(nodes)
```

## Get Node by ID

```
node := tfgrid.nodes_get_by_id(1) ?
print(node)
```

## Get Nodes by resource values

```
sru := 150
cru := 2 
hru := 3000
mru := 5

nodes_by_resources := tfgrid.nodes_list_by_resource(sru, cru, hru, mru)?
println(nodes_by_resources)
```

## List farms

```
farms := tfgrid.farms_list()?
println(farms)	
```

## Get farm by ID

```
farm := tfgrid.farm_get_by_id(1) ?
print(farm)
```

## List countries

```
countries := tfgrid.countries_list()?
println(countries)
```

## Get country by substring in name

```
countries_by_name_substring := tfgrid.countries_by_name_substring("elgium")?
println(countries_by_name_substring)
```

## Get country by ID

```
country_by_id := tfgrid.country_by_id(65)?
println(country_by_id)
```

## List cities

```v
cities := tfgrid.cities_list()?
println(cities)
```
	
## Get cities by substring in name

```
cities_by_name_substring := tfgrid.cities_by_name_substring("hent")?
println(cities_by_name_substring)
```

## Get city by ID

```
city_by_id := tfgrid.city_by_id(65)?
println(city_by_id)
```

## Get city by country_id

```
cities_by_country_id := tfgrid.cities_by_country_id(65)?
println(cities_by_country_id)
```