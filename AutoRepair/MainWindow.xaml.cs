using System;
using System.Windows;
using System.Data.SqlClient;

namespace AutoRepair
{
    public partial class MainWindow : Window
    {
        SqlConnection connection;

        public MainWindow()
        {
            //подключение к БД
            InitializeComponent();
            try
            {
                SqlConnectionStringBuilder builder = new SqlConnectionStringBuilder
                {
                    DataSource = @"LAPTOP-SIQUT22A\SQLEXPRESS",
                    InitialCatalog = "КП",
                    IntegratedSecurity = true
                };
                connection = new SqlConnection(builder.ConnectionString);

            }
            catch (SqlException e)
            {
                MessageBox.Show("Ошибка подключения" + e.ToString());
            }
            connection.Open();

        }

        private void worker_entry(object sender, RoutedEventArgs e)
        {
            entry_like_worker.Visibility = Visibility.Visible;
            entry_like_client.Visibility = Visibility.Visible;
            warning_mes.Visibility = Visibility.Hidden;

        }

        private void client_entry(object sender, RoutedEventArgs e)
        {
            entry_like_worker.Visibility = Visibility.Hidden;
            entry_like_client.Visibility = Visibility.Visible;
            warning_mes.Visibility = Visibility.Hidden;
        }

        private void worker_entry_but(object sender, RoutedEventArgs e)
        {

            if (login_text.Text.Length > 0 && password_text.Password.Length > 0)
            {
                //проверка логина пароля сотрудников
                try
                {
                    SqlParameter login_parameter = new SqlParameter("@login_val", login_text.Text);
                    SqlParameter password_parameter = new SqlParameter("@password_val", password_text.Password);
                    string sqlExpression = "SELECT login_user, id_role, id_emloyee, Surname, Name FROM dbo.[authorization] WHERE(login_user = @login_val) AND (password_user = @password_val)";
                    SqlCommand command = new SqlCommand(sqlExpression, connection);
                    command.Parameters.Add(login_parameter);
                    command.Parameters.Add(password_parameter);
                    SqlDataReader reader = command.ExecuteReader();
                    if (reader.HasRows)
                    {
                        reader.Read();
                        string email = reader.GetString(0);
                        int id_role = reader.GetInt32(1);
                        int id_employee = reader.GetInt32(2);
                        string last_name = reader.GetString(3);
                        string first_name = reader.GetString(4);
                        reader.Close();
                        password_text.Password = "";
                        this.Visibility = Visibility.Hidden;
                        warning_mes.Visibility = Visibility.Hidden;
                        new MenuWorkers(email, id_role, id_employee, last_name, first_name, connection, this);

                    }
                    else
                    {
                        reader.Close();
                        warning_mes.Visibility = Visibility.Visible;
                    }
                }
                catch (SqlException er)
                {
                    MessageBox.Show("Ошибка " + er.ToString());
                }
            }


        }

        private void client_entry_but(object sender, RoutedEventArgs e)
        {

            if (login_text.Text.Length > 0 && password_text.Password.Length > 0)
            {
                //проверка логина пароля для клиента
                try
                {
                    SqlParameter login_parameter = new SqlParameter("@login_val", login_text.Text);
                    SqlParameter password_parameter = new SqlParameter("@password_val", password_text.Password);
                    string sqlExpression = "SELECT login_user, id_role, id_client, Surname, Name FROM dbo.authorization_clients WHERE(login_user = @login_val) AND(password_user = @password_val) AND(id_role = 2)";
                    SqlCommand command = new SqlCommand(sqlExpression, connection);
                    command.Parameters.Add(login_parameter);
                    command.Parameters.Add(password_parameter);
                    SqlDataReader reader = command.ExecuteReader();
                    if (reader.HasRows)
                    {
                        reader.Read();
                        string email = reader.GetString(0);
                        int id_role = reader.GetInt32(1);
                        string id_client = reader.GetString(2);
                        string last_name = reader.GetString(3);
                        string first_name = reader.GetString(4);
                        reader.Close();
                        password_text.Password = "";
                        this.Visibility = Visibility.Hidden;
                        warning_mes.Visibility = Visibility.Hidden;
                        new MenuClients(email, id_role, id_client, last_name, first_name, connection, this);

                    }
                    else
                    {
                        reader.Close();
                        warning_mes.Visibility = Visibility.Visible;
                    }
                }
                catch (SqlException er)
                {
                    MessageBox.Show("Ошибка " + er.ToString());
                }
            }


        }

        private void reg_but_Click(object sender, RoutedEventArgs e)
        {
            this.Visibility = Visibility.Hidden;
            new NewUser(connection, this);
        }
    }
}
