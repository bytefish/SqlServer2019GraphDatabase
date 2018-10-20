// Copyright (c) Philipp Wagner. All rights reserved.
// Licensed under the MIT license. See LICENSE file in the project root for full license information.

using System.Collections.Generic;
using Newtonsoft.Json;

namespace SqlServer2019Graph.Model
{
    public class Node
    {
        [JsonProperty("node_id")]
        public int Id { get; set; }

        [JsonProperty("node_name")]
        public string Name { get; set; }

        [JsonProperty("attributes")]
        public IList<Attribute> Attributes { get; set; }
    }
}
