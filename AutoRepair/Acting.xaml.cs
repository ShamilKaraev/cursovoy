using System;
using System.Data.SqlClient;
using System.Collections.Generic;
using System.Windows;


namespace AutoRepair
{
    //класс для отображения контрактов
    public class contracts_grid
    {
        public string service_name { get; set; }
        public string service_price { get; set; }

    }

    public partial class Acting : Window
    {
        Window parent;
        SqlConnection connection;
        string id_contract;
        string id_car;
        //объявление словаря для хеш таблицы
        private Dictionary<string, string> map;

        public Acting(SqlConnection connection, Window parent, string id_contract, string id_client, string id_car, DateTime cur_time, int id_employee)
        {
            //создание контракта
            InitializeComponent();
            this.Show();
            map = new Dictionary<string, string>();
            parent.Visibility = Visibility.Hidden;
            this.connection = connection;
            this.parent = parent;
            this.id_contract = id_contract;
            this.id_car = id_car;
            try
            {
                string sqlexpression = "INSERT INTO dbo.Сontracts VALUES(@id_contract, @id_client, @id_car, @id_employee, @date_act)";
                SqlCommand command = new SqlCommand(sqlexpression, connection);
                SqlParameter par_contract = new SqlParameter("@id_contract", id_contract);
                command.Parameters.Add(par_contract);
                SqlParameter par_client = new SqlParameter("@id_client", id_client);
                command.Parameters.Add(par_client);
                SqlParameter par_car = new SqlParameter("@id_car", id_car);
                command.Parameters.Add(par_car);
                SqlParameter par_employee = new SqlParameter("@id_employee", id_employee);
                command.Parameters.Add(par_employee);
                SqlParameter par_date = new SqlParameter("@date_act", cur_time);
                command.Parameters.Add(par_date);
                command.ExecuteNonQuery();

                //заполнение комбобокса с услугами
                sqlexpression = " SELECT * FROM dbo.Price_list_of_services ";
                command = new SqlCommand(sqlexpression, connection);
                SqlDataReader reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    while (reader.Read())
                    {

                        string local_id_serv = reader.GetString(0);
                        string local_name_serv = reader.GetString(1) + ", " + reader.GetValue(2).ToString() + " RUR";
                        services.Items.Add(local_name_serv);
                        map[local_name_serv] = local_id_serv;

                    }

                    reader.Close();
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


        private void to_add_service_Click(object sender, RoutedEventArgs e)
        {
            //добавление услуги
            try
            {
                if (services.Text != null)
                {
                    string id_service = map[services.Text];
                    string sqlexression = "INSERT INTO dbo.services_rendered VALUES (@id_contract, @id_service)";
                    SqlCommand command = new SqlCommand(sqlexression, connection);

                    SqlParameter par_contract = new SqlParameter("@id_contract", id_contract);
                    SqlParameter par_service = new SqlParameter("@id_service", id_service);

                    command.Parameters.Add(par_service);
                    command.Parameters.Add(par_contract);

                    command.ExecuteNonQuery();
                }
            }
            catch (SqlException er)
            {
                MessageBox.Show(er.Message);


            }

            //вывод информации о заказе (предварительно)
            try
            {

                List<contracts_grid> order_list = new List<contracts_grid>();
                string sqlexression = "SELECT service_name, PRICE FROM dbo.contract WHERE (id_contract = '" + id_contract + "')";
                SqlCommand command = new SqlCommand(sqlexression, connection);
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        contracts_grid st = new contracts_grid();
                        st.service_name = reader.GetString(0);
                        st.service_price = reader.GetValue(1).ToString();
                        order_list.Add(st);

                    }
                    grid_total.ItemsSource = order_list;
                    reader.Close();
                }
                else
                {
                    reader.Close();


                }

                //итог сумма 
                sqlexression = "SELECT total_price FROM total_service WHERE (id_contract = '"+ id_contract +"')";
                command = new SqlCommand(sqlexression, connection);
                reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    reader.Read();
                    total.Content = "Итог: " + reader.GetValue(0).ToString() + " RUR";
                    reader.Close();
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

        private void done_Click(object sender, RoutedEventArgs e)
        {
            //подтверждение
            MessageBox.Show("Заказ №" + id_contract + " успешно оформлен!");
            parent.Visibility = Visibility.Visible;
            this.Close();
        }

        private void Back_Click(object sender, RoutedEventArgs e)
        {
            //откат создания контракта
            try
            {

                string sqlexression = "DELETE FROM dbo.Сontracts WHERE id_contract = '" + id_contract + "'";
                SqlCommand command = new SqlCommand(sqlexression, connection);


                command.ExecuteNonQuery();


            }
            catch (SqlException er)
            {

                MessageBox.Show(er.Message);

            }

            parent.Visibility = Visibility.Visible;
            this.Close();
        }
    }
}
