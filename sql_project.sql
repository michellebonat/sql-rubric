/* Q1: Some of the facilities charge a fee to members, but some do not.
Please list the names of the facilities that do. */
name
Tennis Court 1
Tennis Court 2
Massage Room 1
Massage Room 2
Squash Court

SELECT name
FROM  `Facilities` 
WHERE membercost >0
LIMIT 0 , 30



/* Q2: How many facilities do not charge a fee to members? */
4

SELECT COUNT( name ) 
FROM  `Facilities` 
WHERE membercost =0


/* Q3: How can you produce a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost?
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */
2
Badminton Court
0.0
50

4
Massage Room 1
9.9
3000

5
Massage Room 2
9.9
3000

8
Pool Table
0.0
15

7
Snooker Table
0.0
15

6
Squash Court
3.5
80

3
Table Tennis
0.0
10

0
Tennis Court 1
5.0
200

1
Tennis Court 2
5.0
200


SELECT facid, name, membercost, monthlymaintenance
FROM Facilities
WHERE membercost < ( monthlymaintenance * 0.2 ) 


/* Q4: How can you retrieve the details of facilities with ID 1 and 5?
Write the query without using the OR operator. */

SELECT * 
FROM Facilities
WHERE facid IN (1, 5) 


/* Q5: How can you produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100? Return the name and monthly maintenance of the facilities
in question. */

SELECT name, monthlymaintenance,
CASE WHEN monthlymaintenance > 100 THEN 'expensive'
ELSE 'cheap' END AS expensive_or_cheap
FROM Facilities
LIMIT 0 , 30

name
monthlymaintenance
expensive_or_cheap
Tennis Court 1
200
expensive
Tennis Court 2
200
expensive
Badminton Court
50
cheap
Table Tennis
10
cheap
Massage Room 1
3000
expensive
Massage Room 2
3000
expensive
Squash Court
80
cheap
Snooker Table
15
cheap
Pool Table
15
cheap


/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Do not use the LIMIT clause for your solution. */

SELECT firstname, surname
FROM Members
WHERE joindate = (
SELECT MAX(joindate) 
FROM Members)

firstname
surname
Darren
Smith

Note: this query returns the last member to sign up. 

/* Q7: How can you produce a list of all members who have used a tennis court?
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */

SELECT DISTINCT CONCAT_WS(' ', firstname, surname) AS full_name, name
FROM Bookings
JOIN Facilities ON Bookings.facid = Facilities.facid
JOIN Members ON Bookings.memid = Members.memid
WHERE Bookings.facid IN (0,1)
ORDER BY full_name

full_name Descending
name
Anne Baker
Tennis Court 1
Anne Baker
Tennis Court 2
Burton Tracy
Tennis Court 1
Burton Tracy
Tennis Court 2
Charles Owen
Tennis Court 2
Charles Owen
Tennis Court 1
Darren Smith
Tennis Court 2
David Farrell
Tennis Court 1
David Farrell
Tennis Court 2
David Jones
Tennis Court 1
David Jones
Tennis Court 2
David Pinker
Tennis Court 1
Douglas Jones
Tennis Court 1
Erica Crumpet
Tennis Court 1
Florence Bader
Tennis Court 2
Florence Bader
Tennis Court 1
Gerald Butters
Tennis Court 1
Gerald Butters
Tennis Court 2
GUEST GUEST
Tennis Court 1
GUEST GUEST
Tennis Court 2
Henrietta Rumney
Tennis Court 2
Jack Smith
Tennis Court 1
Jack Smith
Tennis Court 2
Janice Joplette
Tennis Court 1
Janice Joplette
Tennis Court 2
Jemima Farrell
Tennis Court 1
Jemima Farrell
Tennis Court 2
Joan Coplin
Tennis Court 1
John Hunt
Tennis Court 1
John Hunt
Tennis Court 2

/* Q8: How can you produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30? Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */

SELECT name, 
       CONCAT_WS(' ', firstname, surname) AS full_name, 
       CASE WHEN Bookings.memid = 0 THEN (guestcost * slots) ELSE (membercost * slots) END AS cost
FROM Bookings
JOIN Facilities ON Bookings.facid = Facilities.facid
JOIN Members ON Bookings.memid = Members.memid
WHERE starttime LIKE '2012-09-14%' AND CASE WHEN Bookings.memid = 0 THEN (guestcost * slots) ELSE (membercost * slots) END > 30
ORDER BY cost DESC

name
full_name
cost Descending
Massage Room 2
GUEST GUEST
320.0
Massage Room 1
GUEST GUEST
160.0
Massage Room 1
GUEST GUEST
160.0
Massage Room 1
GUEST GUEST
160.0
Tennis Court 2
GUEST GUEST
150.0
Tennis Court 1
GUEST GUEST
75.0
Tennis Court 2
GUEST GUEST
75.0
Tennis Court 1
GUEST GUEST
75.0
Squash Court
GUEST GUEST
70.0
Massage Room 1
Jemima Farrell
39.6
Squash Court
GUEST GUEST
35.0
Squash Court
GUEST GUEST
35.0


/* Q9: This time, produce the same result as in Q8, but using a subquery. */

SELECT * 
FROM (SELECT name, CONCAT_WS(' ', firstname, surname) AS full_name, 
      CASE WHEN Bookings.memid =0 THEN (guestcost * slots) 
      ELSE (membercost * slots) END AS cost
      FROM Bookings JOIN Facilities ON Bookings.facid = Facilities.facid AND Bookings.starttime LIKE  '2012-09-14%'
      JOIN Members ON Bookings.memid = Members.memid)sub
WHERE sub.cost >30
ORDER BY sub.cost DESC

name
full_name
cost Descending

Massage Room 2
GUEST GUEST
320.0

Massage Room 1
GUEST GUEST
160.0

Massage Room 1
GUEST GUEST
160.0

Massage Room 1
GUEST GUEST
160.0

Tennis Court 2
GUEST GUEST
150.0

Tennis Court 2
GUEST GUEST
75.0

Tennis Court 1
GUEST GUEST
75.0

Tennis Court 1
GUEST GUEST
75.0

Squash Court
GUEST GUEST
70.0

Massage Room 1
Jemima Farrell
39.6

Squash Court
GUEST GUEST
35.0

Squash Court
GUEST GUEST
35.0

/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */

SELECT name, SUM(CASE WHEN memid = 0 THEN (guestcost * slots) ELSE (membercost * slots) END) AS revenue
FROM Bookings
JOIN Facilities ON Bookings.facid = Facilities.facid
GROUP BY 1
HAVING SUM(CASE WHEN memid = 0 THEN (guestcost * slots) ELSE (membercost * slots) END) < 1000
ORDER BY revenue

name
revenue Ascending
Table Tennis
180.0
Snooker Table
240.0
Pool Table

Note: this looks at the member and guest costs separately because there are different costs for each, which is held in separate columns. 


