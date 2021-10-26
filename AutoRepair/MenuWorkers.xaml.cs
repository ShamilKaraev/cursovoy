using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Data.SqlClient;

namespace AutoRepair
{
  
    public partial class MenuWorkers : Window
    {
        //возможности работников
        SqlConnection connection;
        Window parent;
        int id_employee;
        public MenuWorkers(string email, int id_role, int id_employee, string last_name, string first_name, SqlConnection connection, Window parent)
        {
            InitializeComponent();
            this.connection = connection;
            this.parent = parent;
            this.id_employee = id_employee;
            this.Show();

            if (id_role == 1)
            {
                stat.Visibility = Visibility.Visible;
                to_add.Visibility = Visibility.Visible;
                show_clients.Visibility = Visibility.Visible;

            }
            else if (id_role == 3)
            {
                get_action.Visibility = Visibility.Visible;
               

            }
            else { 
            
            
            }

        }
        //назад
        private void Back(object sender, RoutedEventArgs e)
        {
            parent.Visibility = Visibility.Visible;
            this.Close();
        }
        //статистика
        private void stat_Click(object sender, RoutedEventArgs e)
        {
            new ShowStat(connection, this);
        }
        //добавить новую услугу
        private void to_add_act(object sender, RoutedEventArgs e)
        {
            new Adding_act(connection, this);
        }
        //клиенты сервиса
        private void show_clients_Click(object sender, RoutedEventArgs e)
        {
            new AllClients(connection, this);
        }
        //оформить услугу
        private void get_action_Click(object sender, RoutedEventArgs e)
        {
            new GetAct(connection, this, id_employee);
        }

    }
}
