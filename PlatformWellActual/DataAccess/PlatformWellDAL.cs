using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using Dapper;
using PlatformWellActual.DataModel;

namespace PlatformWellActual.DataAccess
{
    public class PlatformWellDAL
    {
        private ConfigurationModel _config { get; set; }
        public PlatformWellDAL(ConfigurationModel configuration)
        {
            _config = configuration;
        }
        public void DbExecuteNonResult(List<PlatformModel> models)
        {
            try
            {
                using (var conn = new SqlConnection(_config.ConnectionString.PlatformWellConnectionString))
                {
                    conn.Open();
                    using (var tran = conn.BeginTransaction())
                    {
                        try
                        {
                            //save or update platfrom data
                            models.ForEach(x => conn.Execute(sql: "sp_platform", 
                                new { id = x.id,
                                    uniqueName = x.uniqueName,
                                    latitude = x.latitude,
                                    longitude = x.longitude,
                                    createdAt = x.createdAt,
                                    updatedAt = x.updatedAt
                                }, 
                                commandType: CommandType.StoredProcedure,transaction: tran));


                            //save or update well data
                            models.ForEach(x => x.well.ForEach(w => conn.Execute(sql: "sp_well",
                                new
                                {
                                    id = w.id,
                                    platformId = w.platformId,
                                    uniqueName = w.uniqueName,
                                    latitude = w.latitude,
                                    longitude = w.longitude,
                                    createdAt = w.createdAt,
                                    updatedAt = w.updatedAt
                                },
                                commandType: CommandType.StoredProcedure, transaction: tran)));

                            tran.Commit();
                        }
                        catch (Exception)
                        {
                            tran.Rollback();
                            throw;
                        }

                    }
                }
            }
            catch (Exception ex)
            {
                throw;
            }

        }
    }
}
