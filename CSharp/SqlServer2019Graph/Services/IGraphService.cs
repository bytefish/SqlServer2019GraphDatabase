// Copyright (c) Philipp Wagner. All rights reserved.
// Licensed under the MIT license. See LICENSE file in the project root for full license information.

using SqlServer2019Graph.Model;

namespace SqlServer2019Graph.Services
{
    public interface IGraphService
    {
        Graph GetGraphSchema(string schemaName);
    }
}
