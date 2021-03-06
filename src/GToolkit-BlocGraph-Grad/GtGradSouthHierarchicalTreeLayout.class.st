Class {
	#name : #GtGradSouthHierarchicalTreeLayout,
	#superclass : #GtGradHierarchicalTreeLayout,
	#category : #'GToolkit-BlocGraph-Grad-Layouts'
}

{ #category : #'private - layout' }
GtGradSouthHierarchicalTreeLayout >> constructLayoutAlgorithm: anElementsCollection [
	(self isATreeOrHasLessThanMaxBackEdges: anElementsCollection)
		ifTrue: [ 
			| treeAlignment |
			treeAlignment := self alignment constructTreeAlignment.
			^ GtGradVerticalDominanceTreeLayout new
												 levelDistance: self levelDistance;
												 nodeDistance: self nodesDistance;
												 treesDistance: self componentsDistance;
												 reverse: true;
												 nodesAlignment: treeAlignment.
		]
		ifFalse: [ 
			| hierarchicalAlignment |
			hierarchicalAlignment := self alignment constructHierarchicalAlignment.
			^ GtGradSouthHierarchicalLayout new
												 interRanksSpacing: self levelDistance;
												 intraRankSpacing: self nodesDistance;
												 interHierarchySpacing: self componentsDistance;
												 alignment: hierarchicalAlignment.
		].
]
