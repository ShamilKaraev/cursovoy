using System;
using System.Windows;
using System.Data.SqlClient;
using System.Collections.Generic;

namespace AutoRepair
{
    public class car
    {
        public string id_car { get; set; }
        public string name_car { get; set; }
        public string vin_num { get; set; }

    }
    public partial class ChoseCar : Window
    {
        Window parent;
        SqlConnection connection;
        private Dictionary<string, string> map;
        // dictionary
        string id_contract;
        int id_employee;
        DateTime cur_time;
        string id_client;

        public ChoseCar(SqlConnection connection, Window parent, int id_employee, DateTime cur_time, string id_contract, string id_client)
        {
            InitializeComponent();
            List<car> cars_list = new List<car>(); //list
            map = new Dictionary<string, string>();
            this.Show();
            this.parent = parent;
            this.connection = connection;
            this.id_contract = id_contract;
            this.id_employee = id_employee;
            this.cur_time = cur_time;
            this.id_client = id_client;

            // try catch - заполнение combobox -> марки машин

            try
            {
                string sqlexpression = "SELECT id_brand, name_brand FROM dbo.Brands_cars";
                SqlCommand command = new SqlCommand(sqlexpression, connection);
                SqlDataReader reader = command.ExecuteReader();
                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        string local_id_brand = reader.GetString(0);
                        string local_name_brand = reader.GetString(1);
                        brands_combo.Items.Add(local_name_brand);
                        map[local_name_brand] = local_id_brand;

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


            try
            {
                //отображение автомобилей
                string sqlexpression = "SELECT * FROM dbo.cars";
                SqlCommand command = new SqlCommand(sqlexpression, connection);
                SqlDataReader reader = command.ExecuteReader();

                if (reader.HasRows)
                {
                    while (reader.Read())
                    {
                        car st = new car();
                        st.id_car = reader.GetValue(0).ToString();
                        st.name_car = reader.GetString(1);
                        st.vin_num = reader.GetString(2);
                        cars_list.Add(st);

                    }
                    reader.Close();
                    grid.ItemsSource = cars_list;

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



        private void Exist_Checked(object sender, RoutedEventArgs e)
        {
            but_exist.Visibility = Visibility.Visible;
            but_new.Visibility = Visibility.Hidden;
            grid.Visibility = Visibility.Visible;

            brand_lab.Visibility = Visibility.Hidden;
            brands_combo.Visibility = Visibility.Hidden;

            car_plate_lab.Visibility = Visibility.Hidden;
            car_plate_text.Visibility = Visibility.Hidden;

            vin_lab.Visibility = Visibility.Hidden;
            vin_text.Visibility = Visibility.Hidden;


        }

        private void New_Checked(object sender, RoutedEventArgs e)
        {
            but_exist.Visibility = Visibility.Hidden;
            but_new.Visibility = Visibility.Visible;
            grid.Visibility = Visibility.Hidden;

            brand_lab.Visibility = Visibility.Visible;
            brands_combo.Visibility = Visibility.Visible;

            car_plate_lab.Visibility = Visibility.Visible;
            car_plate_text.Visibility = Visibility.Visible;

            vin_lab.Visibility = Visibility.Visible;
            vin_text.Visibility = Visibility.Visible;


        }

        private void NextStep_EXIST(object sender, RoutedEventArgs e)
        {
            //выбор машины из грида
            car chosed_car = (car)grid.SelectedItem;
            if (chosed_car != null)
            {
                string id_car = chosed_car.id_car;
                new Acting(connection, this, id_contract, id_client, id_car, cur_time, id_employee);


            }


        }

        private void NextStep(object sender, RoutedEventArgs e)
        {
            //добавление новой машины и переход к другому окну
            try
            {
                if (brands_combo.Text != null && car_plate_text.Text != null && vin_text.Text != null) {
                    string id_car = DateTime.Now.ToString("yyyyddMMss");
                    string id_brand = map[brands_combo.Text];
                    string car_plate = car_plate_text.Text;
                    string vin_s = vin_text.Text;

                    string sqlexpression = "INSERT INTO dbo.CAR VALUES(@id_car_s, @id_brand_s, @car_plate_s, @vin_s)";
                    SqlCommand command = new SqlCommand(sqlexpression, connection);
                    SqlParameter par_id_car = new SqlParameter("@id_car_s", id_car);
                    SqlParameter par_id_brand = new SqlParameter("@id_brand_s", id_brand);
                    SqlParameter par_plate = new SqlParameter("@car_plate_s", car_plate);
                    SqlParameter par_vin = new SqlParameter("@vin_s", vin_s);
                    command.Parameters.Add(par_plate);
                    command.Parameters.Add(par_id_brand);
                    command.Parameters.Add(par_vin);
                    command.Parameters.Add(par_id_car);
                    command.ExecuteNonQuery();
                    new Acting(connection, this, id_contract, id_client, id_car, cur_time, id_employee);
                }
            }
            catch (SqlException er)
            {
                MessageBox.Show(er.Message);
                

            }


        }


    }
}
