using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ManagerTeach
{
    class DataBL
    {
        public DataBL() { }
        ~DataBL() { }
        private DataSet getData()
        {
            string query = "select * from GiaoVien";
            DataSet data = getDataSet(query);
            return data;
        }
        public DataSet getDataSet(string query)
        {
            DataTable temp = new DataTable();
            ConnectionString cnstr = new ConnectionString();
            string connectionString = cnstr.getStringConnection();
            try
            {
                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    connection.Open();
                    SqlDataAdapter adapter = new SqlDataAdapter(query, connection);
                    adapter.Fill(temp);
                    connection.Close();

                }
            }
            catch (Exception e)
            {
                MessageBox.Show("Erroorrr", "MediaM");
            }
            finally
            {

            }


            DataSet dataMusic = new DataSet();
            dataMusic.Tables.Add(temp);
            return dataMusic;
        }
    }
}
