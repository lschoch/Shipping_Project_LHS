/* List the containerID's for containers on ships that berth in the United States.*/
SELECT containerID AS 'ContainerID (in US)', s.shipName, p.portCountry
FROM  Container c JOIN Ship s JOIN Port p
WHERE c.shipName = s.shipName AND s.portID = p.portID AND p.portCountry = 'United States';
        
/* List containerID, length, and container weight for containers that are not 
	on any ships. */
SELECT containerID AS 'ContainerID - no ship', len, wt
FROM Container
WHERE ISNULL(shipName);

-- Display the number and combined volume of 20 ft. containers that are on ships.
SELECT COUNT(len) AS 'Num of 20 ft containers on ships', 
	SUM(len*width*height) AS 'Combined Volume'
FROM Container
WHERE !ISNULL(shipNAME)
GROUP BY len
HAVING len = 20;

-- Display the total crew on all ships and the average number of crew per ship.
SELECT SUM(numCrew)  AS 'Total crew on all ships', 
	FORMAT(AVG(numCrew),0) AS 'Average num of crew per ship'
FROM Ship;

/* Display the number of ships, total crew, and the average crew per ship for 
	ships berthing in the United States. */
SELECT COUNT(s.shipName) AS 'Num of US ships', 
	SUM(s.numCrew)  AS 'Total crew on US ships', 
	FORMAT(AVG(s.numCrew),0) AS 'Avg num of crew per US ship'
FROM Ship s
	WHERE s.portID IN (SELECT p.portID
		FROM Port p
        WHERE p.portCountry = 'United States');

/* List containerID, portName, portCity and portCountry for every container 
	that is on a ship. */
SELECT containerID, portName AS 'Port name',  portCity AS 'Port city', 
	portCountry AS 'Port country'
FROM Ship NATURAL JOIN Container NATURAL JOIN Port;

-- List containerID's for containers on the ship named Wayward Star.
SELECT sc.containerID AS 'Containers on the Wayward Star'
FROM (SELECT c.containerID, c.shipName
FROM Ship s JOIN Container c
WHERE s.shipName = c.shipName) AS sc
WHERE shipName = 'Wayward Star';

-- List the combined weight of all containers on the ship named Ever Ace.
SELECT SUM(sc.wt) AS 'Total weight of containers on Ever Ace'
FROM (SELECT c.containerID, c.shipName, c.wt
	FROM Ship s JOIN Container c
	WHERE s.shipName = c.shipName) AS sc
WHERE sc.shipName = 'Ever Ace';

-- Remove all containers from the ship named Her Majesty.
UPDATE Container
SET shipName = NULL
WHERE shipName = 'Her Majesty';

-- List the names of ships that don't have any containers on board.
SELECT shipName AS 'Ships with no containers'
FROM Ship
WHERE shipName NOT IN
	(SELECT c.shipName
    FROM Container c
    WHERE !ISNULL(c.shipName));

/* List the containerID, ship name, and ship displacement for all containers on 
	ships whose displacement is greater than 220,000. */
SELECT containerID AS 'ContainerID - on ship displacing > 220K', shipName, 
	displacement
FROM Ship NATURAL JOIN Container
WHERE displacement > 220000;

/* List containerID, container weight, ship name, and port country for containers 
	in the United States weighing over 6000 lb. */
SELECT containerID AS 'ContainerID (in US, weight  > 6000)', wt,  s.shipName, 
	p.portCountry
FROM Ship s JOIN Container c NATURAL JOIN Port p
WHERE s.shipName = c.shipName AND p.portCountry = 'United States' AND wt > 6000;