// Copyright (c) Philipp Wagner. All rights reserved.
// Licensed under the MIT license. See LICENSE file in the project root for full license information.

using System.Collections.Generic;
using Newtonsoft.Json;

namespace SqlServer2019Graph.Controllers.DTO
{
    
    public class GraphDto
    {
        [JsonProperty("nodes")]
        public IList<NodeDto> Nodes { get; set; }

        [JsonProperty("edges")]
        public IList<EdgeDto> Edges { get; set; }
    }

    public class NodeDto
    {
        [JsonProperty("id")]
        public int Id { get; set; }

        [JsonProperty("label")]
        public string Label { get; set; }

        [JsonProperty("group")]
        public string Group { get; set; }
    }

    public class EdgeDto
    {
        [JsonProperty("from")]
        public int From { get; set; }

        [JsonProperty("to")]
        public int To { get; set; }

        [JsonProperty("label")]
        public string Label { get; set; }
    }
}
