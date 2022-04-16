/* Use nested subqueries to list the containerID's for containers on ships 
	that berth in the United States.*/
SELECT containerID
FROM (SELECT containerID, shipName
	FROM  Container 
	WHERE shipName IN (SELECT shipName
		FROM Ship s
		WHERE s.portCountry = 'United States') ) AS cs;
        
/* List containerID, length, weight and shipName for containers that are not 
	on any ships. */
SELECT containerID, len, wt, shipName
FROM Container
WHERE ISNULL(shipName);

-- Display the number and combined volume of 20 ft. containers that are on ships.
SELECT COUNT(len) AS 'Number of 20 ft. containers on ships:', 
	SUM(len*width*height) AS 'Combined Volume (cubic ft.):'
FROM Container
WHERE !ISNULL(shipNAME)
GROUP BY len
HAVING len = 20;

-- Display the total crew on all ships and the average number of crew per ship.
SELECT SUM(numCrew)  AS 'Total crew on all ships:', 
	FORMAT(AVG(numCrew),0) AS 'Average number of crew per ship:'
FROM Ship;

/* Display the number of ships, total crew, and the average crew per ship for 
	ships berthing in the United States.*/
SELECT COUNT(shipName) AS 'Number of US ships:', 
	SUM(numCrew)  AS 'Total crew on US ships:', 
	FORMAT(AVG(numCrew),0) AS 'Average number of crew per US ship:'
FROM Ship
WHERE portCountry = 'United States';