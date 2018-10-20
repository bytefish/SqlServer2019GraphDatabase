using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
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
