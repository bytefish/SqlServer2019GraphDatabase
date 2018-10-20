// Copyright (c) Philipp Wagner. All rights reserved.
// Licensed under the MIT license. See LICENSE file in the project root for full license information.

using System.Collections.Generic;
using System.Linq;
using SqlServer2019Graph.Controllers.DTO;
using SqlServer2019Graph.Model;

namespace SqlServer2019Graph.Controllers.Converter
{
    public static class Converters
    {
        public static GraphDto Convert(Graph source)
        {
            if (source == null)
            {
                return null;
            }

            return new GraphDto
            {
                Nodes = ConvertNodes(source.Nodes),
                Edges = ConvertEdges(source.Edges)
            };
        }

        private static IList<NodeDto> ConvertNodes(IList<Node> source)
        {
            if (source == null)
            {
                return null;
            }

            return source
                .Select(x => ConvertNode(x))
                .ToList();
        }

        private static NodeDto ConvertNode(Node source)
        {
            if (source == null)
            {
                return null;
            }

            return new NodeDto
            {
                Label = source.Name,
                Id = source.Id,
                Group = source.Name
            };
        }

        private static IList<EdgeDto> ConvertEdges(IList<Edge> source)
        {
            if (source == null)
            {
                return null;
            }

            return source
                .Select(x => ConvertEdge(x))
                .ToList();
        }

        private static EdgeDto ConvertEdge(Edge source)
        {
            if (source == null)
            {
                return null;
            }

            return new EdgeDto
            {
                Label = source.Name,
                From = source.From,
                To = source.To
            };
        }
    }
}
