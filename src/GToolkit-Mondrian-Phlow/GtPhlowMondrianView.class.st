Class {
	#name : #GtPhlowMondrianView,
	#superclass : #GtPhlowViewDecorator,
	#instVars : [
		'paintingStencilBuilder',
		'mondrianInstanceBuilder',
		'mondrianInstance',
		'mondrianElement',
		'transformation'
	],
	#category : #'GToolkit-Mondrian-Phlow-View'
}

{ #category : #accessing }
GtPhlowMondrianView >> asElementDo: aBlock [
	| wrapper |
	paintingStencilBuilder value: mondrianInstance.
	wrapper := BrFrame new matchParent.
	mondrianElement := mondrianInstance asPannableElement.
	mondrianElement
		when: BlClickEvent
		do: [ :event | 
			(event target graph isNode or: [ event target graph isEdge ])
				ifTrue: [ 
					| transformedObject |
					transformedObject := transformation cull: event target graph model.
					mondrianElement phlow spawnObject: transformedObject ] ].
	wrapper addChild: mondrianElement.
	self beViewElement: wrapper.
	^ aBlock value: wrapper
]

{ #category : #initialize }
GtPhlowMondrianView >> initialize [
	super initialize.
	mondrianInstance := GtMondrian new.
	paintingStencilBuilder := [ :x | "do nothing by default" ].
	transformation := [ :x | "by default there is no transformation" x ].
	self actionStencil: [ 
		BrButton new 
			look: BrGlamorousButtonWithIconLook;
			icon: BrGlamorousIcons zoomin asElement;
			label: 'Zoom in';
			action: [ mondrianElement zoomIn ] ].
	self actionStencil: [ 
		BrButton new 
			look: BrGlamorousButtonWithIconLook;
			icon: BrGlamorousIcons zoomout asElement ;
			label: 'Zoom out';
			action: [ mondrianElement zoomOut ] ].
	self actionStencil: [ 
		BrButton new 
			look: BrGlamorousButtonWithIconLook;
			icon: BrGlamorousIcons zoomtofit asElement ;
			label: 'Zoom to fit';
			action: [ mondrianElement zoomToFit ] ].
	self actionStencil: [ 
		BrButton new
			look: BrGlamorousButtonWithIconLook;
			label: 'Reset to actual size';
			icon: BrGlamorousIcons actualsize asElement;
			action: [ mondrianElement zoomToActualSize ] ]
	
]

{ #category : #scripting }
GtPhlowMondrianView >> initialize: aMondrian [
	mondrianInstance := aMondrian
]

{ #category : #scripting }
GtPhlowMondrianView >> painting: aBlock [
	paintingStencilBuilder := aBlock
]

{ #category : #scripting }
GtPhlowMondrianView >> send: aBlock [
	transformation := aBlock
]

{ #category : #accessing }
GtPhlowMondrianView >> updateContent: aCurrentElement [
	self initialize: GtMondrian new.
	self asElementDo: [ :aWrapper |
		| aChild |
		aChild := (aWrapper childAt: 1).
		aChild removeFromParent.
		aCurrentElement enqueueTask: (BlTaskAction new
			action: [ 
				aCurrentElement removeChildren.
				aCurrentElement addChild: aChild ]) ].
]
