CREATE INDEX airlinecd_idx ON `splash`(airlinecd);
CREATE INDEX airlineCntry_idx ON `splash`(airlineCntry_idx);

CREATE INDEX depAirportCty_idx ON `splash`(depAirportCty);
CREATE INDEX arrAirportCty_idx ON `splash`(arrAirportCty

-- find flights out of bozeman
select * from splash where arrAirportCty='Bozeman'
