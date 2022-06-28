--COMMITMENTS--

select 
	distinct ref.js_reference as 'Transaction ID',
	c.js_contact_number,
	'Commitment' as 'Reference Type',
	ca.js_key + ' - ' + ca.js_short_name as 'Kampagnenaktivität',
	c.js_pay_lifetime_sum as 'Lifetime Sum',
	convert(date, c.js_start_date) as 'Startdate Contact',
	case
		when c.GenderCode = '1' then 'männlich'
		when c.GenderCode = '2' then 'weiblich'
		else 'unbekannt'
		end as 'Gender',
	DATEDIFF(year, year(getdate()), c.js_birthday_year) as 'Alter'
from
	dbo.js_con_reference ref
inner join
	dbo.js_com_commitment com
	on
	com.js_com_commitmentId = ref.js_commitment_id
inner join
	dbo.js_com_contribution contr
	on
	com.js_com_commitmentId = contr.js_com_commitment_id
inner join
	dbo.CampaignActivity ca
	on
	ca.ActivityId = com.js_campaignactivity_id
inner join
	dbo.Campaign camp
	on
	camp.CampaignId = ca.RegardingObjectId
inner join
	dbo.js_core_form_of_payment_so fop
	on
	fop.js_core_form_of_payment_soId = contr.js_core_form_of_payment_soid
inner join
	dbo.js_core_money_period_so mp
	on
	mp.js_core_money_period_soId = contr.js_core_money_period_so
inner join
	dbo.js_com_commitment_type_so cty
	on
	cty.js_com_commitment_type_soId = com.js_com_commitment_type_soid
inner join
	dbo.Contact c
	on
	c.ContactId = contr.js_contact_id
inner join
	dbo.js_con_referencetype_so reft
	on
	reft.js_con_referencetype_soId = ref.js_reference_typeId
where
	contr.js_has_follow_up_contribution = 0
	and
	com.statecode = 0
	and
	contr.statecode = 0
	and
	ref.statecode = 0
	and
	reft.js_referencetype like '%Google Analytics%'
and year(com.js_valid_from) = '2021'

union

select 
	distinct com.js_external_reference as 'Transaction ID',
	c.js_contact_number,
	'Commitment' as 'Reference Type',
	ca.js_key + ' - ' + ca.js_short_name as 'Kampagnenaktivität',
	c.js_pay_lifetime_sum as 'Lifetime Sum',
	convert(date, c.js_start_date) as 'Startdate Contact',
	case
		when c.GenderCode = '1' then 'männlich'
		when c.GenderCode = '2' then 'weiblich'
		else 'unbekannt'
		end as 'Gender',
	DATEDIFF(year, year(getdate()), c.js_birthday_year) as 'Alter'
from
	dbo.js_com_commitment com
inner join
	dbo.js_com_contribution contr
	on
	com.js_com_commitmentId = contr.js_com_commitment_id
inner join
	dbo.CampaignActivity ca
	on
	ca.ActivityId = com.js_campaignactivity_id
inner join
	dbo.Campaign camp
	on
	camp.CampaignId = ca.RegardingObjectId
inner join
	dbo.js_core_form_of_payment_so fop
	on
	fop.js_core_form_of_payment_soId = contr.js_core_form_of_payment_soid
inner join
	dbo.js_core_money_period_so mp
	on
	mp.js_core_money_period_soId = contr.js_core_money_period_so
inner join
	dbo.js_com_commitment_type_so cty
	on
	cty.js_com_commitment_type_soId = com.js_com_commitment_type_soid
inner join
	dbo.Contact c
	on
	c.ContactId = contr.js_contact_id
where
	contr.js_has_follow_up_contribution = 0
	and
	com.statecode = 0
	and
	contr.statecode = 0
	and
	year(com.js_valid_from) = '2021'
	and
	com.js_external_reference is not null
	and 
	com.js_external_reference like '%-%'





union


--CONTRIBUTIONS--

select 
	distinct ref.js_reference as 'Transaction ID',
	c.js_contact_number,
	'Contribution' as 'Reference Type',
	ca.js_key + ' - ' + ca.js_short_name as 'Kampagnenaktivität',
	c.js_pay_lifetime_sum as 'Lifetime Sum',
	convert(date, c.js_start_date) as 'Startdate Contact',
	case
		when c.GenderCode = '1' then 'männlich'
		when c.GenderCode = '2' then 'weiblich'
		else 'unbekannt'
		end as 'Gender',
	DATEDIFF(year, year(getdate()), c.js_birthday_year) as 'Alter'
from
	dbo.js_con_reference ref
inner join
	dbo.js_com_contribution contr
	on
	contr.js_com_contributionId = ref.js_contribution_id
inner join
	dbo.CampaignActivity ca
	on
	ca.ActivityId = contr.js_campaignactivity_id
inner join
	dbo.Campaign camp
	on
	camp.CampaignId = ca.RegardingObjectId
inner join
	dbo.js_core_form_of_payment_so fop
	on
	fop.js_core_form_of_payment_soId = contr.js_core_form_of_payment_soid
inner join
	dbo.js_core_money_period_so mp
	on
	mp.js_core_money_period_soId = contr.js_core_money_period_so
inner join
	dbo.js_com_commitment com
	on
	com.js_com_commitmentId = contr.js_com_commitment_id
inner join
	dbo.js_com_commitment_type_so cty
	on
	cty.js_com_commitment_type_soId = com.js_com_commitment_type_soid
inner join
	dbo.Contact c
	on
	c.ContactId = contr.js_contact_id
inner join
	dbo.js_con_referencetype_so reft
	on
	reft.js_con_referencetype_soId = ref.js_reference_typeId
where
	contr.statecode = 0
	and
	ref.statecode = 0
	and
	reft.js_referencetype like '%Google Analytics%' 
and year(contr.js_valid_from) = '2021'
	and
	contr.js_single_contribution_payment_status <> '717730000'

union

select 
	left(RIGHT (contr.js_external_reference, LEN(contr.js_external_reference) - CHARINDEX('Digify-',contr.js_external_reference)-6), 15) as 'Transaction ID',
	c.js_contact_number,
	'Contribution' as 'Reference Type',
	ca.js_key + ' - ' + ca.js_short_name as 'Kampagnenaktivität',
	c.js_pay_lifetime_sum as 'Lifetime Sum',
	convert(date, c.js_start_date) as 'Startdate Contact',
	case
		when c.GenderCode = '1' then 'männlich'
		when c.GenderCode = '2' then 'weiblich'
		else 'unbekannt'
		end as 'Gender',
	DATEDIFF(year, year(getdate()), c.js_birthday_year) as 'Alter'
from
	dbo.js_com_contribution contr
inner join
	dbo.CampaignActivity ca
	on
	ca.ActivityId = contr.js_campaignactivity_id
inner join
	dbo.Campaign camp
	on
	camp.CampaignId = ca.RegardingObjectId
inner join
	dbo.js_core_form_of_payment_so fop
	on
	fop.js_core_form_of_payment_soId = contr.js_core_form_of_payment_soid
inner join
	dbo.js_core_money_period_so mp
	on
	mp.js_core_money_period_soId = contr.js_core_money_period_so
inner join
	dbo.js_com_commitment com
	on
	com.js_com_commitmentId = contr.js_com_commitment_id
inner join
	dbo.js_com_commitment_type_so cty
	on
	cty.js_com_commitment_type_soId = com.js_com_commitment_type_soid
inner join
	dbo.Contact c
	on
	c.ContactId = contr.js_contact_id
where
	contr.statecode = 0 
and year(contr.js_valid_from) = '2021'
	and
	contr.js_single_contribution_payment_status <> '717730000'
	and
	contr.js_external_reference is not null
	and 
	contr.js_external_reference like '%-%'
	and 
	contr.js_external_reference like '%digify%'

union

select 
	distinct contr.js_external_reference as 'Transaction ID',
	c.js_contact_number,
	'Contribution' as 'Reference Type',
	ca.js_key + ' - ' + ca.js_short_name as 'Kampagnenaktivität',
	c.js_pay_lifetime_sum as 'Lifetime Sum',
	convert(date, c.js_start_date) as 'Startdate Contact',
	case
		when c.GenderCode = '1' then 'männlich'
		when c.GenderCode = '2' then 'weiblich'
		else 'unbekannt'
		end as 'Gender',
	DATEDIFF(year, year(getdate()), c.js_birthday_year) as 'Alter'
from
	dbo.js_com_contribution contr
inner join
	dbo.CampaignActivity ca
	on
	ca.ActivityId = contr.js_campaignactivity_id
inner join
	dbo.Campaign camp
	on
	camp.CampaignId = ca.RegardingObjectId
inner join
	dbo.js_core_form_of_payment_so fop
	on
	fop.js_core_form_of_payment_soId = contr.js_core_form_of_payment_soid
inner join
	dbo.js_core_money_period_so mp
	on
	mp.js_core_money_period_soId = contr.js_core_money_period_so
inner join
	dbo.js_com_commitment com
	on
	com.js_com_commitmentId = contr.js_com_commitment_id
inner join
	dbo.js_com_commitment_type_so cty
	on
	cty.js_com_commitment_type_soId = com.js_com_commitment_type_soid
inner join
	dbo.Contact c
	on
	c.ContactId = contr.js_contact_id
where
	contr.statecode = 0 
and year(contr.js_valid_from) = '2021'
	and
	contr.js_single_contribution_payment_status <> '717730000'
	and
	contr.js_external_reference is not null
	and 
	contr.js_external_reference like '%-%'
	and 
	contr.js_external_reference not like '%digify%'


union

--Activites--

select 
	distinct ref.js_reference as 'Transaction ID',
	c.js_contact_number,
	'Activity' as 'Reference Type',
	ca.js_key + ' - ' + ca.js_short_name as 'Kampagnenaktivität',
	c.js_pay_lifetime_sum as 'Lifetime Sum',
	convert(date, c.js_start_date) as 'Startdate Contact',
	case
		when c.GenderCode = '1' then 'männlich'
		when c.GenderCode = '2' then 'weiblich'
		else 'unbekannt'
		end as 'Gender',
	DATEDIFF(year, year(getdate()), c.js_birthday_year) as 'Alter'
from
	dbo.js_con_reference ref
inner join
	dbo.js_core_internet_activity act
	on
	act.ActivityId = ref.js_internet_activity_id
inner join
	js_core_activity_category_so cat
	on
	cat.js_core_activity_category_soId = act.js_core_activity_category_id
inner join
	dbo.js_core_activity_subcategory_so scat
	on
	scat.js_core_activity_subcategory_soId = act.js_core_activity_subcategory_id
left join
	dbo.CampaignActivity ca
	on
	ca.ActivityId = act.js_campaignactivity_id
left join
	dbo.Campaign camp
	on
	camp.CampaignId = ca.RegardingObjectId
inner join
	dbo.Contact c
	on
	c.ContactId = act.RegardingObjectId
inner join
	dbo.js_con_referencetype_so reft
	on
	reft.js_con_referencetype_soId = ref.js_reference_typeId
left join
	dbo.Invoice inv
	on
	inv.js_external_reference = ref.js_reference
left join
	dbo.js_com_contribution contr
	on
	contr.js_invoice_id = inv.InvoiceId
left join
	dbo.CampaignActivity ca2
	on
	ca2.ActivityId = inv.js_campaignactivity_id
where
	ref.statecode = 0
	and
	reft.js_referencetype like '%Google Analytics%' 
	and
	inv.StatusCode not in ('717730005', '717730006')
	and
	year(act.ActualStart) = '2021'




