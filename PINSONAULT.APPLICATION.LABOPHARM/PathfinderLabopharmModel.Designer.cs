﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:2.0.50727.3615
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

[assembly: global::System.Data.Objects.DataClasses.EdmSchemaAttribute()]

// Original file name:
// Generation date: 11/17/2010 9:41:50 AM
namespace Pinsonault.Application.Labopharm
{
    
    /// <summary>
    /// There are no comments for PathfinderLabopharmEntities in the schema.
    /// </summary>
    public partial class PathfinderLabopharmEntities : global::System.Data.Objects.ObjectContext
    {
        /// <summary>
        /// Initializes a new PathfinderLabopharmEntities object using the connection string found in the 'PathfinderLabopharmEntities' section of the application configuration file.
        /// </summary>
        public PathfinderLabopharmEntities() : 
                base("name=PathfinderLabopharmEntities", "PathfinderLabopharmEntities")
        {
            this.OnContextCreated();
        }
        /// <summary>
        /// Initialize a new PathfinderLabopharmEntities object.
        /// </summary>
        public PathfinderLabopharmEntities(string connectionString) : 
                base(connectionString, "PathfinderLabopharmEntities")
        {
            this.OnContextCreated();
        }
        /// <summary>
        /// Initialize a new PathfinderLabopharmEntities object.
        /// </summary>
        public PathfinderLabopharmEntities(global::System.Data.EntityClient.EntityConnection connection) : 
                base(connection, "PathfinderLabopharmEntities")
        {
            this.OnContextCreated();
        }
        partial void OnContextCreated();
    }
}
