"
I represent a projection value  of a domain object on the axis.

Given a Point (20@30) as a domain object and euclidian coordinate system.
Then projection of that point on continuous X-Axis would be 20 and projection on Y-axis would be 30.

A projection of a domain object on discrete axis is an index of that object in a data set
"
Class {
	#name : #GtPlotterAxisProjection,
	#superclass : #GtPlotterAxisValue,
	#instVars : [
		'source'
	],
	#category : 'GToolkit-Plotter-Axis'
}

{ #category : #accessing }
GtPlotterAxisProjection >> source [
	"Return an original domain object that was projected on the axis"
	<return: #GtPlotterDomainObject>

	^ source
]

{ #category : #accessing }
GtPlotterAxisProjection >> source: anObject [
	source := anObject
]