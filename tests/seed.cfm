<cfif !isSeedableEnvironment(stage = application.wheels.stage, dataSourceName = application.wheels.dataSourceName)>
	<cfthrow type="IllegalSeedEnvironment" message="This environment does not support database seeding" errorcode=418>
</cfif>

<cfdbinfo name="local.dbinfo" datasource="#application.wheels.dataSourceName#" type="tables">
<cfset local.tables = local.dbinfo.filter(function(i) {
	return i.table_type == "table";
})>

<cfloop query="local.dbinfo">
	<cfquery name="local.query" datasource="#application.wheels.dataSourceName#">
	SET FOREIGN_KEY_CHECKS = 0;
		TRUNCATE TABLE `#local.dbinfo.table_name#`;
		SET FOREIGN_KEY_CHECKS = 1;
	</cfquery>
</cfloop>

<cfquery name="local.schema" datasource="#application.wheels.dataSourceName#">
-- TODO: more suburbs
INSERT INTO suburbs (suburbName,postcode,state,latitude,longitude,createdAt) VALUES
('MELBOURNE','3000','VIC',-37.815,144.964,Now())
,('ADELAIDE','5000','SA',-37.815,144.964,Now())
;
INSERT INTO regions (state,regionName,createdAt) VALUES
('VIC','MyTestRegion','2019-06-05 11:24:50.000')
;
INSERT INTO regionsuburbs (regionId,suburbId) VALUES
(1,1)
,(1,2)
;
INSERT INTO seodescriptions (state,regionId,suburbId,saleMethod,propertyType,description,createdAt) VALUES
('VIC',NULL,NULL,NULL,NULL,'VIC Seo Description','2019-06-05 11:24:50.000')
,(NULL,NULL,1,'Buy',NULL,'My Seo Description','2019-06-05 11:24:50.000')
,(NULL,NULL,1,'Buy','House','My House Seo Description','2019-06-05 11:24:50.000')
,(NULL,NULL,1,'Buy','Apartment','My Apartment Seo Description','2019-06-05 11:24:50.000')
,(NULL,NULL,1,'Rent',NULL,'My Rent Seo Description','2019-06-05 11:24:50.000')
,(NULL,NULL,1,'Sold',NULL,'My Sold Seo Description','2019-06-05 11:24:50.000')
,(NULL,1,NULL,'Buy',NULL,'My Region Seo Description','2019-06-05 11:24:50.000')
;
-- TODO: lots of inserts
INSERT INTO administrators (firstname,lastname,email,mobile,passwordHash,passwordResetToken,rememberToken,isPasswordChangeRequired,passwordResetTokenAt,passwordResetAt,loggedInAt,multiFactorAuthKey,sessionData,createdAt,updatedAt,deletedAt,dutyid) VALUES
('Tom','Araya','tom@rev.com.au','0411 123 456','$2a$12$43WbOMcBi/GvmRYNs46kcOZ7e6XpgHfqhyjGJs8fvFOD2I5497hc6',NULL,'4d882dd4ad9b5492d319a4c7614fab5f',0,NULL,NULL,NULL,'multiFactorAuthKey',NULL,'2019-06-05 11:24:50.000','2019-06-05 11:24:50.000',NULL,1)
,('Kerry','King','kerry@rev.com.au','0411 234 567','$2a$12$43WbOMcBi/GvmRYNs46kcOZ7e6XpgHfqhyjGJs8fvFOD2I5497hc6',NULL,'15db0d20ee2e8f79bb217b91eb9603fd',0,NULL,NULL,NULL,'multiFactorAuthKey',NULL,'2019-06-05 11:24:50.000','2019-06-05 11:24:50.000',NULL,1)
,('Jeff','Hanneman','jeff@rev.com.au','0411 345 678','$2a$12$43WbOMcBi/GvmRYNs46kcOZ7e6XpgHfqhyjGJs8fvFOD2I5497hc6',NULL,'b613b43a62d54d8b14061fd834e977f1',0,NULL,NULL,NULL,'multiFactorAuthKey',NULL,'2019-06-05 11:24:50.000','2019-06-05 11:24:50.000',NULL,1)
,('Dave','Lombardo','dave@rev.com.au','0411 345 678','$2a$12$43WbOMcBi/GvmRYNs46kcOZ7e6XpgHfqhyjGJs8fvFOD2I5497hc6',NULL,'b613b43a62d54d8b14061fd834e977f1',0,NULL,NULL,NULL,'multiFactorAuthKey',NULL,'2019-06-05 11:24:50.000','2019-06-05 11:24:50.000',NULL,1)
,('James','Hetfield','james@rev.com.au','0411 123 456','$2a$12$43WbOMcBi/GvmRYNs46kcOZ7e6XpgHfqhyjGJs8fvFOD2I5497hc6',NULL,'4d882dd4ad9b5492d319a4c7614fab5f',0,NULL,NULL,NULL,'multiFactorAuthKey',NULL,'2019-06-05 11:24:50.000','2019-06-05 11:24:50.000',NULL,1)
,('Lars','Ulrich','lars@rev.com.au','0411 234 567','$2a$12$43WbOMcBi/GvmRYNs46kcOZ7e6XpgHfqhyjGJs8fvFOD2I5497hc6',NULL,'15db0d20ee2e8f79bb217b91eb9603fd',0,NULL,NULL,NULL,'multiFactorAuthKey',NULL,'2019-06-05 11:24:50.000','2019-06-05 11:24:50.000',NULL,1)
,('Kirk','Hammett','kirk@rev.com.au','0411 345 678','$2a$12$43WbOMcBi/GvmRYNs46kcOZ7e6XpgHfqhyjGJs8fvFOD2I5497hc6',NULL,'b613b43a62d54d8b14061fd834e977f1',0,NULL,NULL,NULL,'multiFactorAuthKey',NULL,'2019-06-05 11:24:50.000','2019-06-05 11:24:50.000',NULL,1)
,('Cliff','Burton','cliff@rev.com.au','0411 345 678','$2a$12$43WbOMcBi/GvmRYNs46kcOZ7e6XpgHfqhyjGJs8fvFOD2I5497hc6',NULL,'b613b43a62d54d8b14061fd834e977f1',0,NULL,NULL,NULL,'multiFactorAuthKey',NULL,'2019-06-05 11:24:50.000','2019-06-05 11:24:50.000',NULL,1)
,('Jason','Newstead','jason@rev.com.au','0411 345 678','$2a$12$43WbOMcBi/GvmRYNs46kcOZ7e6XpgHfqhyjGJs8fvFOD2I5497hc6',NULL,'b613b43a62d54d8b14061fd834e977f1',0,NULL,NULL,NULL,'multiFactorAuthKey',NULL,'2019-06-05 11:24:50.000','2019-06-05 11:24:50.000',NULL,1)
,('Rob','Trujillo','rob@rev.com.au','0411 345 678','$2a$12$43WbOMcBi/GvmRYNs46kcOZ7e6XpgHfqhyjGJs8fvFOD2I5497hc6',NULL,'b613b43a62d54d8b14061fd834e977f1',0,NULL,NULL,NULL,'multiFactorAuthKey',NULL,'2019-06-05 11:24:50.000','2019-06-05 11:24:50.000',NULL,1)
;
INSERT INTO offices (officeName,findAnAgentName,addressLine1,addressLine2,suburbId,longitude,latitude,phone,fax,salesEmail,abn,acn,profile,youtube,facebook,twitter,instagram,linkedin,configuration,website,defaultCategory,isHeadOffice,createdAt,updatedAt,deletedAt) VALUES
('Graceland Real Estate','Graceland Pty Ltd','5/101 Collins Street',NULL,1,NULL,NULL,'1300 666 662',NULL,'hello@graceland.com','666555444',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'http://www.graceland.com','residential',1,'2019-06-05 11:24:50.000','2019-06-05 11:24:50.000',NULL)
,('Superman Real Estate','Superman Pty Ltd','320 Swan Street',NULL,1,NULL,NULL,'1300 555 535',NULL,'hello@superman.com','666555333',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'http://www.superman.com','residential',0,'2019-06-05 11:24:50.000','2019-06-05 11:24:50.000',NULL)
,('Spiderman Real Estate','Spiderman Pty Ltd','50 Swan Street',NULL,1,NULL,NULL,'1300 555 345',NULL,'hello@spiderman.com','666555333',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'http://www.spiderman.com','residential',0,'2019-06-05 11:24:50.000','2019-06-05 11:24:50.000',NULL)
,('Aquaman Real Estate','Aquaman Pty Ltd','76 Swan Street',NULL,1,NULL,NULL,'1300 555 655',NULL,'hello@aquaman.com','666555333',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'http://www.aquaman.com','residential',0,'2019-06-05 11:24:50.000','2019-06-05 11:24:50.000',NULL)
,('Ironman Real Estate','Ironman Pty Ltd','12 Swan Street',NULL,1,NULL,NULL,'1300 555 322',NULL,'hello@ironman.com','666555333',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'http://www.ironman.com','residential',0,'2019-06-05 11:24:50.000','2019-06-05 11:24:50.000',NULL)
,('Antman Real Estate','Antman Pty Ltd','98 Swan Street',NULL,1,NULL,NULL,'1300 555 677',NULL,'hello@antman.com','666555333',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'http://www.antman.com','residential',0,'2019-06-05 11:24:50.000','2019-06-05 11:24:50.000',NULL)
,('Batman Real Estate','Batman Pty Ltd','62 Swan Street',NULL,1,NULL,NULL,'1300 555 436',NULL,'hello@batman.com','666555333',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'http://www.batman.com','residential',0,'2019-06-05 11:24:50.000','2019-06-05 11:24:50.000',NULL)
,('Talisman Real Estate','Talisman Pty Ltd','107 Swan Street',NULL,1,NULL,NULL,'1300 564 555',NULL,'hello@talisman.com','666555333',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'http://www.talisman.com','residential',0,'2019-06-05 11:24:50.000','2019-06-05 11:24:50.000',NULL)
,('Metal Real Estate','Metal Pty Ltd','21 Swan Street',NULL,1,NULL,NULL,'1300 555 435',NULL,'hello@metal.com','666555333',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'http://www.Metal.com','residential',0,'2019-06-05 11:24:50.000','2019-06-05 11:24:50.000',NULL)
;
-- specify the key
INSERT INTO offices (id, officeName,findAnAgentName,addressLine1,addressLine2,suburbId,longitude,latitude,phone,fax,salesEmail,abn,acn,profile,youtube,facebook,twitter,instagram,linkedin,configuration,website,defaultCategory,isHeadOffice,createdAt,updatedAt,deletedAt) VALUES
(666, 'Satan Real Estate','Satan Pty Ltd','5/101 Collins Street',NULL,1,NULL,NULL,'1300 666 662',NULL,'hello@satan.com','666555444',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'http://www.satan.com','residential',1,'2019-06-05 11:24:50.000','2019-06-05 11:24:50.000',NULL)
;
INSERT INTO officerelatedsuburbs (id, officeId, suburbId, type) VALUES
(1, 1, 1, 'findAnAgent')
,(2, 1, 2, 'findAnAgent')
;
INSERT INTO groups (groupName,isWeb,isOfficeShare,updatedAt,createdAt) VALUES
('Sun Group',1,1,'2019-06-05 11:24:50.000','2019-06-05 11:24:50.000')
,('Mercury Group',1,0,'2019-06-05 11:24:50.000','2019-06-05 11:24:50.000')
,('Venus Group',1,1,'2019-06-18 15:04:25.000','2019-06-18 15:04:25.000')
,('Earth Group',1,1,'2019-06-18 15:04:25.000','2019-06-18 15:04:25.000')
,('Mars Group',1,1,'2019-06-18 15:04:25.000','2019-06-18 15:04:25.000')
,('Jupiter Group',1,1,'2019-06-18 15:04:25.000','2019-06-18 15:04:25.000')
,('Saturn Group',1,1,'2019-06-18 15:04:25.000','2019-06-18 15:04:25.000')
,('Uranus Group',1,1,'2019-06-18 15:04:25.000','2019-06-18 15:04:25.000')
,('Neptune Group',1,1,'2019-06-18 15:04:25.000','2019-06-18 15:04:25.000')
,('Pluto Group',1,1,'2019-06-18 15:04:25.000','2019-06-18 15:04:25.000')
;
INSERT INTO agents (firstName,lastName,email,mobile,passwordHash,passwordResetToken,rememberToken,isPasswordChangeRequired,passwordResetTokenAt,passwordResetAt,loggedInAt,multiFactorAuthKey,sessionData,`position`,profile,facebook,twitter,linkedin,instagram,wechat,roleId,isMobileHidden,createdAt,updatedAt,deletedAt,isAgentLoginEnabled) VALUES
('Josiah','Doyle','garrison.260217@winnifred.us','0440 542 072','$2a$12$sXvAkslD0z0crOwTzRy5S.BflSn69he9wcLoO6dVKliUVFWmKvRhy',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,6,0,'2019-06-19 15:54:09.000','2019-06-19 15:54:09.000',NULL,1)
,('Dejon','Weber','hal-774640@wyman.co.uk','0437 085 308','$2a$12$KTR.30G9OeO8VTkqCDLRjOuCufvgWmeL2.cv./gFVi4lmRo6wl2d.',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,6,0,'2019-06-19 15:54:10.000','2019-06-19 15:54:10.000',NULL,1)
,('Juanita','Sauer','josefa_4184896@gmx.ca','0464 655 554','$2a$12$uRCg8O.4sZepBvHkZw7MhOGSFsd6WVVqqjzZZwImHf.QfcmhOsBve',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,6,0,'2019-06-19 15:54:11.000','2019-06-19 15:54:11.000',NULL,1)
,('Kurt','Krajcik','providenci-bayer9382@rodrigo.info','0491 160 210','$2a$12$YU7PI8xCXWmYiwzbNySMbuvZYVJ7jiUrWKUtTsyE6QF5opeZTVJyC',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,6,0,'2019-06-19 15:54:12.000','2019-06-19 15:54:12.000',NULL,1)
,('Candice','Wuckert','johan-7426488@sonia.ca','0406 471 793','$2a$12$unJTtyPhiO/tqmB/i6/0D.TdKSmrSMz6O3Va7B.oBXrMRpn34FrnC',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,6,0,'2019-06-19 15:54:12.000','2019-06-19 15:54:12.000',NULL,1)
,('Roman','Dicki','craig.125099@hotmail.name','0456 989 706','$2a$12$A.9sNIKotD6G/vTNAyDr9ev9x2zDTYlHTI5LRxw07ItJSVGgssACK',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,6,0,'2019-06-19 15:54:13.000','2019-06-19 15:54:13.000',NULL,1)
,('Diamond','Schuster','anastacio-6194349@ismael.uk','0468 494 327','$2a$12$Y6WM003Klcu0adhntc2R9eaBBceu5ydOy18LsEDwHAYdRPB3koalq',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,6,0,'2019-06-19 15:54:14.000','2019-06-19 15:54:14.000',NULL,1)
,('Freddie','Greenholt','tyson64942268@libbie.ca','0437 330 778','$2a$12$r.Cn.L22.ciGbec9QRWKdOXQDYqZ0CBshceze5gG3eTeCy/1137Nu',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,6,0,'2019-06-19 15:54:15.000','2019-06-19 15:54:15.000',NULL,1)
,('Gino','Smitham','kaylah-34744151@yesenia.us','0470 015 861','$2a$12$9qUp9F8pS14OkjE8WEH0neUpi6C/8YCxGIskJPu2MscyriXsuy/jq',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,6,0,'2019-06-19 15:54:16.000','2019-06-19 15:54:16.000',NULL,1)
,('Dannie','Goldner','toy_hahn5667@zoho.info','0497 293 394','$2a$12$HXuIBf6RHT4QzvMZVXyg7eioAxHa2fW0nqo7H.Q8XQKcOUXrdsz7K',NULL,NULL,0,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,6,0,'2019-06-19 15:54:17.000','2019-06-19 15:54:17.000',NULL,1)
;
-- -- set all passwords to 'password123'
UPDATE  agents
SET     passwordHash = '$2a$12$43WbOMcBi/GvmRYNs46kcOZ7e6XpgHfqhyjGJs8fvFOD2I5497hc6',
        rememberToken = MD5( CONCAT(id, '-administrators'))
;
-- put these agents in office 1 and 2
INSERT INTO agentoffices
	(officeid,agentid,isPrimaryOffice,createdAt)
SELECT 1, id, 1, Now()
FROM agents WHERE id != 2;
INSERT INTO agentoffices
	(officeid,agentid,isPrimaryOffice,createdAt)
SELECT 2, id, 0, Now()
FROM agents WHERE id != 2;
INSERT INTO agentoffices
	(officeid,agentid,isPrimaryOffice,createdAt)
VALUES
	(2,2,1,Now());
INSERT INTO listings (id,officeId,unitNumber,streetNumber,streetName,suburbId,fullAddress,status,category,saleMethod,heading,description,bedrooms,bathrooms,totalRooms,toilets,garages,carports,totalCarSpaces,priceText,priceFrom,listedAt,createdAt,rank,isRural,isHolidayRental) VALUES
(1,1,NULL,'1','Bourke Street',1,'1 Bourke Street, Melbourne, VIC 3000','On Market','Residential','sale','My listing heading','My listing description',3,2,5,2,2,NULL,2,'$1,500,000',1500000,'2019-03-01 11:24:50.247','2019-06-05 11:24:50.247','feature',0,0)
,(2,1,NULL,'2','Swan Street',1,'2 Swan Street, Melbourne, VIC 3000','On Market','Residential','sale','My listing heading','My listing description',3,2,5,2,2,NULL,2,'$1,500,000',1500000,'2019-03-01 11:24:50.247','2019-06-05 11:24:50.247','standard',0,0)
,(3,2,NULL,'3','Jones Street',1,'3 Jones Street, Melbourne, VIC 3000','On Market','Residential','sale','My listing heading','My listing description',3,2,5,2,2,NULL,2,'$1,500,000',1500000,'2019-03-01 11:24:50.247','2019-06-05 11:24:50.247','standard',1,0)
,(4,2,NULL,'4','Church Street',1,'4 Church Street, Melbourne, VIC 3000','On Market','Residential','lease','My listing heading','My listing description',3,2,5,2,2,NULL,2,'$1,500,000',1500000,'2019-03-01 11:24:50.247','2019-06-05 11:24:50.247','standard',0,1)
,(5,2,NULL,'5','Business Street',1,'5 Business Street, Melbourne, VIC 3000','On Market','Business','sale','My listing heading','My listing description',3,2,5,2,2,NULL,2,'$1,500,000',1500000,'2019-03-01 11:24:50.247','2019-06-05 11:24:50.247','standard',0,0)
,(500,1,NULL,'1','Five Hundred Street',1,'1 Five Hundred Street, Melbourne, VIC 3000','On Market','Residential','sale','My listing heading','My listing description',3,2,5,2,2,NULL,2,'$1,500,000',1500000,'2019-03-01 11:24:50.247','2019-06-05 11:24:50.247','standard',0,0)
;
INSERT INTO listingagents (id,listingId,agentId,createdAt) VALUES
(1,1,1,'2019-03-01 11:24:50.247')
,(2,1,2,'2019-03-01 11:24:50.247')
,(3,2,1,'2019-03-01 11:24:50.247')
;
INSERT INTO listingranks (id,listingId,rank,isCurrent,createdAt,expiredAt) VALUES
(1,1,'feature',1,'2019-03-01 11:24:50.247',Now())
;
INSERT INTO propertytypes (listingCategory,name) VALUES
('Residential','House')
,('Residential','Unit')
,('Residential','Apartment')
,('Residential','Studio')
,('Residential','Townhouse')
,('Residential','Vacant Land')
,('Residential','Development Site')
,('Residential','Investment')
,('Residential','Terrace')
,('Residential','Villa')
,('Residential','Semi')
,('Residential','Duplex')
,('Residential','Penthouse')
,('Residential','Holiday')
,('Residential','Bed & Breakfast')
,('Residential','Retirement Accomodation')
,('Residential','Alpine')
,('Residential','Warehouse Conversion')
,('Residential','Car Space')
,('Residential','Block of Flats')
,('Residential','Boat House')
,('Residential','Other')
,('Business','Accommodation/Tourism')
,('Business','Automotive')
,('Business','Beauty/Health')
,('Business','Education/Training')
,('Business','Food/Hospitality')
,('Business','Franchise')
,('Business','Home/Garden')
,('Business','Import/Export/Whole')
,('Business','Industrial/Manufacturing')
,('Business','Leisure/Entertainment')
,('Business','Professional')
,('Business','Retail')
,('Business','Rural')
,('Business','Services')
,('Business','Transport/Distribution')
,('Business','General')
,('Rural', 'Livestock')
,('Rural', 'Cropping/Grazing')
,('Rural', 'Dairy')
;

INSERT INTO subpropertytypes (id,propertytypeid,name) VALUES
(1,1,'Aged Care')
,(2,1,'Backpacker')
,(3,1,'Boarding')
;
INSERT INTO listingpropertytypes (listingId,propertyTypeId) VALUES
(1,1)
,(2,2)
,(3,40)
,(4,14)
,(5,1)
;
INSERT INTO features (id, featureCategoryId, featureName) VALUES
(1,1,'Alarm System')
,(2,1,'Broadband')
,(3,1,'Built in Robes')
,(4,1,'Dishwasher')
,(5,1,'Ensuite')
,(6,1,'Fire Place')
,(7,1,'Floorboards')
,(8,1,'Gym')
,(9,1,'Heating Other')
,(10,1,'Hot Water Gas')
;
INSERT INTO portals (id, portalName, portalSlug, portalStatus, createdAt) VALUES
(3,'realestate.com.au','rea','live',Now())
;
INSERT INTO opens (id,listingId,openStart,openEnd,createdAt) VALUES
(1,1,'2019-06-01 01:00:00','2019-06-01 01:30:00','2019-06-01 01:00:00')
,(2,1,'2019-06-08 01:00:00','2019-06-09 01:30:00','2019-06-01 01:00:00')
,(3,1,'2019-06-15 01:00:00','2019-06-15 01:30:00','2019-06-01 01:00:00')
,(4,1,'2019-06-22 01:00:00','2019-06-22 01:30:00','2019-06-01 01:00:00')
,(5,1,'2019-06-29 01:00:00','2019-06-29 01:30:00','2019-06-01 01:00:00')
;
INSERT INTO migratorversions (version) VALUES
('0')
;
INSERT INTO products (id,productName,producttype,category,isAttachListings,isFileUpload,numberOfSlots,numberOfListings,createdAt) VALUES
(1,'List Plus','listing','Residential',0,0,NULL,NULL,'2019-06-05 11:24:50.000')
,(2,'Plus All','listing','Residential',0,0,NULL,NULL,'2019-06-05 11:24:50.000')
,(3,'Subscription','listing','Business',0,0,NULL,NULL,'2019-06-05 11:24:50.000')
,(4,'Feature','listing','Business',0,0,NULL,NULL,'2019-06-05 11:24:50.000')
,(5,'Local Experts','upsell','Residential',1,0,4,4,'2019-06-05 11:24:50.000')
,(6,'Top Spot','upsell','Business',1,0,4,4,'2019-06-05 11:24:50.000')
,(7,'Agent Banners','upsell','Residential',0,1,4,4,'2019-06-05 11:24:50.000')
,(8,'BView Banners','upsell','Business',0,1,4,4,'2019-06-05 11:24:50.000')
;
INSERT INTO productitems (id,productId,listingType,contractType,listingRate,featureCredits,featureDuration,listingBehaviour,createdAt) VALUES
(1,1,'Sale','Per-Listing',0,NULL,NULL,'Standard','2019-06-05 11:24:50.000')
,(2,1,'Lease','Per-Listing',0,NULL,NULL,'Standard','2019-06-05 11:24:50.000')
,(3,1,'Sale','Per-Listing',250,NULL,60,'Feature','2019-06-05 11:24:50.000')
,(4,1,'Lease','Per-Listing',100,NULL,60,'Feature','2019-06-05 11:24:50.000')
,(5,2,'Sale','Per-Listing',100,NULL,60,'Feature','2019-06-05 11:24:50.000')
,(6,4,'Lease','Per-Listing',50,NULL,60,'Feature','2019-06-05 11:24:50.000')
,(7,3,'Sale','All Listings',100,NULL,NULL,'Standard','2019-06-05 11:24:50.000')
;
INSERT INTO officeproducts (id,officeId,productId,productName,category,createdAt) VALUES
(1,2,1,'Off Res Product','Residential','2019-06-05 11:24:50.000')
,(2,2,4,'Off Bus Product','Business','2019-06-05 11:24:50.000')
;
INSERT INTO officeproductitems (id,officeProductId,productItemId,listingType,contractType,listingRate,featureCredits,featureDuration,listingBehaviour,salesForceId,createdAt) VALUES
(1,1,5,'Sale','Per-Listing',100,NULL,60,'Feature','Abc123','2019-06-05 11:24:50.000')
,(2,1,6,'Lease','Per-Listing',50,NULL,60,'Feature','Abc124','2019-06-05 11:24:50.000')
,(3,2,NULL,'Sale','Per-Listing',200,NULL,60,'Feature','Bus123','2019-06-05 11:24:50.000')
,(4,1,NULL,'Sale','Per-Listing',50,NULL,NULL,'Standard','Abc123','2019-06-05 11:24:50.000')
,(5,1,NULL,'Lease','Per-Listing',10,NULL,NULL,'Standard','Abc124','2019-06-05 11:24:50.000')
,(6,2,NULL,'Sale','All Listings',100,NULL,NULL,'Standard','BUS223','2019-06-05 11:24:50.000')
,(7,1,NULL,'Sale','All Listings',100,NULL,NULL,'Standard','All113','2019-06-05 11:24:50.000')
,(8,1,NULL,'Lease','All Listings',50,NULL,NULL,'Standard','All113','2019-06-05 11:24:50.000')
,(9,1,NULL,'Sale','Per-Listing',100,NULL,NULL,'Re-feature','All113','2019-06-05 11:24:50.000')
,(10,1,NULL,'Lease','Per-Listing',50,NULL,NULL,'Re-feature','All113','2019-06-05 11:24:50.000')
;
INSERT INTO reports (id,isAdmin,reportName,reportSlug,reportType,createdAt) VALUES
(1,1,'Stocklist','listing-stocklist','Listings','2019-07-09 15:00:00')
;
INSERT INTO importproviders (id,providerName,providerCode,providerEmail,providerStatus,createdAt) VALUES
(1,'Zenu','ZEN','sales@zenu.com.au','Live','2019-10-09 13:00:00')
,(2,'Portplus','PP','sales@portplus.com.au','Live','2019-10-09 13:00:00')
;
INSERT INTO importoffices (id,importProviderId,officeId,providerOfficeCode,importOfficeStatus,createdAt) VALUES
(1,1,1,'provider_code','Live','2019-10-09 13:00:00')
;
INSERT INTO contacts (id,firstName,lastName,email,mobile,createdAt,passwordHash) VALUES
(1,'Night','King','night.king@whitewalkers.com','0444666666','2019-10-09 13:00:00','$2a$12$sXvAkslD0z0crOwTzRy5S.BflSn69he9wcLoO6dVKliUVFWmKvRhy')
;
INSERT INTO criteria (id,contactId,saleMethod,listingCategory,state,priceFrom,priceTo,bedrooms,bathrooms,carSpaces,sendFrequency,createdAt) VALUES
(1,1,'Sale','Residential','VIC',800000,1500000,4,2,2,'Weekly','2019-11-19 14:00:00')
</cfquery>
