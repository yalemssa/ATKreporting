/* This is a series of updates to allow for round-tripping EAD files without losing barcodes.

/* This update assumes that barcodes were stored in EAD as container/@label
UPDATE ArchDescriptionInstances  SET barcode = instanceType WHERE instanceType REGEXP '^[0-9]{14}$';
/* This moves the barcode (which was stored in instanceType) to barcode if it looks like a barcode
UPDATE ArchDescriptionInstances  SET instanceType = 'Mixed materials' WHERE instanceType REGEXP '^[0-9]{14}$';
/* This sets instanceType to "Mixed materials" if it looks like a barcode

/* this update assumes that incomplete instance information exists in parallel to complete instance information (associated with another resource record).
/* this update filters by the bib/holdings information stored in userDefinedString1, which must be determined before this update can be run.
start transaction;
UPDATE yale.ArchDescriptionInstances AS ArchDesc
        JOIN
    (SELECT 
        barcode,
            userDefinedString1,
            userDefinedString2,
            locationId,
            userDefinedBoolean1,
            userDefinedBoolean2
    FROM
        yale.ArchDescriptionInstances
    WHERE
       userDefinedString1 = '{{bibid}}') AS newdata ON newdata.barcode = ArchDesc.barcode 
SET 
    ArchDesc.userDefinedString1 = newdata.UserDefinedString1,
    ArchDesc.userDefinedString2 = newdata.UserDefinedString2,
    ArchDesc.locationId = newdata.locationId,
    ArchDesc.userDefinedBoolean1 = newdata.userDefinedBoolean1,
    ArchDesc.userDefinedBoolean2 = newdata.userDefinedBoolean2
WHERE
    ArchDesc.userDefinedString1 = ''
        AND ArchDesc.userDefinedString2 = '';  
commit;
/* this update takes forever to run on collections with a lot of instances -- be sure to set the timeout in MySQL generously.
