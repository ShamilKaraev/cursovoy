using System.Data.SqlClient;
using System.Windows;
using System.Text.RegularExpressions;
using System.Net.Mail;
using System;


namespace AutoRepair
{
    //создание нового пользователя
    public partial class NewUser : Window
    {
        private SqlConnection connection;
        private Window parent;
        public NewUser(SqlConnection connection, Window parent)
        {
            InitializeComponent();
            this.Show();
            this.parent = parent;
            this.connection = connection;
        }

        private void Back(object sender, RoutedEventArgs e)
        {
            parent.Visibility = Visibility.Visible;
            this.Close();
        }
        //проверка полей
        public static string check_name(string name)
        {

            string name_local = name.Trim();
            if (name_local.Length == 0)
                return "Заполните поле";
            if (name_local.Length > 50)
                return "Слишком длинное имя";
            Regex regex = new Regex(@"^[A-zА-яЁё]+$");
            if (!regex.IsMatch(name_local))
                return "Только буквы";
            return "";
        }
        //проверка полей
        public static string check_surname(string name)
        {

            string name_local = name.Trim();
            if (name_local.Length == 0)
                return "Заполните поле";
            if (name_local.Length > 50)
                return "Слишком длинное имя";
            Regex regex = new Regex(@"^[A-zА-яЁё]*$");
            if (!regex.IsMatch(name_local))
                return "Только буквы";
            return "";
        }
        //проверка полей
        public static string check_dob(DateTime date)
        {
            DateTime now = DateTime.Today;
            int year_dif = now.Year - date.Year;
            if (year_dif < 1 || year_dif > 110)
                return "Неверная дата";
            return "";
        }
        //проверка полей

        public static string check_passport(string passport)
        {
            string passport_local = passport.Trim();
            if (passport_local.Length == 0)
                return "Заполните поле";
            if (passport_local.Length != 10)
                return "СерияНомер";
            Regex regex = new Regex(@"^\d{10}$");
            if (!regex.IsMatch(passport_local))
                return "Только цифры";
            return "";
        }
        //проверка полей
        public static string check_email(string email)
        {
            string email_local = email;
            if (email_local.Length == 0)
                return "Заполните поле";
            if (email_local.Length > 30)
                return "Слишком длинный адрес";
            try
            {
                MailAddress m = new MailAddress(email);
                return "";
            }
            catch (FormatException)
            {
                return "Неверный формат!";
            }
        }
        //проверка полей
        private static string check_password(string new_password, string re_password)
        {
            if (new_password != re_password)
                return "Не совпадение паролей";
            if (new_password.Length == 0)
                return "Заполните поле";
            if (new_password.Length > 50)
                return "Уменьшите пароль";

            return "";
        }
        //переход к регистрации и записи в таблицу
        private void Done_Click(object sender, RoutedEventArgs e)
        {
            er_email.Visibility = Visibility.Hidden;
            er_surname.Visibility = Visibility.Hidden;
            er_name.Visibility = Visibility.Hidden;
            er_dob.Visibility = Visibility.Hidden;
            er_passport.Visibility = Visibility.Hidden;
            er_password.Visibility = Visibility.Hidden;

            bool er = false;
            string error_msg = "";
            if ((error_msg = check_email(login.Text)) != "")
            {
                er = true;
                er_email.Content = error_msg;
                er_email.Visibility = Visibility.Visible;
            }
            if ((error_msg = check_surname(surname.Text)) != "")
            {
                er = true;
                er_surname.Content = error_msg;
                er_surname.Visibility = Visibility.Visible;
            }
            if ((error_msg = check_name(first_name.Text)) != "")
            {
                er = true;
                er_surname.Content = error_msg;
                er_surname.Visibility = Visibility.Visible;
            }

            if ((error_msg = check_dob(dob.DisplayDate)) != "")
            {
                er = true;
                er_dob.Content = error_msg;
                er_dob.Visibility = Visibility.Visible;
            }

            if ((error_msg = check_passport(passport.Text)) != "")
            {
                er = true;
                er_passport.Content = error_msg;
                er_passport.Visibility = Visibility.Visible;
            }

            if ((error_msg = check_password(password.Password, confirm_password.Password)) != "")
            {
                er = true;
                er_password.Content = error_msg;
                er_password.Visibility = Visibility.Visible;
            }

            if (!er)
            {

                string login_text = login.Text;
                string last_name_text = surname.Text;
                string first_name_text = first_name.Text;
                DateTime dob_text = dob.DisplayDate;
                string passport_text = passport.Text;
                string password_text = password.Password;
                string id_client = DateTime.Now.ToString("yyyyddMMss");

                er_email.Visibility = Visibility.Hidden;
                er_surname.Visibility = Visibility.Hidden;
                er_name.Visibility = Visibility.Hidden;
                er_dob.Visibility = Visibility.Hidden;
                er_passport.Visibility = Visibility.Hidden;
                er_password.Visibility = Visibility.Hidden;
                
                
                
                //добавление в таблицу данных

                try
                {
                    string sqlExpression = " INSERT INTO Users VALUES (@login_val, @password_value, 2) ";
                    SqlCommand command = new SqlCommand(sqlExpression, connection);
                    SqlParameter login_par = new SqlParameter("@login_val", login_text);
                    command.Parameters.Add(login_par);
                    SqlParameter password_param = new SqlParameter("@password_value", password_text);
                    command.Parameters.Add(password_param);
                    command.ExecuteNonQuery();

                    sqlExpression = " INSERT INTO Customers VALUES (@id_client_value, @last_name_value, @name_value, @dob_value, @passport_value, @login_value) ";
                    command = new SqlCommand(sqlExpression, connection);
                    SqlParameter id_client_param = new SqlParameter("@id_client_value", id_client);
                    SqlParameter login_param = new SqlParameter("@login_value", login_text);
                    SqlParameter surname_param = new SqlParameter("@last_name_value", last_name_text);
                    SqlParameter name_param = new SqlParameter("@name_value", first_name_text);      
                    SqlParameter dob_param = new SqlParameter("@dob_value", dob_text);      
                    SqlParameter passport_param = new SqlParameter("@passport_value", passport_text);
                    command.Parameters.Add(id_client_param);
                    command.Parameters.Add(login_param);
                    command.Parameters.Add(surname_param);
                    command.Parameters.Add(name_param);               
                    command.Parameters.Add(dob_param);               
                    command.Parameters.Add(passport_param);              
                    command.ExecuteNonQuery();                    

                    MessageBox.Show("Вы зарегистрированы!");
                    parent.Visibility = Visibility.Visible;
                    this.Close();

                }

                catch (SqlException exept)
                {
                    MessageBox.Show((exept.Number).ToString() + " " + exept.Message);
                }



            }
        }
    }
}
