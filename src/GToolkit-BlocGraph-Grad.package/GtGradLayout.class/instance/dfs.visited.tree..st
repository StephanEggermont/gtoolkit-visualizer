measure
dfs: theCurrentNode visited: aVisitedList tree: aDFSTree
	aVisitedList add: theCurrentNode.
	
	(theCurrentNode graph connectedNodesAlongOutgoingEdges) do: [ :aConnectedNode |
			(aVisitedList includes: aConnectedNode)
				ifFalse:[
					aDFSTree at: theCurrentNode ifAbsentPut: [ OrderedCollection new ].  
					(aDFSTree at: theCurrentNode) add: aConnectedNode.
					self dfs: aConnectedNode
								 visited: aVisitedList
								 tree: aDFSTree.
			].
	].