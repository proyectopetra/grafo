library(igraph)

traffic.data <- read.csv("../Datasets2014/raw_ampliado.csv",colClasses=c(rep("character",2),rep("numeric",5),rep("character",4)))
traffic.graph <- graph.empty(n=0, directed=TRUE)

for (i in 1:nrow(traffic.data)) {
    print(traffic.data[i, "idDispositivo"])
}
