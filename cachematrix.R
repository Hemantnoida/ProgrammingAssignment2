##
## Hemant Vemrma
## ProgrammingAssignment2
##

## makecacheMatrix: This function creates a special "matrix" object
## that can cache its inverse creates and returns a list of functions
## and it is used by cacheSolve to get or set the inverted matrix in cache
makeCacheMatrix <- function(x = matrix()) {
    # stores the cached value and initialize to NULL
    cache <- NULL
    
    # create the matrix 
    set <- function(y) {
        x <<- y
        cache <<- NULL
    }
    
    # get the value of the matrix
    get <- function() x
    # invert the matrix and store in cache
    setMatrix <- function(inverse) cache <<- inverse
    # get the inverted matrix from cache
    getInverse <- function() cache
    
    list(set = set, get = get,
         setMatrix = setMatrix,
         getInverse = getInverse)
}


## cacheSolve :This function computes the inverse of the special "matrix" 
## returned by makeCacheMatrix above

cacheSolve <- function(x, ...) {
    ## attempt to get the inverse of the matrix stored in cache
    cache <- x$getInverse()
    
    # return inverted matrix from cache if it exists
    # else create the matrix in working environment
    if (!is.null(cache)) {
        message("getting cached data")
        
        # display matrix in console
        return(cache)
    }
    
    # create matrix since it does not exist
    matrix <- x$get()
    
    # make sure matrix is square and invertible
    # if not, handle exception cleanly
    tryCatch( {
        # set and return inverse of matrix
        cache <- solve(matrix, ...)
    },
    error = function(e) {
        message("Error:")
        message(e)
        
        return(NA)
    },
    warning = function(e) {
        message("Warning:")
        message(e)
        
        return(NA)
    },
    finally = {
        # set inverted matrix in cache
        x$setMatrix(cache)
    } )
    
    # display matrix in console
    return (cache)
}
