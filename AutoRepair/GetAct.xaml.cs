using System;
using System.Collections.Generic;
using System.Windows;
using System.Data.SqlClient;

namespace AutoRepair
{
    public class clients_check
    {
        public string ID_client { get; set; }
        public string Surname { get; set; }
        public string First_name { get; set; }
        public string dob { get; set; }
        public string passport { get; set; }
        public string email { get; set; }
    }
    public partial class GetAct : Window
    {
        //отображение клиентов в таблице и выбор
        SqlConnection connection;
        Window parent;
        int id_employee;
        DateTime cur_date = DateTime.Now;
        string contract_id = DateTime.Now.ToString("yyyyddMMss");
        public GetAct(SqlConnection connection, Window parent, int id_employee)
        {
            InitializeComponent();
            this.Show();
            this.parent = parent;
            this.connection = connection;
            this.id_employee = id_employee;
            parent.Visibility = Visibility.Hidden;

            try
            {
                List<clients_check> check_client_list = new List<clients_check>();
                string sqlexpression = " SELECT * FROM dbo.Customers ";
                SqlCommand command = new SqlCommand(sqlexpression, connection);
                SqlDataReader reader = command.ExecuteReader();

                if (reader.HasRows)
                {

                    while (reader.Read())
                    {
                        clients_check st = new clients_check();
                        st.ID_client = reader.GetString(0);
                        st.Surname = reader.GetString(1);
                        st.First_name = reader.GetString(2);
                        st.dob = reader.GetDateTime(3).ToString("yyyy.dd.MM");
                        st.passport = reader.GetString(4);
                        st.email = reader.GetValue(5).ToString();
                        check_client_list.Add(st);
                    }
                    reader.Close();
                    grid.ItemsSource = check_client_list;
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

        private void choose_car(object sender, RoutedEventArgs e)
        {
            //выбор клиента и переход к машинам
            clients_check id = (clients_check)grid.SelectedItem;
            if (id != null)
            {
                string id_chose_client = id.ID_client;
                this.Visibility = Visibility.Hidden;
                new ChoseCar(connection, this, id_employee, cur_date, contract_id, id_chose_client);
            
            }


        }

    }
}
