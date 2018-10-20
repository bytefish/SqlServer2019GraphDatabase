// Copyright (c) Philipp Wagner. All rights reserved.
// Licensed under the MIT license. See LICENSE file in the project root for full license information.

using System.Collections.Generic;
using Newtonsoft.Json;

namespace SqlServer2019Graph.Model
{
    public class Graph
    {
        [JsonProperty("nodes")]
        public IList<Node> Nodes { get; set; }

        [JsonProperty("edges")]
        public IList<Edge> Edges { get; set; }
    }
}
