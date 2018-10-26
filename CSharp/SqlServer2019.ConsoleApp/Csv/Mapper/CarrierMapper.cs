// Copyright (c) Philipp Wagner. All rights reserved.
// Licensed under the MIT license. See LICENSE file in the project root for full license information.

using SqlServer2019.ConsoleApp.Csv.Model;
using TinyCsvParser.Mapping;

namespace SqlServer2019.ConsoleApp.Csv.Mapper
{
    public class CarrierMapper : CsvMapping<Carrier>
    {
        public CarrierMapper()
        {
            MapProperty(0, x => x.Code);
            MapProperty(1, x => x.Description);
        }
    }
}
