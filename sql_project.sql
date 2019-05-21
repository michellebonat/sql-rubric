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


/* Q5: How can you produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100? Return the name and monthly maintenance of the facilities
in question. */


/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Do not use the LIMIT clause for your solution. */


/* Q7: How can you produce a list of all members who have used a tennis court?
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */


/* Q8: How can you produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30? Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */


/* Q9: This time, produce the same result as in Q8, but using a subquery. */


/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */
