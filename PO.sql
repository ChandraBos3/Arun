
 drop table #billlist

select distinct hpo_po_number, hpo_job_code ,d.sector_code,d.Sector_Description, c.sbg_code,location, job_nature
into #billlist
from eip.SQLSCM.SCM_H_Purchase_Orders,lnt.dbo.job_master C,lnt.dbo.sector_master d

where hpo_Job_Code= job_code
and Hpo_po_Date>='01-Jan-2016' and hpo_po_date <='31-Mar-2018' 
and c.Sector_Code = d.Sector_Code and c.company_code='LE' and c.company_code = d.Company_Code


alter table #billlist add BUdesc varchar(100)
alter table #billlist add sbgdesc varchar (200)

alter table #billlist add Locdesc varchar(100)
alter table #billlist add city varchar (200)
alter table #billlist add state1 varchar (200)
alter table #billlist add jobnature varchar (100)

uPDATE a SET  BUdesc= d.bu_description
FROM #billlist a, lnt.dbo.business_unit_master d, LNT.DBO.JOB_MASTER c
WHERE hpo_Job_Code= c.job_code
AND c.BU_CODE = d.bu_code



UPDATE a SET sbgdesc = b.SBG_Description
from #billlist a, lnt.dbo.sbg_master b
WHERE a.sbg_code = b.sbg_code 




UPDATE a SET Locdesc  = b.region_description
from #billlist a, lnt.dbo.region_master b
WHERE a.location = b.region_code
and b. Company_Code='LE'

update a set city =UCITY_Name, state1=USTAT_Name
 from #billlist a, eip.SQLMAS.GEN_M_Address_Book, Eip.Sqlmas.Gen_M_Jobs,eip.sqlmas.GEN_U_States, Eip.Sqlmas.GEN_U_Cities
 where Mjob_AB_Code=MAB_AB_Code 
 and MAB_City_Code=UCITY_City_Code
 and UCITY_State_Code =USTAT_State_Code
 and Hpo_Job_Code =mjob_job_code

 update a set jobnature =b.type

 from #billlist a, lnt.dbo.job_nature_master b

 where a.job_nature = b.code

 select *from  #billlist
