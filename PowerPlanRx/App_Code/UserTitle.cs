using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Configuration;

/// <summary>
/// Summary description for UserTitle
/// </summary>
public class UserTitle
{
    #region Instance properties & methods

    public string Name { get; private set; }
    public int ID { get; private set; }
    public bool ApprovalStatus { get; private set; }

    #endregion

    #region Static properties & methods

    static Dictionary<int, UserTitle> _titles = new Dictionary<int, UserTitle>();

	static UserTitle()
	{
        using ( SqlConnection cn = new SqlConnection(ConfigurationManager.ConnectionStrings["impact"].ConnectionString) )
        {
            using ( SqlCommand cmd = new SqlCommand("select title_id, title_name, approval_status_indicator from lkp_user_titles", cn) )
            {
                cn.Open();
                using ( SqlDataReader rdr = cmd.ExecuteReader() )
                {
                    UserTitle title;
                    while ( rdr.Read() )
                    {
                        title = new UserTitle()
                        {
                            ID = rdr.GetInt32(0),
                            Name = rdr.GetString(1),
                            ApprovalStatus = rdr.GetBoolean(2)
                        };

                        _titles.Add(title.ID, title);
                    }
                }
            }
        }
	}

    /// <summary>
    /// Retreives a UserTitle object by id.  If the requested title is not found null is returned.
    /// </summary>
    /// <param name="id">ID of the title to return.</param>
    /// <returns>UserTitle instance</returns>
    public static UserTitle GetTitleByID(int id)
    {
        if ( _titles.ContainsKey(id) )
            return _titles[id];

        return null;
    }

    /// <summary>
    /// Returns a UserTitle object for the current user.  If the user has not selected a title this property will return null.
    /// </summary>
    public static UserTitle CurrentTitle
    {
        get { return GetTitleByID(CurrentTitleID); }
    }

    /// <summary>
    /// Returns whether the current user's selected title has permission to approve a campaign.  If no title has been selected the value will default to False.
    /// </summary>
    public static bool CurrentUserCanApprove
    {
        get
        {
            UserTitle title = GetTitleByID(CurrentTitleID);
            if ( title != null )
                return title.ApprovalStatus;

            return false;
        }
    }

    /// <summary>
    /// Returns the name of the current user's selected title.  If no title has been selected the value will default to an empty string.
    /// </summary>
    public static string CurrentTitleName
    {
        get
        {
            UserTitle title = GetTitleByID(CurrentTitleID);
            if ( title != null )
                return title.Name;

            return "";
        }
    }

    /// <summary>
    /// Returns the id of the current user's selected title.  If no title has been selected the return value is 0.
    /// </summary>
    public static int CurrentTitleID
    {
        get
        {
            object id = HttpContext.Current.Session["titleID"];
            if ( id != null )
                return (int)id;

            return 0;
        }
    }

    public static bool CurrentUserIsAccountExecutive
    {
        get { return CurrentTitleID == 1; }
    }

    public static bool CurrentUserIsSAE
    {
        get { return CurrentTitleID == 2; }
    }

    public static bool CurrentUserIsAdmin
    {
        get { return CurrentTitleID == 11; }
    }

    #endregion

}
