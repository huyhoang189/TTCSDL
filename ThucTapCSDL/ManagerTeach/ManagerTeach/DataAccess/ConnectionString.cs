using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ManagerTeach
{
    class ConnectionString
    {
        public string getStringConnection()
        {
            string connectionString = @"Data Source=" + System.Environment.MachineName + ";" + "Initial Catalog=QUAN_LY_GIAO_VIEN;Integrated Security=True";
            return connectionString;
        }
    }
}
