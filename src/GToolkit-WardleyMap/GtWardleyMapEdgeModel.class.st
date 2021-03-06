Class {
	#name : #GtWardleyMapEdgeModel,
	#superclass : #Object,
	#traits : 'TGtAnnouncer + TGtWardleyMapWithParent + TGtWardleyMapWithColor + TGtWardleyMapWithArrow + TGtWardleyMapWithWidth + TGtWardleyMapExportable + TGtWardleyMapVisitable',
	#classTraits : 'TGtAnnouncer classTrait + TGtWardleyMapWithParent classTrait + TGtWardleyMapWithColor classTrait + TGtWardleyMapWithArrow classTrait + TGtWardleyMapWithWidth classTrait + TGtWardleyMapExportable classTrait + TGtWardleyMapVisitable classTrait',
	#instVars : [
		'announcer',
		'fromNode',
		'toNode'
	],
	#category : #'GToolkit-WardleyMap-! Models'
}

{ #category : #comparing }
GtWardleyMapEdgeModel >> = anObject [
	"Answer whether the receiver and anObject represent the same object."

	self == anObject
		ifTrue: [ ^ true ].
	self class = anObject class
		ifFalse: [ ^ false ].
	^ toNode = anObject toNode and: [ fromNode = anObject fromNode ]
]

{ #category : #visiting }
GtWardleyMapEdgeModel >> accept: aWardleyMapVisitor [
	^ aWardleyMapVisitor visitWardleyMapEdge: self
]

{ #category : #announcer }
GtWardleyMapEdgeModel >> announcer [
	<return: #Announcer>

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
GtWardleyMapEdgeModel >> fromNode [
	^ fromNode
]

{ #category : #accessing }
GtWardleyMapEdgeModel >> fromNode: anObject [
	fromNode := anObject
]

{ #category : #comparing }
GtWardleyMapEdgeModel >> hash [
	"Answer an integer value that is related to the identity of the receiver."

	^ toNode hash bitXor: fromNode hash
]

{ #category : #initialization }
GtWardleyMapEdgeModel >> initialize [
	super initialize.
	
	color := Color gray.
	width := 1.0.
	arrow := false
]

{ #category : #'api - arrow' }
GtWardleyMapEdgeModel >> notifyArrowChanged [
	self propagateAnnouncement: (GtWardleyMapEdgeModelArrowChanged new edgeModel: self)
]

{ #category : #'api - color' }
GtWardleyMapEdgeModel >> notifyColored [
	self propagateAnnouncement: (GtWardleyMapEdgeModelColored new edgeModel: self)
]

{ #category : #'api - parent' }
GtWardleyMapEdgeModel >> notifyParentChanged [
	
]

{ #category : #'api - width' }
GtWardleyMapEdgeModel >> notifyWidthChanged [
	self propagateAnnouncement: (GtWardleyMapEdgeModelResized new edgeModel: self)
]

{ #category : #'api - arrow' }
GtWardleyMapEdgeModel >> reverse [
	| temp |
	temp := fromNode.
	fromNode := toNode.
	toNode := temp.
	temp := self parent.
	parent removeEdge: self.
	temp addEdge: self
]

{ #category : #accessing }
GtWardleyMapEdgeModel >> toNode [
	^ toNode
]

{ #category : #accessing }
GtWardleyMapEdgeModel >> toNode: anObject [
	toNode := anObject
]
