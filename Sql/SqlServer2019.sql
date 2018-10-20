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
		CONSTRAINT EC_IN_COUNTRY CONNECTION ([Nodes].[Airport] TO [Nodes].[State])
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

SELECT [Functions].[GetGraphSchema]('Nodes')

