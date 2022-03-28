using System;

namespace PlatformWellActual
{
    class Program
    {
        static void Main(string[] args)
        {
            BusinessLogic.ProcessAPI processAPI = new BusinessLogic.ProcessAPI();
            Console.WriteLine("=================================================================================");
            Console.WriteLine("Press R + Enter : For call api");
            Console.WriteLine("Press Q + Enter : Exit the application");
            Console.WriteLine("=================================================================================");
            while (true)
            {
                switch (Console.ReadLine().ToUpper())
                {
                    case "R":
                        processAPI.Entry();
                        break;
                    case "Q":
                        Environment.Exit(0);
                        break;
                }
            }

                
            
        }
    }
}
