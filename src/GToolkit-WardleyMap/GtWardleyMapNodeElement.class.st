Class {
	#name : #GtWardleyMapNodeElement,
	#superclass : #BlElement,
	#traits : 'TGtWithWardleyMapNodeViewModel',
	#classTraits : 'TGtWithWardleyMapNodeViewModel classTrait',
	#instVars : [
		'labelElement',
		'labelContainer'
	],
	#category : #'GToolkit-WardleyMap-! Views'
}

{ #category : #initialization }
GtWardleyMapNodeElement >> initialize [
	super initialize.

	self geometry: BlEllipseGeometry new.
	self clipChildren: false.
	
	self layout: BlFrameLayout new.
	
	labelElement := BrEditableLabel new
		fitContent;
		look: (BrGlamorousRegularEditorLook new);
		when: BrEditorAcceptWish do: [ :aWish | 
			self wardleyMapNodeViewModel label: aWish text asString ];
		text: 'Label'.

	"we have to wrap the editable label in a pullable element to allow text selection with drag"
	labelContainer := BrHorizontalPane new
		fitContent;
		addEventHandler: (GtWardleyMapPullHandler new
			containerElement: self;
			whenPulled: [ :aPulledElement :aNormalizedPosition | self wardleyMapNodeViewModel moveNodeLabelTo: aNormalizedPosition ]);
		addChild: labelElement.

	self addChild: labelContainer.
	
	self addLook: (BrStyleCommonLook new
		focused: [ :s | s border: (BlBorder paint: (BrGlamorousColors focusedEditorBorderColor) width: 1) ]).

	self when: BlClickEvent do: [ :anEvent |
		(anEvent modifiers isPrimaryModifier not and: [ anEvent target = self ])
			ifTrue: [
				anEvent consumed: true.
				self requestFocus ] ].

	self addShortcut: (BlShortcutWithAction new
		combination: BlKeyCombination backspace;
		action: [ :anEvent | anEvent currentTarget wardleyMapNodeViewModel removeFromMap ]).
	self addShortcut: (BlShortcutWithAction new
		combination: BlKeyCombination builder primary minus build;
		action: [ :anEvent | anEvent currentTarget wardleyMapNodeViewModel decreaseNodeSize ]).
	self addShortcut: (BlShortcutWithAction new
		combination: BlKeyCombination builder primary equal build;
		action: [ :anEvent | anEvent currentTarget wardleyMapNodeViewModel increaseNodeSize ])
]

{ #category : #'event handling' }
GtWardleyMapNodeElement >> onNodeColored [
	self background: self wardleyMapNodeViewModel nodeColor.
	labelElement look foreground: self wardleyMapNodeViewModel labelColor.
]

{ #category : #'event handling' }
GtWardleyMapNodeElement >> onNodeLabelMoved [
	labelContainer constraintsDo: [ :c |
		c frame horizontal alignCenterAt: self wardleyMapNodeViewModel labelCoordinateX.
		c frame vertical alignCenterAt: self wardleyMapNodeViewModel labelCoordinateY ]
]

{ #category : #'event handling' }
GtWardleyMapNodeElement >> onNodeLabelTextChanged [
	labelElement text: self wardleyMapNodeViewModel label
]

{ #category : #'event handling' }
GtWardleyMapNodeElement >> onNodeResized [
	self size: self wardleyMapNodeViewModel nodeSize
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodeElement >> onWardleyMapNodeViewModelChanged [
	"Is sent when a new WardleyMapNode view model is assigned to the element"
	
	self onNodeResized.
	self onNodeColored.

	self onNodeLabelTextChanged.
	self onNodeLabelMoved
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodeElement >> subscribeToWardleyMapNodeViewModel [
	"Is sent after a new WardleyMapNode view model is assigned to the element.
	It is required to unsubscribe from the view model or domain model by implementing
	#unsubscribeFromWardleyMapNodeViewModel if elements subscribe to them"
	
	self wardleyMapNodeViewModel weak
		when: GtWardleyMapNodeViewModelLabelMoved send: #onNodeLabelMoved to: self;
		when: GtWardleyMapNodeViewModelLabelTextChanged send: #onNodeLabelTextChanged to: self;
		when: GtWardleyMapNodeViewModelColored send: #onNodeColored to: self;
		when: GtWardleyMapNodeViewModelResized send: #onNodeResized to: self
]

{ #category : #'api - wardley map node view model' }
GtWardleyMapNodeElement >> unsubscribeFromWardleyMapNodeViewModel [
	"Is sent before a new WardleyMapNode view model is assigned to the element.
	Elements that subscribe to WardleyMapNode view model in domain model are required to implement this methods"
	
	self wardleyMapNodeViewModel unsubscribe: self
]
