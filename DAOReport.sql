/* Everything one might want to know about digital objects in AT
SELECT
	CONCAT(
		r.resourceIdentifier1
		, ' '
		, LPAD(r.resourceIdentifier2, 4, '00')
	) AS Collection
	, r.title AS CollectionTitle
	, series.subdivisionIdentifier AS SeriesTitle
	, series.title AS SeriesTitle
	, rc.title AS ComponentTitle
	, ArchDescriptionInstances.resourceComponentId
	, DigitalObjects.version AS DigitalObjectVersion
	, DigitalObjects.title
	, DigitalObjects.dateExpression
	, DigitalObjects.languageCode
	, DigitalObjects.restrictionsApply
	, DigitalObjects.eadDaoActuate
	, DigitalObjects.eadDaoShow
	, DigitalObjects.metsIdentifier
	, DigitalObjects.objectType
	, DigitalObjects.label
	, DigitalObjects.objectOrder
	, DigitalObjects.componentId
	, DigitalObjects.parentDigitalObjectId
	, DigitalObjects.archDescriptionInstancesId
	, DigitalObjects.digitalObjectId AS DOdigitalObjectID
	, FileVersions.digitalObjectId AS fvVersionObjectId
	, FileVersions.version AS FileVersionVersion
	, FileVersions.uri
	, FileVersions.useStatement
	, FileVersions.sequenceNumber
	, FileVersions.eadDaoActuate AS FileVersionDaeActuate
	, FileVersions.eadDaoShow AS FileVersionDaoShow
FROM DigitalObjects 
	LEFT OUTER JOIN
	FileVersions 
	ON FileVersions.digitalObjectId = DigitalObjects.digitalObjectId 
	LEFT OUTER JOIN
	ArchDescriptionInstances 
	ON DigitalObjects.archDescriptionInstancesId = ArchDescriptionInstances.archDescriptionInstancesId 
	INNER JOIN
	ResourcesComponents rc 
	ON ArchDescriptionInstances.resourceComponentId = rc.resourceComponentId 
	INNER JOIN
	Resources r 
	ON r.resourceId = getResourceFromComponent(rc.resourceComponentId)
	LEFT OUTER JOIN 
	ResourcesComponents series
	ON getTopComponent(rc.resourceComponentId) = series.resourceComponentID
