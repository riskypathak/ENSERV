using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;

public class SaveFile
{
    public string FileName { set; get; }
    public string FileExtension { set; get; }
    public byte[] FileContent { set; get; }

    public Result SaveFileInDB()
    {
        Result Result = new Result();
        string strConnection = "data source=YourSQLServer;initial catalog=YourDatabase;user id=YourUserID;password=YourPassword";
        //string strConnection = "data source=DBSRV2\\SQL2008;initial catalog=ReedyScore;user id=bharatteam;password=sql12*";
        //"Data Source=Imdadhusen\\SQLEXPRESS;Initial Catalog=SaveFileExampleDB;Integrated Security=True;Pooling=False"
        using (SqlConnection conn = new SqlConnection(strConnection))
        {
            SqlCommand cmd = new SqlCommand();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.CommandText = "SaveFilesInDB";
            cmd.Connection = conn;

            cmd.Parameters.AddWithValue("@FileContent", FileContent);
            cmd.Parameters.AddWithValue("@FileName", FileName);
            cmd.Parameters.AddWithValue("@FileExtension", FileExtension);
            try
            {
                conn.Open();
                cmd.ExecuteNonQuery();
                Result.IsError = false;
            }
            catch (Exception ex)
            {
                Result.IsError = true;
                Result.ErrorMessage = ex.Message;
                Result.InnerException = ex.InnerException.ToString();
                Result.StackTrace = ex.StackTrace.ToString();
            }
            finally
            {
                conn.Close();
                cmd.Dispose();
                conn.Dispose();
            }
        }
        return Result;
    }
}