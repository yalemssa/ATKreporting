use yale_dev;
select 
    concat(r.resourceIdentifier1,
            ' ',
            lpad(r.resourceIdentifier2, 4, '00')) 'Collection',
            /* creating padded call number */
    r.title 'Collection Title',
    series.subdivisionIdentifier 'Series/Accession Number',
    /* later, the components table joins on itself to make the series table */
    series.title 'Series Title',
    adi.container1Type 'Container Type',
    coalesce(adi.container1NumericIndicator,
            adi.container1AlphaNumIndicator) Box,
    adi.userDefinedString2 'Box Type',
    adi.archDescriptionInstancesId InstanceID,
    adi.barcode Barcode,
    adi.userDefinedString1 'Voyager Info',
    loc.building,
    loc.room,
    coalesce(loc.coordinate1NumericIndicator,
            loc.coordinate1AlphaNumIndicator) Shelf
            /* more-detailed information about locations may be stored in the table, but since it isn't used at Yale, it isn't included in this report. */
from
    ArchDescriptionInstances adi
        inner join
    ResourcesComponents rc ON adi.resourceComponentId = rc.resourceComponentId
        inner join
    LocationsTable loc ON adi.locationID = loc.locationID
        inner join
    Resources r ON r.resourceId = getResourceFromComponent(rc.resourceComponentId)
        left outer join
    ResourcesComponents series ON getTopComponent(rc.resourceComponentId) = series.resourceComponentID
    where adi.userDefinedString2='16_mm_reel'
