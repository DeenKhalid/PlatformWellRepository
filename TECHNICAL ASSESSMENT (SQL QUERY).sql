SELECT 
    p.UniqueName As PlatformName, 
	w.Id As Id, 
	w.PlatformId As PlatformId, 
	w.UniqueName As UniqueName,
	w.Latitude As Latitude,
	w.Longitude As Longitude,
	w.CreatedAt As CreatedAt,
	w.UpdatedAt As UpdatedAt
FROM [Platform] p 
CROSS APPLY (
	 select top 1 Id, PlatformId, UniqueName, Latitude,Longitude,CreatedAt,UpdatedAt 
     from  [WELL]  
     where PlatformId = p.Id
     order by UpdatedAt desc
) w


