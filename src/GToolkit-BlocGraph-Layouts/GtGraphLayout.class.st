"
Subclass me to port Roassal layout
"
Class {
	#name : #GtGraphLayout,
	#superclass : #BlFitLayout,
	#traits : 'TGtGraphLayoutUtils',
	#classTraits : 'TGtGraphLayoutUtils classTrait',
	#instVars : [
		'affectedNodes',
		'translator'
	],
	#category : 'GToolkit-BlocGraph-Layouts-Basic'
}

{ #category : #constraints }
GtGraphLayout class >> constraints [
	^ GtGraphConstraints new
]

{ #category : #hook }
GtGraphLayout >> applyOn: elements [
	"Return quickly if there is nothing to do"
	(elements isEmpty)
		ifTrue: [ ^ self ].
	self executeOnElements: elements
]

{ #category : #hook }
GtGraphLayout >> doExecute: elements [
	"Performs the layout"

	self subclassResponsibility
]

{ #category : #hook }
GtGraphLayout >> doInitialize: elements [
	"Method executed before beginning the layout. Useful when the graph to be ordered need to be prepared"
	"self announce: (ROLayoutBegin new elements: elements)."
]

{ #category : #hook }
GtGraphLayout >> doPost: elements [
	"Method executed after performing the layout"
	"self announce: (ROLayoutEnd new elements: elements)."
]

{ #category : #hook }
GtGraphLayout >> executeOnElements: elements [ 
	"Execute the layout, myself, on the elements"
		
	self doInitialize: elements.
	self doExecute: elements.
	self doPost: elements
]

{ #category : #geometry }
GtGraphLayout >> groupBounds: aCollectionOfElements [
	"Return encompassing bounds of a collection of elements"

	^ (aCollectionOfElements 
		ifEmpty: [ (0 @ 0) corner: (0 @ 0) ]
		ifNotEmpty: [ Rectangle merging: (aCollectionOfElements collect: [ :anElement | anElement measuredBounds asRectangle ]) ])
]

{ #category : #initialization }
GtGraphLayout >> initialize [
	super initialize.
	translator := GtGraphLayoutTranslator default
]

{ #category : #layout }
GtGraphLayout >> measurePositions: anElement with: anExtentSpec [
	
	self applyOn: (anElement children select: [ :aChild | aChild constraints ignoredByLayout not ])
]

{ #category : #hook }
GtGraphLayout >> on: elements [
	self applyOn: elements
]

{ #category : #hook }
GtGraphLayout >> on: elements edges: edges [
	self applyOn: elements
]

{ #category : #hook }
GtGraphLayout >> step [
"	currentIteraction := currentIteraction + 1.
	(currentIteraction \\ self iterationsToSendEvent) = 0 
		ifTrue: [ self announce: (ROLayoutStep new 
											currentIteration: currentIteraction;
											maxInterations: maxInterations) ].
	"
]

{ #category : #accessing }
GtGraphLayout >> translator [
	^ translator
]

{ #category : #accessing }
GtGraphLayout >> translator: t [
	translator := t
]

{ #category : #hook }
GtGraphLayout >> userDefinedEdges: edges [
	"Do nothing"
]