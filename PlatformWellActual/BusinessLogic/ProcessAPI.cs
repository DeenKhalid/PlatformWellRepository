using Newtonsoft.Json;
using PlatformWellActual.DataModel;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using PlatformWellActual.DataAccess;


namespace PlatformWellActual.BusinessLogic
{
    public class ProcessAPI
    {
        private ConfigurationModel Config = new ConfigurationModel();
        private HttpClient Client = new HttpClient();
        private string Token = "";
        public ProcessAPI()
        {
            ConfigurationList();
        }

        public void Entry()
        {
            PlatformWellDAL platformWellDAL = new PlatformWellDAL(Config);
            try
            {
                if (string.IsNullOrEmpty(Token)) GetToken().GetAwaiter().GetResult();
                platformWellDAL.DbExecuteNonResult(GetData().GetAwaiter().GetResult());
            }
            catch (Exception)
            {
                throw;
            }
        }

        private async Task<List<PlatformModel>> GetData()
        {

            try
            {
                Client.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", Token);
                var response = await Client.GetAsync(Config.APIURL.PlatformWell.ToString());

                if (response.StatusCode == System.Net.HttpStatusCode.Unauthorized)
                {
                    await GetToken();
                    await GetData();
                }

                List<PlatformModel> platformModel = new List<PlatformModel>();
                platformModel = JsonConvert.DeserializeObject<List<PlatformModel>>(await response.Content.ReadAsStringAsync());
                return platformModel;
            }
            catch (Exception ex)
            {

                throw ex;
            }

      
        }

        private async Task<string> GetToken()
        {
            try
            {
                var request = new HttpRequestMessage(HttpMethod.Post, new Uri(Config.APIURL.Login)); 
                var content = new StringContent(JsonConvert.SerializeObject(new { userName = Config.Username, password = Config.Password }), Encoding.UTF8);
                content.Headers.ContentType = new MediaTypeHeaderValue("application/json");
                request.Content = content;

                var response = await Client.SendAsync(request);
                if (response.IsSuccessStatusCode)
                {
                    Token = JsonConvert.DeserializeObject<string>(await response.Content.ReadAsStringAsync());
                }
                return Token;
            }
            catch (Exception)
            {
                throw;
            }

        }

        private void ConfigurationList()
        {
            try
            {
                using (System.IO.StreamReader r = new System.IO.StreamReader(
               System.IO.Path.Combine(new System.IO.FileInfo(
                   System.Reflection.Assembly.GetCallingAssembly().Location).DirectoryName,
                   "appsetting.json")))
                {
                    string json = r.ReadToEnd();
                    Config = JsonConvert.DeserializeObject<ConfigurationModel>(json);

                }
            }
            catch (Exception)
            {
                throw;
            }


        }
    }
}
