// Copyright (c) Philipp Wagner. All rights reserved.
// Licensed under the MIT license. See LICENSE file in the project root for full license information.

using Microsoft.AspNetCore.Mvc;
using SqlServer2019Graph.Controllers.Converter;
using SqlServer2019Graph.Controllers.DTO;
using SqlServer2019Graph.Model;
using SqlServer2019Graph.Services;

namespace SqlServer2019Graph.Controllers
{
    [Controller]
    [Route("api/graph")]
    public class GraphController : ControllerBase
    {
        private readonly IGraphService service;

        public GraphController(IGraphService service)
        {
            this.service = service;
        }

        [HttpGet("schema")]
        public ActionResult<GraphDto> GetNodesSchema()
        {
            var source = service.GetGraphSchema("Nodes");

            var target = Converters.Convert(source);

            return Ok(target);
        }
    }
}
