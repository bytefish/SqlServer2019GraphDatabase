IF NOT EXISTS (SELECT name FROM sys.schemas WHERE name = 'Nodes')
BEGIN

    EXEC('create schema [Nodes]')

END
GO

IF NOT EXISTS (SELECT name FROM sys.schemas WHERE name = 'Edges')
BEGIN

    EXEC('create schema [Edges]')

END
GO

IF NOT EXISTS (SELECT name FROM sys.schemas WHERE name = 'Functions')
BEGIN

    EXEC('create schema [Functions]')

END
GO

IF  NOT EXISTS 
    (SELECT * FROM sys.objects 
     WHERE object_id = OBJECT_ID(N'[Nodes].[Country]') AND type in (N'U'))
BEGIN

    CREATE TABLE [Nodes].[Country] (
        [CountryID] [INTEGER] IDENTITY(1,1) PRIMARY KEY,
        [Name] [NVARCHAR](255),
        [IsoCode] [NVARCHAR](255)
    ) AS NODE;
    
END
GO

IF  NOT EXISTS 
    (SELECT * FROM sys.objects 
     WHERE object_id = OBJECT_ID(N'[Nodes].[State]') AND type in (N'U'))
BEGIN

    CREATE TABLE [Nodes].[State] (
        [StateID] [INTEGER] IDENTITY(1,1) PRIMARY KEY,
        [Code] [NVARCHAR](255),
        [Name] [NVARCHAR](255)
    ) AS NODE;
    
END
GO


IF  NOT EXISTS 
    (SELECT * FROM sys.objects 
     WHERE object_id = OBJECT_ID(N'[Nodes].[City]') AND type in (N'U'))
BEGIN

    CREATE TABLE [Nodes].[City] (
        [CityID] [INTEGER] IDENTITY(1,1) PRIMARY KEY,
        [Name] [NVARCHAR](255)
    ) AS NODE;
    
END
GO

IF  NOT EXISTS 
    (SELECT * FROM sys.objects 
     WHERE object_id = OBJECT_ID(N'[Nodes].[Airport]') AND type in (N'U'))
BEGIN

    CREATE TABLE [Nodes].[Airport](
        [AirportID] [INTEGER] IDENTITY(1,1) PRIMARY KEY,
        [Identifier] NVARCHAR(255) NOT NULL,
        [Abbr] NVARCHAR(55),
        [Name] NVARCHAR(255),
        [City] NVARCHAR(255),
        [StateCode] NVARCHAR(255),
        [StateName] NVARCHAR(255),
        [Country] NVARCHAR(255),
        [CountryIsoCode] NVARCHAR(255),
    ) AS NODE;
    
END
GO


IF  NOT EXISTS 
    (SELECT * FROM sys.objects 
     WHERE object_id = OBJECT_ID(N'[Nodes].[Aircraft]') AND type in (N'U'))
BEGIN

    CREATE TABLE [Nodes].[Aircraft](
        [AircraftID] [INTEGER] IDENTITY(1,1) PRIMARY KEY,
        [TailNumber] [NVARCHAR](255) NOT NULL
    ) AS NODE;
    
END
GO

IF  NOT EXISTS 
    (SELECT * FROM sys.objects 
     WHERE object_id = OBJECT_ID(N'[Nodes].[Carrier]') AND type in (N'U'))
BEGIN

    CREATE TABLE [Nodes].[Carrier](
        [CarrierID] [INTEGER] IDENTITY(1,1) PRIMARY KEY,
        [Code] [NVARCHAR](255),
        [Description] [NVARCHAR](255)
    ) AS NODE;
    
END
GO


IF  NOT EXISTS 
    (SELECT * FROM sys.objects 
     WHERE object_id = OBJECT_ID(N'[Nodes].[Flight]') AND type in (N'U'))
BEGIN
     
    CREATE TABLE [Nodes].[Flight](
        [FlightID] [INTEGER] IDENTITY(1,1) PRIMARY KEY,
        [Year] [NUMERIC](9, 0),
        [Month] [NUMERIC](9, 0),
        [DayOfMonth] [NUMERIC](9, 0),
        [DayOfWeek] [NUMERIC](9, 0),
        [FlightDate] [DATETIME2],
        [UniqueCarrier] [NVARCHAR](255),
        [TailNumber] [NVARCHAR](255),
        [FlightNumber] [NVARCHAR](255),
        [OriginAirport] [NVARCHAR](55),
        [OriginState] [NVARCHAR](55),
        [DestinationAirport] [NVARCHAR](55),
        [DestinationState] [NVARCHAR](55),
        [DepartureDelay] [NUMERIC](9, 0),
        [TaxiOut] [NUMERIC](9, 0),
        [TaxiIn] [NUMERIC](9, 0),
        [ArrivalDelay] [NUMERIC](9, 0),
        [CancellationCode] [NVARCHAR](255),
        [CarrierDelay] [NUMERIC](9, 0),
        [WeatherDelay] [NUMERIC](9, 0),
        [NasDelay] [NUMERIC](9, 0),
        [SecurityDelay] [NUMERIC](9, 0),
        [LateAircraftDelay] [NUMERIC](9, 0)
    ) AS NODE;

END
GO

IF  NOT EXISTS 
    (SELECT * FROM sys.objects 
     WHERE object_id = OBJECT_ID(N'[Nodes].[Reason]') AND type in (N'U'))
BEGIN

    CREATE TABLE [Nodes].[Reason] (
        [ReasonID] [INTEGER] IDENTITY(1,1) PRIMARY KEY,
        [Code] [NVARCHAR](55) NOT NULL,
        [Description] [NVARCHAR](255) NOT NULL
    ) AS NODE;
    
END
GO

-- Edges:

IF  NOT EXISTS 
    (SELECT * FROM sys.objects 
     WHERE object_id = OBJECT_ID(N'[Edges].[InCountry]') AND type in (N'U'))
BEGIN

    CREATE TABLE [Edges].[InCountry]
    (
        CONSTRAINT EC_IN_COUNTRY CONNECTION ([Nodes].[Airport] TO [Nodes].[Country])
    ) AS EDGE;

END
GO

IF  NOT EXISTS 
    (SELECT * FROM sys.objects 
     WHERE object_id = OBJECT_ID(N'[Edges].[InState]') AND type in (N'U'))
BEGIN

    CREATE TABLE [Edges].[InState]
    (
        CONSTRAINT EC_IN_STATE CONNECTION ([Nodes].[Airport] TO [Nodes].[State])
    ) AS EDGE;

END
GO

IF  NOT EXISTS 
    (SELECT * FROM sys.objects 
     WHERE object_id = OBJECT_ID(N'[Edges].[InCity]') AND type in (N'U'))
BEGIN

    CREATE TABLE [Edges].[InCity] 
    (
        CONSTRAINT EC_IN_CITY CONNECTION ([Nodes].[Airport] TO [Nodes].[City])
    ) AS EDGE;

END
GO

IF  NOT EXISTS 
    (SELECT * FROM sys.objects 
     WHERE object_id = OBJECT_ID(N'[Edges].[Origin]') AND type in (N'U'))
BEGIN

    CREATE TABLE [Edges].[Origin] 
    (
        taxi_time integer, 
        dep_delay integer,
        CONSTRAINT EC_ORIGIN CONNECTION ([Nodes].[Flight] TO [Nodes].[Airport])
    ) AS EDGE;

END
GO

IF  NOT EXISTS 
    (SELECT * FROM sys.objects 
     WHERE object_id = OBJECT_ID(N'[Edges].[Destination]') AND type in (N'U'))
BEGIN

    CREATE TABLE [Edges].[Destination]
    (
        taxi_time integer, 
        arr_delay integer,
        CONSTRAINT EC_DESTINATION CONNECTION ([Nodes].[Flight] TO [Nodes].[Airport])
    ) AS EDGE;

END
GO

IF  NOT EXISTS 
    (SELECT * FROM sys.objects 
     WHERE object_id = OBJECT_ID(N'[Edges].[Carrier]') AND type in (N'U'))
BEGIN

    CREATE TABLE [Edges].[Carrier]
    (
        CONSTRAINT EC_CARRIER CONNECTION ([Nodes].[Flight] TO [Nodes].[Carrier])
    ) AS EDGE;

END
GO

IF  NOT EXISTS 
    (SELECT * FROM sys.objects 
     WHERE object_id = OBJECT_ID(N'[Edges].[CancelledBy]') AND type in (N'U'))
BEGIN

    CREATE TABLE [Edges].[CancelledBy](
            CONSTRAINT EC_CANCELED_BY CONNECTION ([Nodes].[Flight] TO [Nodes].[Reason])
    ) AS EDGE;

END
GO

IF  NOT EXISTS 
    (SELECT * FROM sys.objects 
     WHERE object_id = OBJECT_ID(N'[Edges].[DelayedBy]') AND type in (N'U'))
BEGIN

    CREATE TABLE [Edges].[DelayedBy]
    (
        time INTEGER,
        CONSTRAINT EC_DELAYED_BY CONNECTION ([Nodes].[Flight] TO [Nodes].[Reason])
    ) AS EDGE;
    

END
GO

IF  NOT EXISTS 
    (SELECT * FROM sys.objects 
     WHERE object_id = OBJECT_ID(N'[Edges].[Aircraft]') AND type in (N'U'))
BEGIN

    CREATE TABLE [Edges].[Aircraft]
    (
        CONSTRAINT EC_AIRCRAFT CONNECTION ([Nodes].[Flight] TO [Nodes].[Aircraft])
    )
    AS EDGE;

END
GO

----------------------------------------------------
-- Functions
----------------------------------------------------

IF OBJECT_ID(N'[Functions].[GetGraphSchema]', N'FN') IS NOT NULL
BEGIN
    DROP FUNCTION [Functions].[GetGraphSchema]
END
GO 


CREATE FUNCTION [Functions].[GetGraphSchema](@NodesSchemaName nvarchar(max))
 RETURNS NVARCHAR(MAX)  
AS  
BEGIN  

    DECLARE @NodesSchemaId int = (select schema_id from sys.schemas where [Name] = @NodesSchemaName);

    RETURN (
                SELECT 
                    [name] = @NodesSchemaName,
                    nodes = (SELECT [node].[name] as node_name, 
                                   [node].[object_id] as node_id, 
                                   [attributes] = (SELECT [column].[name] as name, [column].[is_nullable] as is_nullable
                                 FROM sys.columns as [column]
                                 WHERE [column].[graph_type] is null and [node].[object_id] = [column].[object_id]
                                 FOR JSON PATH)
                FROM [master].[sys].[tables] as [node]
                WHERE is_node = 1 and schema_id = @NodesSchemaId
                FOR JSON PATH),
                   edges = (SELECT EC.name AS edge_constraint_name, 
                                   OBJECT_NAME(EC.parent_object_id) AS edge_table_name, 
                                   EC.parent_object_id AS edge_table_id,
                                   OBJECT_NAME(ECC.from_object_id) AS from_node_table_name, 
                                   ECC.from_object_id AS from_node_table_id,
                                   OBJECT_NAME(ECC.to_object_id) AS to_node_table_name, 
                                   ECC.to_object_id AS to_node_table_id,
                                   [attributes] = (SELECT [column].[name] as name, [column].[is_nullable] as is_nullable
                                                    FROM sys.columns as [column]
                                                    WHERE [column].[graph_type] is null and  EC.parent_object_id = [column].[object_id]
                                                    FOR JSON PATH)
                            FROM sys.edge_constraints EC
                                INNER JOIN sys.edge_constraint_clauses ECC ON EC.object_id = ECC.object_id
                            FOR JSON PATH)
            FOR JSON PATH)

END
GO

-- Stored Procedures:

IF OBJECT_ID(N'[Functions].[InsertAirports]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [Functions].[InsertAirports]
END
GO 

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'AirportType')
BEGIN
    DROP TYPE [Functions].[AirportType]
END

CREATE TYPE [Functions].[AirportType] AS TABLE (
    [Identifier] [NVARCHAR](255),
    [Abbr] [NVARCHAR](255),
    [Name] [NVARCHAR](255),
    [City] [NVARCHAR](255),
	[StateCode] [NVARCHAR](255),
    [StateName] [NVARCHAR](255),
    [Country] [NVARCHAR](255),
	[CountryIsoCode] [NVARCHAR](255)
);

GO

CREATE PROCEDURE [Functions].[InsertAirports]
  @Entities [Functions].[AirportType] ReadOnly
AS
BEGIN
    
    SET NOCOUNT ON;

    -- Insert missing City Nodes:
    INSERT INTO [Nodes].[City]
    SELECT DISTINCT e.City
    FROM @Entities e 
	WHERE NOT EXISTS (select * from [Nodes].[City] c where c.Name = e.City)

    -- Insert missing State Nodes:
    INSERT INTO [Nodes].[State]
    SELECT DISTINCT e.StateCode, e.StateName
    FROM @Entities e 
	WHERE NOT EXISTS (select * from [Nodes].[State] s where s.Name = e.StateName and s.Code = e.StateCode)

    -- Insert missing Country Nodes:
    INSERT INTO [Nodes].[Country]
    SELECT DISTINCT e.Country, e.CountryIsoCode
    FROM @Entities e 
	WHERE NOT EXISTS (select * from [Nodes].[Country] c where c.Name = e.Country)
    
    -- Build the Temporary Staged Table for Inserts:
    DECLARE @TemporaryAirportTable Table(
        [AirportID] [INTEGER],
		[NodeID] [NVARCHAR](1000),
        [Airport] [NVARCHAR](255),
        [Abbr] [NVARCHAR](255),
        [Name] [NVARCHAR](255),
        [City] [NVARCHAR](255),
        [StateCode] [NVARCHAR](255),
		[StateName] [NVARCHAR](255),
        [Country] [NVARCHAR](255),
		[CountryIsoCode] [NVARCHAR](255)
    );
    
    -- Insert into Temporary Table:
    INSERT INTO [Nodes].[Airport](Identifier, Abbr, Name, City, StateCode, StateName, Country, CountryIsoCode)
    OUTPUT INSERTED.AirportID, INSERTED.$NODE_ID, INSERTED.Identifier, INSERTED.Abbr, INSERTED.Name, INSERTED.City, INSERTED.StateCode, INSERTED.StateName, INSERTED.Country, INSERTED.CountryIsoCode
    INTO @TemporaryAirportTable
    SELECT * FROM @Entities;
    
    -- Build Relationships:
    INSERT INTO [Edges].[InCity]
    SELECT airport.NodeID, (SELECT $NODE_ID FROM [Nodes].[City] where Name = airport.City)
    FROM @TemporaryAirportTable airport;

    INSERT INTO [Edges].[InState]
    SELECT airport.NodeID, (SELECT $NODE_ID FROM [Nodes].[State] where Code = airport.StateCode)
    FROM @TemporaryAirportTable airport;

    INSERT INTO [Edges].[InCountry]
    SELECT airport.NodeID, (SELECT $NODE_ID FROM [Nodes].[Country] where Name = airport.Country)
    FROM @TemporaryAirportTable airport;
    
END
GO

IF OBJECT_ID(N'[Functions].[InsertFlights]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [Functions].[InsertFlights]
END
GO 

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'FlightType')
BEGIN
    DROP TYPE [Functions].[FlightType]
END

CREATE TYPE [Functions].[FlightType] AS TABLE (
    [Year] [NUMERIC](9, 0),
    [Month] [NUMERIC](9, 0),
    [DayOfMonth] [NUMERIC](9, 0),
    [DayOfWeek] [NUMERIC](9, 0),
    [FlightDate] [DATETIME2],
    [UniqueCarrier] [NVARCHAR](255),
    [TailNumber] [NVARCHAR](255),
    [FlightNumber] [NVARCHAR](255),
    [OriginAirport] [NVARCHAR](55),
    [OriginState] [NVARCHAR](55),
    [DestinationAirport] [NVARCHAR](55),
    [DestinationState] [NVARCHAR](55),
    [DepartureDelay] [NUMERIC](9, 0),
    [TaxiOut] [NUMERIC](9, 0),
    [TaxiIn] [NUMERIC](9, 0),
    [ArrivalDelay] [NUMERIC](9, 0),
    [CancellationCode] [NVARCHAR](255),
    [CarrierDelay] [NUMERIC](9, 0),
    [WeatherDelay] [NUMERIC](9, 0),
    [NasDelay] [NUMERIC](9, 0),
    [SecurityDelay] [NUMERIC](9, 0),
    [LateAircraftDelay] [NUMERIC](9, 0)
);

GO

IF OBJECT_ID(N'[Functions].[InsertFlights]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [Functions].[InsertFlights]
END
GO 

CREATE PROCEDURE [Functions].[InsertFlights]
  @Entities [Functions].[FlightType] ReadOnly
AS
BEGIN
    
    SET NOCOUNT ON;

    -- Temporary Table for Inserts:
    DECLARE @TemporaryFlightTable TABLE(
        [FlightID] [INTEGER],
        [NodeID] [NVARCHAR](1000),
        [Year] [NUMERIC](9, 0),
        [Month] [NUMERIC](9, 0),
        [DayOfMonth] [NUMERIC](9, 0),
        [DayOfWeek] [NUMERIC](9, 0),
        [FlightDate] [DATETIME2],
        [UniqueCarrier] [NVARCHAR](255),
        [TailNumber] [NVARCHAR](255),
        [FlightNumber] [NVARCHAR](255),
        [OriginAirport] [NVARCHAR](55),
        [OriginState] [NVARCHAR](55),
        [DestinationAirport] [NVARCHAR](55),
        [DestinationState] [NVARCHAR](55),
        [DepartureDelay] [NUMERIC](9, 0),
        [TaxiOut] [NUMERIC](9, 0),
        [TaxiIn] [NUMERIC](9, 0),
        [ArrivalDelay] [NUMERIC](9, 0),
        [CancellationCode] [NVARCHAR](255),
        [CarrierDelay] [NUMERIC](9, 0),
        [WeatherDelay] [NUMERIC](9, 0),
        [NasDelay] [NUMERIC](9, 0),
        [SecurityDelay] [NUMERIC](9, 0),
        [LateAircraftDelay] [NUMERIC](9, 0)
    );

    -- Insert into Temporary Table:
    INSERT INTO [Nodes].Flight(Year, Month, DayOfMonth, DayOfWeek, FlightDate, UniqueCarrier, TailNumber, FlightNumber, OriginAirport, OriginState, DestinationAirport, DestinationState, DepartureDelay, TaxiOut, TaxiIn, ArrivalDelay, CancellationCode, CarrierDelay, WeatherDelay, NasDelay, SecurityDelay, LateAircraftDelay)
    OUTPUT INSERTED.FlightID, INSERTED.$NODE_ID, INSERTED.Year, INSERTED.Month, INSERTED.DayOfMonth, INSERTED.DayOfWeek, INSERTED.FlightDate, INSERTED.UniqueCarrier, INSERTED.TailNumber, INSERTED.FlightNumber, INSERTED.OriginAirport, INSERTED.OriginState, INSERTED.DestinationAirport, INSERTED.DestinationState, INSERTED.DepartureDelay, INSERTED.TaxiOut, INSERTED.TaxiIn, INSERTED.ArrivalDelay, INSERTED.CancellationCode, INSERTED.CarrierDelay, INSERTED.WeatherDelay, INSERTED.NasDelay, INSERTED.SecurityDelay, INSERTED.LateAircraftDelay
    INTO @TemporaryFlightTable
    SELECT * FROM @Entities;
    
    -- Insert Origins:
    INSERT INTO [Edges].[Origin]
    SELECT flight.NodeID, airport.$NODE_ID, flight.TaxiOut, flight.DepartureDelay
    FROM @TemporaryFlightTable flight
        INNER JOIN [Nodes].Airport airport on airport.Identifier = flight.OriginAirport;

    -- Insert Destinations:
    INSERT INTO [Edges].[Destination]
	SELECT flight.NodeID, airport.$NODE_ID, flight.TaxiIn, flight.ArrivalDelay
    FROM @TemporaryFlightTable flight
    INNER JOIN [Nodes].Airport airport on airport.Identifier = flight.DestinationAirport;

    -- INSERT Delays:
    INSERT INTO [Edges].[DelayedBy]
    SELECT flight.NodeID, (SELECT $NODE_ID FROM [Nodes].Reason where Code = 'A'), flight.CarrierDelay
    FROM @TemporaryFlightTable flight
    WHERE flight.CarrierDelay > 0;

    INSERT INTO [Edges].[DelayedBy]
    SELECT flight.NodeID, (SELECT $NODE_ID FROM [Nodes].Reason where Code = 'B'), flight.WeatherDelay
    FROM @TemporaryFlightTable flight
    WHERE flight.WeatherDelay > 0;

    INSERT INTO [Edges].[DelayedBy]
    SELECT flight.NodeID, (SELECT $NODE_ID FROM [Nodes].Reason where Code = 'C'), flight.NasDelay
    FROM @TemporaryFlightTable flight
    WHERE flight.NasDelay > 0;

    INSERT INTO [Edges].[DelayedBy]
    SELECT flight.NodeID, (SELECT $NODE_ID FROM [Nodes].Reason where Code = 'D'), flight.SecurityDelay
    FROM @TemporaryFlightTable flight
    WHERE flight.SecurityDelay > 0;

    INSERT INTO [Edges].[DelayedBy]
    SELECT flight.NodeID, (SELECT $NODE_ID FROM [Nodes].Reason where Code = 'Z'), flight.LateAircraftDelay
    FROM @TemporaryFlightTable flight
    WHERE flight.LateAircraftDelay > 0;
    
    -- Insert Cancelled Flights:
    INSERT INTO [Edges].[CancelledBy]
    SELECT flight.NodeID, reason.$NODE_ID
    FROM @TemporaryFlightTable flight
        INNER JOIN [Nodes].Reason reason on flight.CancellationCode = reason.Code;
    
END
GO

IF OBJECT_ID(N'[Function].[InsertCarriers]', N'P') IS NOT NULL
BEGIN
    DROP PROCEDURE [Function].[InsertCarriers]
END
GO 

IF EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name = 'CarrierType')
BEGIN
    DROP TYPE [Function].[CarrierType]
END

CREATE TYPE [Function].[CarrierType] AS TABLE (
	Code [NVARCHAR](255),
	Description [NVARCHAR](255)
);

GO

CREATE PROCEDURE [Function].[InsertCarriers]
  @Entities [CarrierType] ReadOnly
AS
BEGIN
    
    SET NOCOUNT ON;

    -- Insert missing City Nodes:
    INSERT INTO [Nodes].[Carrier](Code, Description)
    SELECT e.Code, e.Description
    FROM @Entities e 
	WHERE NOT EXISTS (select * from [Nodes].[Carrier] c where c.Code = e.Code)

END
GO


-- Data:
INSERT INTO [Nodes].[Reason](Code, Description)
SELECT 'A', 'Carrier'
WHERE NOT EXISTS (select * from [Nodes].[Reason] where Code = 'A')

INSERT INTO [Nodes].[Reason](Code, Description)
SELECT 'B', 'Weather'
WHERE NOT EXISTS (select * from [Nodes].[Reason] where Code = 'B')

INSERT INTO [Nodes].[Reason](Code, Description)
SELECT 'C', 'National Air System'
WHERE NOT EXISTS (select * from [Nodes].[Reason] where Code = 'C')

INSERT INTO [Nodes].[Reason](Code, Description)
SELECT 'D', 'Security'
WHERE NOT EXISTS (select * from [Nodes].[Reason] where Code = 'D')

INSERT INTO [Nodes].[Reason](Code, Description)
SELECT 'Z', 'Late Aircraft'
WHERE NOT EXISTS (select * from [Nodes].[Reason] where Code = 'Z')