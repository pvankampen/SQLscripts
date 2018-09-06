select count(*)
from segmentations
where IntValue is not null or datevalue is not null or DoubleValue is not null or StringValue is not null
union all
select count(*)
from segmentations
where IntValue is null and datevalue is null and DoubleValue is null and StringValue is null

select count(*) 
from segmentations