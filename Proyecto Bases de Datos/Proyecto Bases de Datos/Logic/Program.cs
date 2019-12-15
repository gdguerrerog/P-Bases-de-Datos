using System;
using Proyecto_Bases_de_Datos.DataAccess;

namespace Proyecto_Bases_de_Datos.Logic
{
    class Program
    {
        static void Main(string[] args)
        {
            new DatabaseLogic(new ConnectionMySQL()).Begin();

            Console.WriteLine("Hello World!");
            Console.ReadKey();


        }
    }
}
