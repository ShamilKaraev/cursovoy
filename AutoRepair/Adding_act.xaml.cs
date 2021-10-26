using System;
using System.Windows;
using System.Data.SqlClient;

namespace AutoRepair
{

    public partial class Adding_act : Window
    {
        SqlConnection connection;
        Window parent;
        public Adding_act(SqlConnection connection, Window parent)
        {
            InitializeComponent();
            this.parent = parent;
            parent.Visibility = Visibility.Hidden;
            this.connection = connection;
            this.Show();
        }

        private void Back(object sender, RoutedEventArgs e)
        {
            parent.Visibility = Visibility.Visible;
            this.Close();
        }

        private void but_add_Click(object sender, RoutedEventArgs e)
        {
            //добавление новой услуги в таблицу 
            string ser_nam = service_name_text.Text;
            string pri = price_text.Text;
            string num = DateTime.Today.ToString("yyyyddMMss");

            if (ser_nam.Length != 0 && pri.Length != 0) {

                try
                {
                    string sqlexpression = "INSERT INTO dbo.Price_list_of_services VALUES(@num_act, @name_service, @price)";
                    SqlCommand command = new SqlCommand(sqlexpression, connection);
                    SqlParameter num_par = new SqlParameter("@num_act", num);
                    command.Parameters.Add(num_par);
                    SqlParameter name_par = new SqlParameter("@name_service", ser_nam);
                    command.Parameters.Add(name_par);
                    SqlParameter pri_par = new SqlParameter("@price", pri);
                    command.Parameters.Add(pri_par);
                    command.ExecuteNonQuery();
                    MessageBox.Show("Услуга добавлена!");
                    service_name_text.Text = "";
                    price_text.Text = "";

                }
                catch (SqlException er)
                {
                    MessageBox.Show(er.Message);
                }
            }
            else {

                MessageBox.Show("Заполните поля!");
            }

        }
    }
}
