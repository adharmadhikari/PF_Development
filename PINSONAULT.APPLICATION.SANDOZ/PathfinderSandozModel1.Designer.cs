﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:2.0.50727.4952
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

[assembly: global::System.Data.Objects.DataClasses.EdmSchemaAttribute()]

// Original file name:
// Generation date: 9/22/2010 9:23:24 AM
namespace Pinsonault.Application.Sandoz
{
    
    /// <summary>
    /// There are no comments for PathfinderSandozEntities in the schema.
    /// </summary>
    public partial class PathfinderSandozEntities : global::System.Data.Objects.ObjectContext
    {
        /// <summary>
        /// Initializes a new PathfinderSandozEntities object using the connection string found in the 'PathfinderSandozEntities' section of the application configuration file.
        /// </summary>
        public PathfinderSandozEntities() : 
                base("name=PathfinderSandozEntities", "PathfinderSandozEntities")
        {
            this.OnContextCreated();
        }
        /// <summary>
        /// Initialize a new PathfinderSandozEntities object.
        /// </summary>
        public PathfinderSandozEntities(string connectionString) : 
                base(connectionString, "PathfinderSandozEntities")
        {
            this.OnContextCreated();
        }
        /// <summary>
        /// Initialize a new PathfinderSandozEntities object.
        /// </summary>
        public PathfinderSandozEntities(global::System.Data.EntityClient.EntityConnection connection) : 
                base(connection, "PathfinderSandozEntities")
        {
            this.OnContextCreated();
        }
        partial void OnContextCreated();
    }
}
