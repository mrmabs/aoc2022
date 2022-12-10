# max function because NAs break built-in max
my.max <- function(x) ifelse( !all(is.na(x)), max(x, na.rm=T), NA)

mat <- readLines(con=stdin())
mat <- lapply(mat, strsplit, "")
mat <- matrix(unlist(mat), ncol=99)

trees <- ((nrow(mat) - 1) * 2) + ((nrow(mat) - 1) * 2)

for (y in 2:(nrow(mat)-1)) {
	for (x in 2:(ncol(mat)-1)) {
		#print(paste("x=", x, ", y=", y))
		col <- mat[x, ]
		row <- mat[, y]
		
		tree <- mat[x,y]

		dirs <- array()
		# up
		dirs[1] <- my.max(row[c(1:(x-1))])
		# down
		dirs[2] <- my.max(row[c((x+1):nrow(mat))])
		# left
		dirs[3] <- my.max(col[c(1:(y-1))])
		# right
		dirs[4] <- my.max(col[c((y+1):ncol(mat))])
		
		trees <- trees + ifelse(min(unlist(dirs)) < tree, 1, 0)
	}
}

print(paste("Trees (pt1): ", trees))
