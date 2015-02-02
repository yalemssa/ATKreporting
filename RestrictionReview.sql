select 
    r.resourceIdentifier1,
    r.resourceIdentifier2,
    r.title,
    series.subdivisionIdentifier 'Series/Accession Number',
    series.title 'Series Title',
    rc.title,
    rc.dateExpression,
    adrd.noteContent,
    rc.resourceComponentId
from
    ArchDescriptionRepeatingData adrd
        join
    ResourcesComponents rc ON adrd.resourceComponentId = rc.resourceComponentId
        join
    ResourcesComponents series ON getTopComponent(rc.resourceComponentId) = series.resourceComponentID
        join
    Resources r ON getResourceFromComponent(rc.resourceComponentId) = r.resourceId
where
    adrd.notesEtcTypeId = 8
        and r.resourceIdentifier1 = 'RU'
order by r.resourceIdentifier2 asc
