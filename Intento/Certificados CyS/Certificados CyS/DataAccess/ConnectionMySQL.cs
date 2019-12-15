using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Text;

namespace Proyecto_Bases_de_Datos.DataAccess
{
    class ConnectionMySQL: IConnection {

        private MySqlConnection connection;
        const string HOST = "localhost";
        const string UID = "root";
        const string PASSWORD = "0000";
        const string DATABASE = "test";

        public ConnectionMySQL() {}

        public Exception Connect() {
            string connectionString = string.Format("server={0};uid={1};pwd={2};database={3};", HOST, UID, PASSWORD, DATABASE);
            try {
                connection = new MySqlConnection(connectionString);
                connection.Open();
                return null;
            } catch(Exception ex)  {
                return ex;
            }
        }
    }
}
