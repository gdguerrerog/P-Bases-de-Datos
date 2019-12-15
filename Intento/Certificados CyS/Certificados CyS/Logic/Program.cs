using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;
using Certificados_CyS.DataAccess;

namespace Certificados_CyS.Logic
{
    static class Program
    {
        /// <summary>
        /// Punto de entrada principal para la aplicación.
        /// </summary>
        [STAThread]
        static void Main()
        {
            DataBaseLogic logic = new DataBaseLogic(new ConnectionMySql());
            logic.Begin();
            LogInResult result = logic.logIn("Alejandra Lozano", "dcomercial111");

            Console.WriteLine(result.ok);
            if(result.ok) Console.WriteLine(result.administrativo.nombre);
            
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new Form1());
        }
    }
}
