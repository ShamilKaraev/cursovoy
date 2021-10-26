using System;
using System.Collections.Generic;
using System.Windows;
using System.Data.SqlClient;

namespace AutoRepair
{

    public partial class HistoryRepair : Window
    {
        public class history
        {
            public string brand { get; set; }
            public string car_plate { get; set; }
            public string service { get; set; }
            public string price { get; set; }
        }

        Window parent;
        SqlConnection connection;
        public HistoryRepair(SqlConnection connection, Window parent, string id_client)
        {
            //история ремонта каждого владельца автомобиля
            InitializeComponent();
            this.parent = parent;
            this.connection = connection;
            parent.Visibility = Visibility.Hidden;
            this.Show();
            try
            {
                List<history> history_list = new List<history>();
                string sqlexpression = " SELECT name_brand, car_plate, service_name, PRICE FROM dbo.history_repair where (id_client = '"+ id_client+ "') ";
                SqlCommand command = new SqlCommand(sqlexpression, connection);
                SqlDataReader reader = command.ExecuteReader();

                if (reader.HasRows)
                {

                    while (reader.Read())
                    {
                        history st = new history();
                        st.brand = reader.GetString(0);
                        st.car_plate = reader.GetString(1);
                        st.service = reader.GetString(2);
                        st.price = reader.GetValue(3).ToString();
                        history_list.Add(st);
                    }
                    reader.Close();
                    grid.ItemsSource = history_list;
                }
                else
                {

                    reader.Close();

                }

            }
            catch (SqlException er)
            {
                MessageBox.Show(er.Message);
            }



        }

        private void Back(object sender, RoutedEventArgs e)
        {
            parent.Visibility = Visibility.Visible;
            this.Close();
        }

    }
}
