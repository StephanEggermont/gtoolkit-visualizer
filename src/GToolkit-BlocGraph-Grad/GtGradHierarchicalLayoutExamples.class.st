Class {
	#name : #GtGradHierarchicalLayoutExamples,
	#superclass : #GtGradLayoutExamples,
	#category : #'GToolkit-BlocGraph-Grad-Examples'
}

{ #category : #examples }
GtGradHierarchicalLayoutExamples >> layout [
	self subclassResponsibility
]

{ #category : #examples }
GtGradHierarchicalLayoutExamples >> simpleExample [
	| view theNodes aLayout pairsOfNodes |
	
	"At this moment, this examples will not result in anything
	Just a way of gradually testing the code and making sure that
	nothing explodes"
	view := self view.
	aLayout := self layout.
	theNodes := self nodes: (1 to: 7). 
	theNodes doWithIndex: [ :node :index |
			node labeled: (index asString).
	].
	
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (2->3); add: (3->4);
					 add: (2->5); add: (5->6); add: (6->7);
					 add: (7-> 3).
	self connectPairsOfNodes: theNodes pairs: pairsOfNodes.

	view addChildren: theNodes.
	view layout: aLayout.
	view forceLayout. 
	
	^ view
]

{ #category : #examples }
GtGradHierarchicalLayoutExamples >> simpleExampleDsiconnectedGraph [
	| view theNodes aLayout pairsOfNodes |
	
	"At this moment, this examples will not result in anything
	Just a way of gradually testing the code and making sure that
	nothing explodes"
	view := self view.
	aLayout := self layout.
	theNodes := self nodes: (1 to: 7). 
	theNodes doWithIndex: [ :node :index |
			node labeled: (index asString).
	].
	
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (2->3); add: (3->4);
					 add: (5->6); add: (6->7).
	self connectPairsOfNodes: theNodes pairs: pairsOfNodes.

	view addChildren: theNodes.
	view layout: aLayout.
	view forceLayout. 
	
	^ view
]

{ #category : #examples }
GtGradHierarchicalLayoutExamples >> simpleExampleWhereAllNodesHaveIncomingEdges [
	| view theNodes aLayout pairsOfNodes |
	
	"At this moment, this examples will not result in anything
	Just a way of gradually testing the code and making sure that
	nothing explodes"
	view := self view.
	aLayout := self layout.
	theNodes := self nodes: (1 to: 5). 
	theNodes doWithIndex: [ :node :index |
			node labeled: (index asString).
	].
	
	pairsOfNodes := OrderedCollection new.
	pairsOfNodes add: (1->2); add: (2->3); add: (3->4); add: (4->5); add: (4->2);
					 add: (1->5); add: (2->5); add: (4->1).
	self connectPairsOfNodes: theNodes pairs: pairsOfNodes.

	view addChildren: theNodes.
	view layout: aLayout.
	view forceLayout. 
	
	^ view
]