using System;
using System.Windows;
using System.Data.SqlClient;
using System.Collections.Generic;

namespace AutoRepair
{
    //статистика продаж
    public class sells_stat { 
       public string id_contract { get; set; }
       public string surname { get; set; }
       public string price { get; set; }
    }

    public partial class ShowStat : Window
    {
        SqlConnection connection;
        Window parent;
        public ShowStat(SqlConnection connection, Window parent)
        {
            //запись в класс данных об оказанных услугах
            InitializeComponent();
            this.Show();
            parent.Visibility = Visibility.Hidden;
            this.parent = parent;
            this.connection = connection;
            List<sells_stat> stat_list = new List<sells_stat>();
            string sqlexpression = " SELECT * FROM dbo.service_rended ";
            SqlCommand command = new SqlCommand(sqlexpression, connection);
            SqlDataReader reader = command.ExecuteReader();
            
            if (reader.HasRows)
            {

                while (reader.Read())
                {
                    sells_stat st = new sells_stat();
                    st.id_contract = reader.GetString(0);
                    st.surname = reader.GetString(1);
                    st.price = reader.GetValue(2).ToString();
                    stat_list.Add(st);
                }
                reader.Close();
                grid.ItemsSource = stat_list;
            }
            else
            {

                reader.Close();

            }


        }

        private void Back_Click(object sender, RoutedEventArgs e)
        {
            //назад
            parent.Visibility = Visibility.Visible;
            this.Close();
        }
    }
}
