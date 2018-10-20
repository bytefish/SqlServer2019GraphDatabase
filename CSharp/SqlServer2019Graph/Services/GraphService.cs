// Copyright (c) Philipp Wagner. All rights reserved.
// Licensed under the MIT license. See LICENSE file in the project root for full license information.

using System;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using Newtonsoft.Json;
using SqlServer2019Graph.Model;

namespace SqlServer2019Graph.Services
{
    public class GraphService : IGraphService
    {
        private readonly string connectionString;

        public GraphService(string connectionString)
        {
            this.connectionString = connectionString;
        }

        public Graph GetGraphSchema(string schemaName)
        {
            var json = GetSchemaAsJsonString(schemaName);

            return JsonConvert
                .DeserializeObject<Graph[]>(json)
                .FirstOrDefault();
        }

        private string GetSchemaAsJsonString(string schemaName)
        {
            if (schemaName == null)
            {
                throw new ArgumentNullException("schemaName");
            }

            using (var connection = new SqlConnection(connectionString))
            {
                connection.Open();

                using (IDbCommand command = connection.CreateCommand())
                {
                    // Build the Stored Procedure Command:
                    command.CommandText = "SELECT [Functions].[GetGraphSchema](@SchemaName)";
                    command.CommandType = CommandType.Text;

                    // Create the Schema Name Parameter:
                    SqlParameter parameter = new SqlParameter();

                    parameter.ParameterName = "@SchemaName";
                    parameter.SqlDbType = SqlDbType.NVarChar;
                    parameter.Direction = ParameterDirection.Input;
                    parameter.Value = schemaName;

                    command.Parameters.Add(parameter);

                    return command.ExecuteScalar() as string;
                }
            }
        }
    }
}
