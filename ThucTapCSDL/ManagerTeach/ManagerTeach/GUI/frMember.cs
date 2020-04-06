using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ManagerTeach.GUI
{
    public partial class frMember : Form
    {
        public frMember()
        {
            InitializeComponent();
        }
        public frMember(string id,int type) : this()
        {
            DataBL data = new DataBL();
           
            if (type == 1)
            {

                string query = "EXEC showmembb '"+id+"'";
                DataGridView.DataSource = data.getDataSet(query).Tables[0];
             
            }
        }

      

        private void bunifuImageButton1_Click(object sender, EventArgs e)
        {

            this.Close(); 
        }
    }
}
