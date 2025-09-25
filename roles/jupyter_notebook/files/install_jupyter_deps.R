.libPaths( c( .libPaths(), "~/R/x86_64-redhat-linux-gnu-library/3.6") )
install.packages('IRkernel', lib='~/R/x86_64-redhat-linux-gnu-library/3.6' ,repos='http://cran.us.r-project.org')
IRkernel::installspec()