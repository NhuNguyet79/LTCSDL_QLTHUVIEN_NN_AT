using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HTQuanLyThuVien.Database
{
    public class DBConnection
    {
        public static string connectionString =
            @"Data Source=.\SQLEXPRESS;Initial Catalog=QLThuVien;Integrated Security=True";

        public static SqlConnection GetConnection()
        {
            return new SqlConnection(connectionString);
        }
    }
}
