## Data model:

- Lines
* line_name
* line_number

Lines have many stations.

- Stations
* line_id (reference)
* station_name
* station_number
* status (boolean)
* established_at (date)
* lat/long (array?)

Stations belong to lines.
Stations have many data sets embedded in them.

- Data sets
* year (year)
* subject (string)
* data (float)

Lines should return list of stations.
Stations should return data points, by year. 

