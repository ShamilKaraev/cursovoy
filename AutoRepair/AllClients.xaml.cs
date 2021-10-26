using System.Data.SqlClient;
using System.Windows;
using System;
using System.Collections.Generic;

namespace AutoRepair
{
    public class clients
    {
        public string Surname { get; set; }
        public string First_name { get; set; }
        public string dob { get; set; }
        public string passport { get; set; }
        public string email { get; set; }
    }
    public partial class AllClients : Window
    {
        Window parent;
        SqlConnection connection;
        public AllClients(SqlConnection connection, Window parent)
        {
            //отображение клиентов автосервиса
            InitializeComponent();
            parent.Visibility = Visibility.Hidden;
            this.Show();
            this.connection = connection;
            this.parent = parent;
            try
            {
                List<clients> client_list = new List<clients>();
                string sqlexpression = " SELECT * FROM dbo.clients ";
                SqlCommand command = new SqlCommand(sqlexpression, connection);
                SqlDataReader reader = command.ExecuteReader();

                if (reader.HasRows)
                {

                    while (reader.Read())
                    {
                        clients st = new clients();
                        st.Surname = reader.GetString(0);
                        st.First_name = reader.GetString(1);
                        st.dob = reader.GetDateTime(2).ToString("yyyy.dd.MM");
                        st.passport = reader.GetString(3);
                        st.email = reader.GetValue(4).ToString();
                        client_list.Add(st);
                    }
                    reader.Close();
                    grid.ItemsSource = client_list;
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


        private void Back_Click(object sender, RoutedEventArgs e)
        {
            parent.Visibility = Visibility.Visible;
            this.Close();
        }
    }
}
