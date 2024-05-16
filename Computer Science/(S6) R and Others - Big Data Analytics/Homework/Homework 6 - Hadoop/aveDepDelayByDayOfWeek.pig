flights = load '2008.csv' using PigStorage(',');
flight_details = FOREACH flights GENERATE $3 as dayOfWeek, (int)$15 as depDelay;
grp_airline = GROUP flight_details by dayOfWeek;
aveDepDelayByDayOfWeekPigResults = foreach grp_airline generate group, AVG(flight_details.depDelay);
store aveDepDelayByDayOfWeekPigResults into 'Pig_dayOfWeek_AveDepDelay';
