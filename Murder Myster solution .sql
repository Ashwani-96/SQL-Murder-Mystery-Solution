-- description of the crime scene
select description from crime_scene_report
where type = 'murder' and city='SQL City' and date = '20180115';

-- result set
/*description
Security footage shows that there were 2 witnesses. 
The first witness lives at the last house on "Northwestern Dr". 
The second witness, named Annabel, lives somewhere on "Franklin Ave".
*/

-- search for details of the witnesses in the person table

-- first witness

select * from person where address_street_name like 'Northwestern Dr%'   
order by address_number desc 
limit 1;

-- second witness

select *  from person where name like "Annabel%" and address_street_name like "Franklin Ave";

-- get interview details of the witnesses from interview table

select * from interview where person_id in ("16371", "14887");

-- result set
/*person_id	transcript
14887	    I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W".
16371	    I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.
*/

-- get the names of suspects

select get_fit_now_member.name, get_fit_now_member.person_id
from get_fit_now_member 
join get_fit_now_check_in  
on get_fit_now_check_in.membership_id=get_fit_now_member.id
where  check_in_date = "20180109" 
and membership_id like '48Z%'
and membership_status = "gold";

-- result set (suspects)
/*
check_in_time	check_out_time	    name	        person_id	membership_status
1600	        1730	        Joe Germuska	    28819	    gold
1530	        1700	        Jeremy Bowers	    67318	    gold
*/

select person.name, person.ssn, drivers_license.gender, drivers_license.plate_number, drivers_license.age, person.id
from drivers_license 
join person on drivers_license.id = person.license_id
where drivers_license.plate_number like "%H42W%" and person.id = "28819" or person.id=  "67318";

-- result set(murder)
/*
name	            ssn	    gender	plate_number	age	id
Jeremy Bowers	871539279	male	0H42W2	        30	67318
*/
 
-- details of the murder

select * from person where id = 67318;

-- result set (murder's detail)
/*
id	        name	    license_id	address_number	address_street_name	        ssn
67318	Jeremy Bowers	423327	        530	        Washington Pl, Apt 3A	    871539279
*/

-- transcript of murder
select * from interview where person_id = "67318";

-- result set (mastermind/real villian)
/*
I was hired by a woman with a lot of money.
I don't know her name but I know she's around 5'5" (65") or 5'7" (67").
She has red hair and she drives a Tesla Model S.
SQL Symphony Concert 3 times in December 2017.

*/
-- SQL Symphony Concert 3 times in December 2017 

select person_id, count(*), event_name
from facebook_event_checkin 
group by person_id
having count(*) = 3 and event_name = "SQL Symphony Concert" and date like "%201712%";

-- result set
/*
person_id	count(*)	event_name
19292   	  3	        SQL Symphony Concert
24556	      3	        SQL Symphony Concert
58898	      3	        SQL Symphony Concert
99716	      3	        SQL Symphony Concert
*/

select * from drivers_license join
person on drivers_license.id= person.license_id
where person.id in ( "19292", "24556", "58898", "99716") 
and drivers_license.hair_color ="red" 
and drivers_license.height between 65 and 67 
and drivers_license.car_make = "Tesla" 
and drivers_license.car_model = "Model S"

-- details of the mastermind
/*
id	    age	height	eye_color	hair_color	gender	plate_number	car_make	car_model	id	        name	            license_id	        address_number	    address_street_name	    ssn
202298	68	66	    green	    red	        female	500123	        Tesla	      Model S	99716	    Miranda Priestly	202298	                1883	        Golden Ave	            987756388
*/
-- So, person named "Miranda Priestly" is the real mastermind







