using System;
using System.Collections.Generic;
using MySql.Data.MySqlClient;
using AirlinePlanner;

namespace AirlinePlanner.Models
{

    public class Flight
    {
        private int _id;
        private int _statusid;
        private string _dept_time;
        private int _dept_city_id;
        private string _arr_time;
        private int _arr_city_id;

        public Flight(int dept_city, string dept_time, int arr_city, string arr_time)
        {
            _dept_city_id = dept_city;
            _dept_time = dept_time;
            _arr_city_id = arr_city;
            _arr_time = arr_time;
        }
        public void SaveFlight()
        {
            MySqlConnection conn = DB.Connection();
            conn.Open();
            var cmd = conn.CreateCommand() as MySqlCommand;
            cmd.CommandText = @"INSERT INTO flights (dept_city_id, dept_time, arr_city_id, arr_time) VALUES (@deptCity, @deptTime, @arrCity, @arrTime);";
            MySqlParameter dept_city_id = new MySqlParameter();
            dept_city_id.ParameterName = "@deptCity";
            dept_city_id.Value = this._dept_city_id;
            cmd.Parameters.Add(dept_city_id);
            MySqlParameter dept_time = new MySqlParameter();
            dept_time.ParameterName = "@deptTime";
            dept_time.Value = this._dept_time;
            cmd.Parameters.Add(dept_time);
            MySqlParameter arr_city_id = new MySqlParameter();
            arr_city_id.ParameterName = "@arrCity";
            arr_city_id.Value = this._arr_city_id;
            cmd.Parameters.Add(arr_city_id);
            MySqlParameter arr_time = new MySqlParameter();
            arr_time.ParameterName = "@arrTime";
            arr_time.Value = this._arr_time;
            cmd.Parameters.Add(arr_time);
            cmd.ExecuteNonQuery();
            _id = (int)cmd.LastInsertedId;
            conn.Close();
            if (conn != null)
            {
                conn.Dispose();
            }
        }
    }
    public class Program
    {
        public static void Main()
        {
            Console.WriteLine("What city are you leaving from? (Input id number)");
            int inputDeptCity = int.Parse(Console.ReadLine());
            Console.WriteLine("What city are you going to? (Input id number)");
            int inputArrCity = int.Parse(Console.ReadLine());
            Console.WriteLine("What time of day do you leave? Morning | Afternoon | Evening");
            string inputDeptTime = Console.ReadLine();
            Console.WriteLine("What time of day do you arrive? Morning | Afternoon | Evening");
            string inputArrTime = Console.ReadLine();
            Flight userFlight = new Flight(inputDeptCity, inputDeptTime, inputArrCity, inputArrTime);
            userFlight.SaveFlight();
            // allFlights.GetFlight();




        }
    }

}
