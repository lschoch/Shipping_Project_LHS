CREATE DATABASE IF NOT EXISTS shipping;
USE shipping;

CREATE TABLE IF NOT EXISTS Port (
  portName VARCHAR(30) NOT NULL,
  portCity VARCHAR(30) NOT NULL,
  portCountry VARCHAR(30) NOT NULL,
  PRIMARY KEY(portName, portCity, portCountry)
);

CREATE TABLE IF NOT EXISTS Ship (
  shipName  VARCHAR(30) NOT NULL,
  displacement INTEGER NOT NULL CHECK(displacement > 0),
  captainName VARCHAR(30) NOT NULL,
  numCrew SMALLINT NOT NULL CHECK(numCrew > 0),
  portName VARCHAR(30) NOT NULL,
  portCity VARCHAR(30) NOT NULL,
  portCountry VARCHAR(30) NOT NULL,
  year SMALLINT NOT NULL CHECK(year > 999 AND year < 9999),
  PRIMARY KEY(shipName),
  FOREIGN KEY(portName, portCity, portCountry) 
  REFERENCES Port(portName, portCity, portCountry)
);

CREATE TABLE IF NOT EXISTS Container (
  containerID  CHAR(6) NOT NULL,
  height SMALLINT NOT NULL CHECK(height > 0),
  width  SMALLINT NOT NULL CHECK(width > 0),
  len SMALLINT NOT NULL CHECK(len > 0),
  wt INTEGER NOT NULL CHECK(wt > 0),
  shipName VARCHAR(30) NULL,
  PRIMARY KEY(containerId),
  FOREIGN KEY(shipName) REFERENCES Ship(shipName)
);
