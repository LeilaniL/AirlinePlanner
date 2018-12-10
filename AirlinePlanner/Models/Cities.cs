using System;
using System.Collections.Generic;
using MySql.Data.MySqlClient;
using AirlinePlanner;

namespace AirlinePlanner.Models
{
    public class City
    {
        private int _id;
        private string _name;

        public City(string Name, int Id = 0)
        {
            _id = Id;
            _name = Name;
        }
        public string GetName()
        {
            return _name;
        }
        public int GetId()
        {
            return _id;
        }
    }

}
