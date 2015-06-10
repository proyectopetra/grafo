library(igraph)

traffic.data <- read.graph("traffic-graph.csv",format='edgelist')
traffic.graph <- graph.empty(n=0)

for (i in 1:nrow(traffic.data)) {
    traffic.graph <- traffic.graph + vertices(traffic.data[i,"node_1"])
    traffic.graph <- traffic.graph + vertices(traffic.data[i,"node_2"])
    traffic.graph <- add.edges( traffic.graph,
                               c(traffic.data[i,"node_1"],traffic.data[i,"node_2"]))
}

 plot(traffic.graph, layout = layout.fruchterman.reingold,
      vertex.size = 25,
      vertex.color="red",
      vertex.frame.color= "white",
      vertex.label.color = "white",
      vertex.label.family = "sans",
      edge.width=2,  
      edge.color="black")
