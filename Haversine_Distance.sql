With froms as 
(
select
  co_loc_ref_i as from_co_loc_ref_i,
  cast(lattd_i/57.29577951 as decimal(9,6)) as from_lattd_i,
  cast(lngtd_i/57.29577951 as decimal(9,6)) as from_lngtd_i
  
from
  table#1
where
  lattd_i is not null
),

tos as 
(
select
  co_loc_ref_i as to_co_loc_ref_i,
  cast(lattd_i/57.29577951 as decimal(9,6)) as to_lattd_i,
  cast(lngtd_i/57.29577951 as decimal(9,6)) as to_lngtd_i
from
  table#1
where
  lattd_i is not null
)


select
  from_co_loc_ref_i,
  to_co_loc_ref_i,
  from_lattd_i,
  from_lngtd_i,
  to_lattd_i,
  to_lngtd_i,
  ABS(ACOS(SIN(from_lattd_i)*SIN(to_lattd_i)+COS(from_lattd_i)*COS(to_lattd_i)*COS(to_lngtd_i-from_lngtd_i))) * 3961 as haversine_distance
from
  froms
cross join
  tos
where
  from_co_loc_ref_i <> to_co_loc_ref_i
