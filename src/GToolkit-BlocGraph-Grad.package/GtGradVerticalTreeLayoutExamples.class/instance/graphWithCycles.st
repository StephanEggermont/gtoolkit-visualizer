example
graphWithCycles
	<gtExample>
		
	| view theNodes aTreeLayout theNodePositions theNodeExtents |
	
	view := self view.
	aTreeLayout := self treeLayout.
	theNodes := self constructGraphWithCycles key.
	view addChildren: theNodes.
	
	view layout: aTreeLayout.
	view forceLayout. 
	
   theNodeExtents := theNodes collect: [ :aNode | aNode extent ].
	theNodePositions := theNodes collect: [ :aNode | aNode position ].
	
	self assert: theNodeExtents asArray equals: (7 timesCollect: [ self nodeExtent ]).

	^ view