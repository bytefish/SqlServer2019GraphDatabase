// Copyright (c) Philipp Wagner. All rights reserved.
// Licensed under the MIT license. See LICENSE file in the project root for full license information.

using System.Collections.Generic;
using Newtonsoft.Json;

namespace SqlServer2019Graph.Model
{
    public class Edge
    {
        [JsonProperty("edge_table_name")]
        public string Name { get; set; }

        [JsonProperty("from_node_table_id")]
        public int From { get; set; }

        [JsonProperty("to_node_table_id")]
        public int To { get; set; }

        [JsonProperty("attributes")]
        public IList<Attribute> Attributes { get; set; }
    }
}
