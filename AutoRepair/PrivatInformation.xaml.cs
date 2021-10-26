using System;

using System.Windows;
using System.Data.SqlClient;

namespace AutoRepair
{
    //личная информация клиента
    public partial class PrivatInformation : Window
    {
        SqlConnection connection;
        Window parent;
        public PrivatInformation(SqlConnection connection, string id_client, string email, Window parent)
        {
            InitializeComponent();
            this.Show();
            this.parent = parent;
            parent.Visibility = Visibility.Hidden;
            this.connection = connection;
            //вывод информации в поля
            try
            {
                string SqlExpression = "SELECT Surname, Name, Data_of_birth, id_client FROM dbo.Customers WHERE  (id_client = " + id_client + ")";
                SqlCommand command = new SqlCommand(SqlExpression, connection);
                SqlDataReader reader = command.ExecuteReader();
                
                if (reader.HasRows) {
                    reader.Read();
                    email_lab.Content = email;
                    surname_lab.Content = reader.GetString(0);
                    first_name_lab.Content = reader.GetString(1);
                    dob_lab.Content = reader.GetDateTime(2).ToString("yyyy.dd.MM");
                
                }
                reader.Close();

            }
            catch (SqlException er) {
                MessageBox.Show(er.Message);
            
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
