library(igraph)

traffic.graph <- read.graph("traffic-graph.graphml",format="graphml")

plot(traffic.graph, layout = layout.fruchterman.reingold,
      vertex.size = 10,
      vertex.color="red",
      vertex.frame.color= "white",
      vertex.label.color = "white",
      vertex.label.family = "sans",
      edge.width=2,  
      edge.color="black")
