using System;

namespace PlatformWellActual
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");

            BusinessLogic.ProcessAPI processAPI = new BusinessLogic.ProcessAPI();
            processAPI.Entry();
        }
    }
}
