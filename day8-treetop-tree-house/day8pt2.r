# max function because NAs break built-in max
my.max <- function(x) ifelse( !all(is.na(x)), max(x, na.rm=T), NA)

my.find_next <- function(x, l) {
	# find x in l
	l <- array(l)
	distance <- 0
	#print(x)
	#print(l[1])
	#print(length(l))
	if (length(l) == 1) {
		distance <- 1
	} else {
		i <- 1 # index
		blocked <- 0
		#print(i, paste(length(l), l[i], x))
		while((i <= length(l)) & (blocked == 0)) {
			if (l[i] >= x) {
				blocked <- 1
			}
			distance <- distance + 1
			i <- i + 1
		}
	}
	return (distance)
} 

mat <- readLines(con=stdin())
mat <- lapply(mat, strsplit, "")
mat <- matrix(unlist(mat), ncol=99)

#trees <- ((nrow(mat) - 1) * 2) + ((nrow(mat) - 1) * 2)
max_score <- 0

for (y in 2:(nrow(mat)-1)) {
	for (x in 2:(ncol(mat)-1)) {
		#print(paste("x=", x, ", y=", y))
		col <- mat[x, ]
		row <- mat[, y]
		
		tree <- mat[x,y]
		#print(tree)

		dirs <- array()
		# up
		#dirs[1] <- my.max(row[c(1:(x-1))])
		#print(rev(row[c(1:(x-1))]))
		up <- (my.find_next(tree, rev(row[c(1:(x-1))])))
		# down
		#dirs[2] <- my.max(row[c((x+1):nrow(mat))])
		#print(row[c((x+1):nrow(mat))])
		down <- (my.find_next(tree, row[c((x+1):nrow(mat))]))
		# left
		#dirs[3] <- my.max(col[c(1:(y-1))])
		#print(rev(col[c(1:(y-1))]))
		left <- (my.find_next(tree, rev(col[c(1:(y-1))])))
		# right
		#dirs[4] <- my.max(col[c((y+1):ncol(mat))])
		#print(col[c((y+1):ncol(mat))])
		right <- (my.find_next(tree, col[c((y+1):ncol(mat))]))
		
		#trees <- trees + ifelse(min(unlist(dirs)) < tree, 1, 0)
		#print(paste(up, down, left, right))
		score <- up * down * left * right
		if (score > max_score) {
			max_score <- score
		}
	}
}

print(paste("Best score (pt2): ", max_score))
