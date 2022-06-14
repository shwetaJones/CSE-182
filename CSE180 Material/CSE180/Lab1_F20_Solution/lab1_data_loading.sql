-- Sample Script file to Populate the Lab1 DB
-- Populate the tables

COPY Houses FROM stdin USING DELIMITERS '|';
111|1156 High Street,Santa Cruz,CA, 95060|10|2018-06-23
222|324 Ghost Ave,Vegas,NV,55864|5|2020-04-16
333|920 Pacific Ave,Santa Cruz,CA,95069|6|2016-03-18
444|41st Ave,Capitola,CA,95662|7|2017-11-30
555|416 116th Ave NE, Bellevue, WA 98004|8|2018-09-26
\.

COPY Persons FROM stdin USING DELIMITERS '|';
1|John Wick|340 High Street,Santa Cruz,CA,95060
2|Steve Vai|111 Bay Street Santa Cruz,CA,95060
3|Harrison Ford|120 Westlake,Seattle,WA,98109
4|Brad Pitt|111 Mission Street,Santa Cruz,CA,95060
5|George Mata|324 Ghost Ave,Vegas,NV,55864
6|Maria Santos Tavares Melo Jose|920 Pacific Ave,Santa Cruz,CA,95069
7|Huan Halvorson|41st Ave,Capitola,CA,95662 
8|Warner Mandela|344 High Street,Santa Cruz,CA,95060
9|Effertz Hara|928 Pacific Ave,Santa Cruz,CA,95069
10|Labadie Ward|1156 High Street,Santa Cruz,CA,95060
13|Chris Sporer|110 Roy Street,Seattle,WA,98106
16|Alicia Biden|320 Highland,Santa Cruz,CA,95060
17|Kassulke Feil|711 Roy Street,Seattle,WA,98104
18|Boris Rohan|7055 SouthWest Fort Apache Road,Las Vegas,NV 89148
20|Alex Robinson|1816 Westlake,Seattle,WA,98110
\.

COPY Brokers FROM stdin USING DELIMITERS '|';
1|A|Lighthouse Realty|12
11|C|Weathervane Group Realty|14
20|B|Catbird Estates|14
18|B|Champions Real Estate Advisors|5
17|D|Weathervane Group Realty|23
\.

COPY Offers FROM stdin USING DELIMITERS '|';
111|13|2019-07-27|854559.55|FALSE
111|13|2019-07-26|853559.55|FALSE
111|2|2019-07-27|855559.80|TRUE
222|16|2020-06-20|12750000.55|TRUE
333|6|2017-05-28|400000.76|TRUE
\.


COPY ForSaleHouses FROM stdin USING DELIMITERS '|';
111|2019-06-24|1|850000.34|TRUE
111|2018-05-23|1|840000.34|FALSE
222|2020-05-08|17|15750000.99|TRUE
222|2020-03-15|18|15850000.99|FALSE
333|2017-05-20|17|410000|TRUE
333|2016-02-10|18|440000|FALSE
444|2017-09-01|20|200000.33|FALSE
444|2018-11-21|20|250000.33|TRUE
444|2016-08-16|20|250000.33|FALSE
555|2018-05-26|11|4600000.45|FALSE
\.

COPY SoldHouses FROM stdin USING DELIMITERS '|';
111|2018-05-23|2018-06-23|5|833000.34
222|2020-03-15|2020-04-16|1|15850000.99
333|2016-02-10|2016-03-18|8|440000
444|2017-09-01|2017-11-30|9|200000.33
444|2016-08-16|2016-09-24|4|250000.33
555|2018-05-26|2018-09-26|7|4700000.45
\.
