CREATE TABLE #pivot_segmentations_integer(
customerid int not null,
employee varchar(255) null
--student varchar(255) null,
--hardbounce varchar(255) null,
--postcode varchar(255) null
)

CREATE TABLE #pivot_segmentations_String(
customerid int not null,
--employee varchar(255) null,
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
)

CREATE TABLE #pivot_segmentations_double(
customerid int not null,
loi_b varchar(255) null,
loi_g varchar(255) null,
loi_m varchar(255) null,
loi_w varchar(255) null,
losm_b varchar(255) null,
losm_if varchar(255) null,
losm_mc varchar(255) null,
losm_rc varchar(255) null,
losm_yf varchar(255) null
)

INSERT INTO #pivot_segmentations_integer
SELECT customerid, p.[Employee]
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
  max(intvalue) FOR segment IN ([Employee])
) AS p;

INSERT INTO #pivot_segmentations_string
SELECT 
customerid
--,p.[OPTIN_OPTIONWFN], p.[LOSM_RC], p.[LOI_B], p.[OPTIN_OPTIONNEW], p.[LOSM_YF], p.[LOSM_2A], p.[LOSM_5A], p.[LOI_2A], p.[LOI_3A], p.[OPTIN_OPTIONPRE], p.[LOSM_1A], p.[LOI_4A], p.[LOI_1A], p.[Student], p.[HARDBOUNCE], p.[OPTIN_OPTIONPOF], p.[LOI_G], p.[LOSM_3A], p.[Postcode], p.[LOSM_B], p.[LOI_W], p.[LOSM_4A], p.[OPTIN_OPTIONBEM], p.[OPTIN_OPTIONWIM], p.[LOSM_IF], p.[LOI_M], p.[LOSM_MC], p.[OPTIN_OPTIONSRM]
,p.student 
,hardbounce 
,postcode 
,loi_1a 
,loi_2a 
,loi_3a 
,loi_4a 
,loi_b 
,loi_g 
,loi_m 
,loi_w 
,losm_1a 
,losm_2a 
,losm_3a 
,losm_4a 
,losm_5a 
,losm_b 
,losm_if 
,losm_mc 
,losm_rc 
,losm_yf 
,optin_optionbem
,optin_optionnew
,optin_optionpof
,optin_optionpre
,optin_optionsrm
,optin_optionwfn
,optin_optionwim
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
  max(stringvalue) FOR segment IN (
  --[OPTIN_OPTIONWFN],[LOSM_RC],[LOI_B],[OPTIN_OPTIONNEW],[LOSM_YF],[Employee],[LOSM_2A],[LOSM_5A],[LOI_2A],[LOI_3A],[OPTIN_OPTIONPRE],[LOSM_1A],[LOI_4A],[LOI_1A],[Student],[HARDBOUNCE],[OPTIN_OPTIONPOF],[LOI_G],[LOSM_3A],[Postcode],[LOSM_B],[LOI_W],[LOSM_4A],[OPTIN_OPTIONBEM],[OPTIN_OPTIONWIM],[LOSM_IF],[LOI_M],[LOSM_MC],[OPTIN_OPTIONSRM]
	 student 
	,hardbounce 
	,postcode 
	,loi_1a 
	,loi_2a 
	,loi_3a 
	,loi_4a 
	,loi_b 
	,loi_g 
	,loi_m 
	,loi_w 
	,losm_1a 
	,losm_2a 
	,losm_3a 
	,losm_4a 
	,losm_5a 
	,losm_b 
	,losm_if 
	,losm_mc 
	,losm_rc 
	,losm_yf 
	,optin_optionbem
	,optin_optionnew
	,optin_optionpof
	,optin_optionpre
	,optin_optionsrm
	,optin_optionwfn
	,optin_optionwim
  )
) AS p



INSERT INTO #pivot_segmentations_double
SELECT 
customerid,--, p.[LOSM_RC], p.[LOI_B], p.[LOSM_YF], p.[LOI_G], p.[LOSM_B], p.[LOI_W], p.[LOSM_IF], p.[LOI_M], p.[LOSM_MC]
loi_b,
loi_g,
loi_m,
loi_w,
losm_b,
losm_if,
losm_mc,
losm_rc,
losm_yf
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
  max(doublevalue) FOR segment IN (
  --[LOSM_RC],[LOI_B],[LOSM_YF],[LOI_G],[LOSM_B],[LOI_W],[LOSM_IF],[LOI_M],[LOSM_MC])
	loi_b,
	loi_g,
	loi_m,
	loi_w,
	losm_b,
	losm_if,
	losm_mc,
	losm_rc,
	losm_yf
)
) AS p

--SELECT * FROM #pivot_segmentations_integer where employee is not null
--SELECT top 100 * FROM #pivot_segmentations_double order by 1
SELECT a.*,b.*,c.* 
FROM #pivot_segmentations_String a inner join #pivot_segmentations_integer b on a.customerid = b.customerid inner join #pivot_segmentations_double c on b.customerid = c.customerid
where a.customerid = 2

select * from segmentations where customerid in (2,3,4,5)