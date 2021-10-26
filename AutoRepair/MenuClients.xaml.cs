using System;
using System.Data.SqlClient;
using System.Windows;


namespace AutoRepair
{

    public partial class MenuClients : Window
    {
        //клиентские возможности
        private SqlConnection connection;
        private Window parent;
        string email;
        string id_client;
        public MenuClients(string email, int id_role, string id_client, string last_name, string first_name, SqlConnection connection, Window parent)
        {
            InitializeComponent();
            this.Show();
            this.parent = parent;
            this.connection = connection;
            this.id_client = id_client;
            this.email = email;
        }

        private void Back(object sender, RoutedEventArgs e)
        {
            parent.Visibility = Visibility.Visible;
            this.Close();
        }

        private void history_Click(object sender, RoutedEventArgs e)
        {
            //просмотр истории
            new HistoryRepair(connection, this, id_client);
        }

        private void privat_info_Click(object sender, RoutedEventArgs e)
        {
            //личное инфо
            new PrivatInformation(connection, id_client, email, this);
        }

        private void show_actions_Click(object sender, RoutedEventArgs e)
        {

        }
    }
}
