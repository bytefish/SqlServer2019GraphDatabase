// Copyright (c) Philipp Wagner. All rights reserved.
// Licensed under the MIT license. See LICENSE file in the project root for full license information.

using System;
using System.Collections.Generic;
using System.Linq;

using CsvFlightType = SqlServer2019.ConsoleApp.Csv.Model.Flight;
using SqlFlightType = SqlServer2019.ConsoleApp.Sql.Model.Flight;

using CsvAirportType = SqlServer2019.ConsoleApp.Csv.Model.Airport;
using SqlAirportType = SqlServer2019.ConsoleApp.Sql.Model.Airport;

using CsvCarrierType = SqlServer2019.ConsoleApp.Csv.Model.Carrier;
using SqlCarrierType = SqlServer2019.ConsoleApp.Sql.Model.Carrier;


namespace SqlServer2019.ConsoleApp.Converters
{
    public interface IConverter<in TSourceType, out TTargetType>
    {
        TTargetType Convert(TSourceType source);
    }

    public abstract class BaseConverter<TSourceType, TTargetType> : IConverter<TSourceType, TTargetType>
        where TSourceType : class
        where TTargetType : class, new()
    {
        public TTargetType Convert(TSourceType source)
        {
            if (source == null)
            {
                return null;
            }

            TTargetType target = new TTargetType();

            InternalConvert(source, target);

            return target;
        }

        protected abstract void InternalConvert(TSourceType source, TTargetType target);
    }

    public class FlightConverter : BaseConverter<CsvFlightType, SqlFlightType>
    {
        protected override void InternalConvert(CsvFlightType source, SqlFlightType target)
        {
            target.Year = source.Year;
            target.Month = source.Month;
            target.DayOfMonth = source.DayOfMonth;
            target.DayOfWeek = source.DayOfWeek;
            target.FlightDate = source.FlightDate;
            target.UniqueCarrier = source.UniqueCarrier;
            target.TailNumber = source.TailNumber;
            target.FlightNumber = source.FlightNumber;
            target.OriginAirport = source.OriginAirport;
            target.OriginState = source.OriginState;
            target.DestinationAirport = source.DestinationAirport;
            target.DestinationState = source.DestinationState;
            target.DepartureDelay = source.DepartureDelay;
            target.TaxiOut = source.TaxiOut;
            target.TaxiIn = source.TaxiIn;
            target.ArrivalDelay = source.ArrivalDelay;
            target.CancellationCode = source.CancellationCode;
            target.CarrierDelay = source.CarrierDelay;
            target.WeatherDelay = source.WeatherDelay;
            target.NasDelay = source.NasDelay;
            target.SecurityDelay = source.SecurityDelay;
            target.LateAircraftDelay = source.LateAircraftDelay;
        }
    }
    
    public class AirportConverter : BaseConverter<CsvAirportType, SqlAirportType>
    {
        protected override void InternalConvert(CsvAirportType source, SqlAirportType target)
        {
            target.AirportId = source.AirportId;
            target.Abbr = source.AirportAbbr;
            target.Name = source.AirportName;
            target.City = source.AirportCityName;
            target.StateCode = source.AirportStateCode;
            target.StateName = source.AirportStateName;
            target.Country = source.AirportCountryName;
            target.CountryIsoCode = source.AirportCountryCodeISO;
        }
    }

    public class CarrierConverter : BaseConverter<CsvCarrierType, SqlCarrierType>
    {
        protected override void InternalConvert(CsvCarrierType source, SqlCarrierType target)
        {
            target.Code = source.Code;
            target.Description = source.Description;
        }
    }
}
