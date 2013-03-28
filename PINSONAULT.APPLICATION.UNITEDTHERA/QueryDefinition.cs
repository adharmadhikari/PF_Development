using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Pinsonault.Data;
using Pinsonault.Data.Reports;
using Pinsonault.Application;
using PathfinderModel;
using System.Collections.Specialized;
using System.Web;

namespace Pinsonault.Application.UnitedThera
{
    public class IssueReportQueryDefinition : QueryDefinition
    {
        public IssueReportQueryDefinition(string EntityTypeName, NameValueCollection queryString)
            : base(EntityTypeName, queryString)
        {
        }

        public static string SelectFields
        {
            get
            {
                return "Issue_ID, Issue_Name";
            }
        }

        public static string SelectFieldsGrid
        {
            get
            {

                return "Issue_ID, Issue_Name";
            }
        }
        public static string AggrFields { get { return "Count(User_ID), PercentCount(User_ID)"; } }
        static string _expr = null;
        public static string ExprFields
        {
            get
            {
                return _expr;
            }
        }

        public override string Select { get { return SelectFields; } }
        public override string Aggregate
        {
            get { return AggrFields; }
        }
        public override string Expressions { get { return ExprFields; } }
        public override string Sort
        {
            get { return "Issue_Name"; }
        }
    }

    public class DetailsQueryDefinition : UserRequiredQueryDefinition
    {
        public override string Select { get { return SelectFields; }}
        public override string Aggregate{get { return AggrFields; }}

        public static string SelectFields
        {
            get
            {
                return "Account_Manager, Plan_Name, Contact_Date, Issue_Name, Contact_Name, Followup_Date, Status_Name";
            }
        }
        public static string SelectFieldsGrid
        {
            get
            {

                return "Account_Manager, Plan_Name, Contact_Date, Issue_Name, Contact_Name, Followup_Date, Status_Name";
            }
        }

        public static string AggrFields { get { return "Count(RC_Report_ID)"; } }

        public DetailsQueryDefinition(string EntityTypeName, NameValueCollection queryString)
            : base(EntityTypeName, queryString)
        {
        }
    }

    public class RCRDrilldownQueryDefinition : UserRequiredQueryDefinition
    {
        public override string Select { get { return SelectFields; } }
        public override string Aggregate { get { return AggrFields; } }

        public static string SelectFields
        {
            get
            {
                return "Account_Manager, Plan_Name, Geography_Name, Contact_Date, Section_Name, Issue_Name, Other_Issue, Drug_Name, Status_Name, ASSIST_Desc, Contact_Name, Team_Comments";
            }
        }

        public static string AggrFields { get { return "Count(RC_Report_ID)"; } }

        public RCRDrilldownQueryDefinition(string EntityTypeName, NameValueCollection queryString)
            : base(EntityTypeName, queryString)
        {
        }
    }

    public class PCNBINReportQueryDefinition : UserRequiredQueryDefinition
    {
        public override string Select { get { return SelectFields; } }
        public static string SelectFields
        {
            get
            {
                return "Plan_Name, Plan_State, Section_Name, BIN_Number, PCN_Number";
            }
        }

        public PCNBINReportQueryDefinition(string EntityTypeName, NameValueCollection queryString)
            : base(EntityTypeName, queryString)
        {
        }
    }
}

