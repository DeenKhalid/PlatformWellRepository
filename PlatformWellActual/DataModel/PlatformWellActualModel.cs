using System;
using System.Collections.Generic;
using System.Text;

namespace PlatformWellActual.DataModel
{
    public class PlatformModel
    {
        public int id { get; set; }
        public string uniqueName { get; set; }
        public decimal latitude { get; set; }
        public decimal longitude { get; set; }
        public DateTime? createdAt { get; set; }
        public DateTime? updatedAt { get; set; }
        public List<WellModel> well { get; set; }
    }

    public class WellModel
    {
        public int id { get; set; }
        public int platformId { get; set; }
        public string uniqueName { get; set; }
        public decimal latitude { get; set; }
        public decimal longitude { get; set; }
        public DateTime? createdAt { get; set; }
        public DateTime? updatedAt { get; set; }

    }
}
