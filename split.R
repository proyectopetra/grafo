library(igraph)

plot(traffic.wifi, layout = layout.fruchterman.reingold,
      vertex.size = betweenness(traffic.wifi)+5,
      vertex.color="gray",
      vertex.frame.color= "white",
      vertex.label.color = "blue",
      vertex.label.family = "sans",
      edge.width=log(E(traffic.graph)$weight),  
      edge.color="black")

plot(traffic.bt, layout = layout.fruchterman.reingold,
      vertex.size = betweenness(traffic.bt)+5,
      vertex.color="yellow",
      vertex.frame.color= "green",
      vertex.label.color = "blue",
      vertex.label.family = "sans",
      edge.width=log(E(traffic.graph)$weight),  
      edge.color="black")





