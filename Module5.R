#################################################################
#
# date: February , 2021
# platform: Ubuntu 18.04
# R.version : 4.1.2
# author: Villemin Jean-Philippe
# team: Qbio
#
# Module4.R
# Usage : 
# 
# Rscript Module4.R --file=Path2YourDataset
#
# Call R from python to make some figures
# Read the file with your get_dataset_names
#
#################################################################

#suppressWarnings(suppressMessages())
library(ggplot2) # THE PLOTTING LIBRARY YOU WANT IN YOUR LIFE.
library(data.table) # library to read your data fast
library(optparse) # https://www.r-bloggers.com/2015/09/passing-arguments-to-an-r-script-from-command-lines/
####################################################################################
######################### Parameters  ##############################################
####################################################################################

option_list = list(
  make_option(c("-f", "--file"), type="character", default=NULL, help="Absolute file input path", metavar="character")
)
parser    = OptionParser(usage = "%prog [options] file ",option_list=option_list);
arguments = parse_args(parser, positional_arguments = 0);
opt <- arguments$options

################################################################################################
#########         MAIN                     #####################################################
### https://www.publichealth.columbia.edu/sites/default/files/media/fdawg_ggplot2.html
### https://www.kaggle.com/leolcling/visualizing-iris-datasets-with-r-ggplot2
################################################################################################

print("Let's do this")
print(opt$file)
data.Iris <-fread(opt$file,data.table = F)
head(data.Iris)

png(file = "./figure/R.histogram.png",width = 500,height = 400)
ggplot(data=data.Iris,aes(x=sepal_length,fill=species)) + geom_histogram(color="black") +theme_minimal() +facet_wrap(~species)
dev.off()

png(file = "./figure/R.pointSmooth.png",width = 500,height = 400)
ggplot(data=data.Iris,aes(x=sepal_width, y=sepal_length,color=species)) + geom_point() +geom_smooth(se=FALSE)+
 theme_minimal()
dev.off()

png(file = "./figure/R.boxplot.png",width = 500,height = 400)
ggplot(data=data.Iris,aes(x=species, y=petal_length,color=species)) + geom_boxplot() + theme_minimal() +
theme(legend.position="none")
dev.off()

scatter <- ggplot(data=data.Iris, aes(x = sepal_length, y = sepal_width)) 

png(file = "./figure/R.scatter.Gradient.png",width = 500,height = 400)
scatter + geom_point(aes(color = petal_width, shape = species), size = 2, alpha = I(1/2)) +
          geom_vline(aes(xintercept = mean(sepal_length)), color = "red", linetype = "dashed") +
          geom_hline(aes(yintercept = mean(sepal_width)), color = "red", linetype = "dashed") +
          scale_color_gradient(low = "yellow", high = "red") +
          xlab("Sepal Length") +  ylab("Sepal Width") +
          ggtitle("Sepal Length-Width")
dev.off()


