DECLARE @columns NVARCHAR(MAX), @pivot_datatype_double NVARCHAR(MAX),@pivot_datatype_string NVARCHAR(MAX),@pivot_datatype_integer NVARCHAR(MAX),@createtable NVARCHAR(MAX);
SET @columns = N'';
SELECT @columns += N', p.' + QUOTENAME(Segment)
  FROM (SELECT distinct Segment FROM segmentations WHERE Segment in 
  (
	'Student'
	,'employee'
	,'postcode'
	,'hardbounce'
	,'loi_1a'
	,'loi_2a'
	,'loi_3a'
	,'loi_4a'
	,'loi_b'
	,'loi_g'
	,'loi_m'
	,'loi_w'
	,'losm_1a'
	,'losm_2a'
	,'losm_3a'
	,'losm_4a'
	,'losm_5a'
	,'losm_b'
	,'losm_if'
	,'losm_mc'
	,'losm_rc'
	,'losm_yf'
	,'optin_optionbem'
	,'optin_optionnew'
	,'optin_optionpof'
	,'optin_optionpre'
	,'optin_optionsrm'
	,'optin_optionwfn'
	,'optin_optionwim'
	--,'optin_comm'
	--,'optin_serv'
	)  ) AS p;

 
SET @createtable = N'
CREATE TABLE #pivot_segmentations(
customerid int not null,
employee varchar(255) null,
student varchar(255) null,
hardbounce varchar(255) null,
postcode varchar(255) null,
loi_1a varchar(255) null,
loi_2a varchar(255) null,
loi_3a varchar(255) null,
loi_4a varchar(255) null,
loi_b varchar(255) null,
loi_g varchar(255) null,
loi_m varchar(255) null,
loi_w varchar(255) null,
losm_1a varchar(255) null,
losm_2a varchar(255) null,
losm_3a varchar(255) null,
losm_4a varchar(255) null,
losm_5a varchar(255) null,
losm_b varchar(255) null,
losm_if varchar(255) null,
losm_mc varchar(255) null,
losm_rc varchar(255) null,
losm_yf varchar(255) null,
optin_optionbem varchar(255) null,
optin_optionnew varchar(255) null,
optin_optionpof varchar(255) null,
optin_optionpre varchar(255) null,
optin_optionsrm varchar(255) null,
optin_optionwfn varchar(255) null,
optin_optionwim varchar(255) null
)'

SET @pivot_datatype_double = N'
INSERT INTO #pivot_segmentations
SELECT customerid,' + STUFF(@columns, 1, 2, '') + '
--into #double
FROM
(
SELECT c.CustomerId, s.Segment,doublevalue
FROM dbo.customers AS c
INNER JOIN dbo.segmentations AS s
ON c.CustomerId = s.CustomerId
--where c.customerid = 2
where IntValue is not null or datevalue is not null or DoubleValue is not null or StringValue is not null
) AS j
PIVOT
(
  max(doublevalue) FOR segment IN ('
  + STUFF(REPLACE(@columns, ', p.[', ',['), 1, 1, '')
  + ')
) AS p'

SET @pivot_datatype_string = N'
INSERT INTO #pivot_segmentations
SELECT customerid,' + STUFF(@columns, 1, 2, '') + '
--into #string
FROM
(
SELECT c.CustomerId, s.Segment,stringvalue
FROM dbo.customers AS c
INNER JOIN dbo.segmentations AS s
ON c.CustomerId = s.CustomerId
--where c.customerid = 2
where IntValue is not null or datevalue is not null or DoubleValue is not null or StringValue is not null
) AS j
PIVOT
(
  max(stringvalue) FOR segment IN ('
  + STUFF(REPLACE(@columns, ', p.[', ',['), 1, 1, '')
  + ')
) AS p'

SET @pivot_datatype_integer = N'
INSERT INTO #pivot_segmentations
SELECT customerid,' + STUFF(@columns, 1, 2, '') + '
--into #integer
FROM
(
SELECT c.CustomerId, s.Segment,intvalue
FROM dbo.customers AS c
INNER JOIN dbo.segmentations AS s
ON c.CustomerId = s.CustomerId
--where c.customerid = 2
where IntValue is not null or datevalue is not null or DoubleValue is not null or StringValue is not null
) AS j
PIVOT
(
  max(intvalue) FOR segment IN ('
  + STUFF(REPLACE(@columns, ', p.[', ',['), 1, 1, '')
  + ')
) AS p;'


--EXEC sp_executesql @createtable;
--EXEC sp_executesql @pivot_datatype_integer;
--EXEC sp_executesql @pivot_datatype_string;
--EXEC sp_executesql @pivot_datatype_double;

PRINT @createtable;
PRINT @pivot_datatype_integer;
PRINT @pivot_datatype_string;
PRINT @pivot_datatype_double;

PRINT 'SELECT * FROM #pivot_segmentations'

--PRINT @sql1;
--EXEC sp_executesql @sql;